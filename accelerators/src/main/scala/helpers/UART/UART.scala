package helpers.UART

import chisel3._
import chisel3.util._

/**
  * This is a minimal AXI style data plus handshake channel.
  */
class Channel extends Bundle {
  // Data that are received in parallell from some data bus.
  val data = Input(Bits(8.W))
  // Output signal from this component saying if we are ready to receive data form the bus
  val ready = Output(Bool())
  // Input signal from bus saying whether or not there are valid data on the bus
  val valid = Input(Bool())
}

/**
  * Transmitter part of the UART communication
  *
  * @param frequency : don't know which kind of frequency this is
  * @param baudRate  : measure of the speed of data transfer, bps. receiver and transmitter must operate within 10%
  *                  of each other
  */
class Tx(frequency: Int, baudRate: Int) extends Module {
  val io = IO(new Bundle {
    // Output signal, will send each input data bit from channel serially through this.
    val txd = Output(Bits(1.W))
    // The connection between the transmitter and the data bus
    val channel = new Channel()
  })

  val BIT_CNT: UInt = ((frequency + baudRate / 2) / baudRate - 1).asUInt()

  val shiftReg = RegInit(0x7ff.U)
  val countReg = RegInit(0.U(20.W))
  val bitsReg = RegInit(0.U(4.W))

  io.channel.ready := (countReg === 0.U) && (bitsReg === 0.U)
  io.txd := shiftReg(0)

  when(countReg === 0.U) {
    countReg := BIT_CNT
    when(bitsReg =/= 0.U) {
      val shift = shiftReg >> 1
      shiftReg := Cat(1.U, shift(9, 0))
      bitsReg := bitsReg - 1.U
    }.otherwise {
      when(io.channel.valid) {
        // At this point we have valid data from the channel (connected to the data bus).
        // When not transmitting data, a high signal should constantly be outputed.
        // When we want to start sending data, go from high to low (0 is then the start bit).
        // Then the data are sent serially, then two high values are used as stop bits.
        // Note: 3.U is the same as two consequtive high values (11 = 2^1  + 2^0 = 3).
        // TODO: Figure out why the order of bits are reversed here. I would expect (0.U, io.channel.data, 3.U)!
        shiftReg := Cat(Cat(3.U, io.channel.data), 0.U) // two stop bits, data, one start bit
        bitsReg := 11.U
      }.otherwise {
        shiftReg := 0x7ff.U
      }
    }
  }.otherwise {
    // Count down from 20 and down to 0.
    countReg := countReg - 1.U
  }
}

/**
  * Receive part of the UART.
  * A minimal version without any additional buffering.
  * Use an AXI like valid/ready handshake.
  *
  * The following code is inspired by Tommy's receive code at:
  * https://github.com/tommythorn/yarvi
  */
class Rx(frequency: Int, baudRate: Int) extends Module {
  val io = IO(new Bundle {
    val rxd = Input(Bits(1.W))
    val channel = Flipped(new Channel())
  })

  val BIT_CNT: UInt = ((frequency + baudRate / 2) / baudRate - 1).U
  val START_CNT: UInt = ((3 * frequency / 2 + baudRate / 2) / baudRate - 1).U

  // Sync in the asynchronous RX data
  val rxReg = RegNext(RegNext(io.rxd))

  val shiftReg = RegInit('A'.U(8.W))
  val cntReg = RegInit(0.U(20.W))
  val bitsReg = RegInit(0.U(4.W))
  val valReg = RegInit(false.B)

  when(cntReg =/= 0.U) {
    cntReg := cntReg - 1.U
  }.elsewhen(bitsReg =/= 0.U) {
    cntReg := BIT_CNT
    shiftReg := Cat(rxReg, shiftReg >> 1)
    bitsReg := bitsReg - 1.U
    // the last shifted in
    when(bitsReg === 1.U) {
      valReg := true.B
    }
  }.elsewhen(rxReg === 0.U) { // wait 1.5 bits after falling edge of start
    cntReg := START_CNT
    bitsReg := 8.U
  }

  when(io.channel.ready) {
    valReg := false.B
  }

  io.channel.data := shiftReg
  io.channel.valid := valReg
}

/**
  * A single byte buffer with an AXI style channel
  */
class Buffer extends Module {
  val io = IO(new Bundle {
    val in = new Channel()
    val out = Flipped(new Channel())
  })

  val empty :: full :: Nil = Enum(2)
  val stateReg = RegInit(empty)
  val dataReg = RegInit(0.U(8.W))

  io.in.ready := stateReg === empty
  io.out.valid := stateReg === full

  when(stateReg === empty) {
    when(io.in.valid) {
      dataReg := io.in.data
      stateReg := full
    }
  }.otherwise { // full, io.out.valid := true
    when(io.out.ready) {
      stateReg := empty
    }
  }
  io.out.data := dataReg
}

/**
  * A transmitter with a single buffer.
  */
class BufferedTx(frequency: Int, baudRate: Int) extends Module {
  val io = IO(new Bundle {
    val txd = Output(Bits(1.W))
    val channel = new Channel()
  })
  val tx = Module(new Tx(frequency, baudRate))
  val buf = Module(new Buffer())

  buf.io.in <> io.channel
  tx.io.channel <> buf.io.out
  io.txd <> tx.io.txd
}

/**
  * Send 'hello'.
  */
class Sender(frequency: Int, baudRate: Int) extends Module {
  val io = IO(new Bundle {
    val txd = Output(Bits(1.W))
  })

  val tx = Module(new BufferedTx(frequency, baudRate))

  io.txd := tx.io.txd

  // This is not super elegant
  val hello = Array[UInt]('H'.U, 'e'.U, 'l'.U, 'l'.U, 'o'.U)
  val text = VecInit(hello)

  val cntReg = RegInit(0.U(3.W))

  tx.io.channel.data := text(cntReg)
  tx.io.channel.valid := cntReg =/= 5.U

  when(tx.io.channel.ready && cntReg =/= 5.U) {
    cntReg := cntReg + 1.U
  }
}

class Echo(frequency: Int, baudRate: Int) extends Module {
  val io = IO(new Bundle {
    val txd = Output(Bits(1.W))
    val rxd = Output(Bits(1.W))
  })
  // io.txd := RegNext(io.rxd)
  val tx = Module(new BufferedTx(frequency, baudRate))
  val rx = Module(new Rx(frequency, baudRate))
  io.txd := tx.io.txd
  rx.io.rxd := io.rxd
  tx.io.channel <> rx.io.channel
  tx.io.channel.valid := true.B
  // tx.io.channel.data := 'H'.U
}

class UARTMain(frequency: Int, baudRate: Int) extends Module {
  val io = IO(new Bundle {
    val rxd = Input(Bits(1.W))
    val txd = Output(Bits(1.W))
  })

  val u = Module(new Sender(frequency, baudRate))
  // val u = Module(new Echo(frequency, baudRate))
  io.txd := u.io.txd
  // u.io.rxd := io.rxd
}

object UARTMain extends App {
  chisel3.Driver.execute(Array("--target-dir", "generated"), () => new UARTMain(50000000, 115200))
}
