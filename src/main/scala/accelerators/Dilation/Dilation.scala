package accelerators.Dilation

import chisel3.{Input, _}
import chisel3.core.FixedPoint
import chisel3.util.Counter
import helpers.FIFO.FIFO

class Dilation(width: Int, height: Int) extends Module {
  // TODO:
  // would be nice to pass kernel constants
  // and kernel size into the Module as a parameter

  // TODO:
  // also pass in data width and binary point values
  // as parameters
  //  - Joakim
  val io = IO(new Bundle {
    val dataIn = Input(FixedPoint(16.W, 8.BP))
    //val clock = Input(Bool())

    // AXI signals
    val tdata = Output(UInt(16.W))
    val tvalid = Output(Bool())
    val tready = Input(Bool())
    val tlast = Output(Bool())
    val tkeep = Output(UInt(4.W))
  })

  io.tkeep := ~0.U
  io.tlast := false.B
  io.tdata := 0.U
  io.tvalid := false.B

  val isReady = RegInit(UInt(1.W), 0.U)

  //Screwy counter logic, idea is to wait until all queues are loaded, then skip a few cycles when at the edge of image by enabling and disabling io.valid
  // When all valid data has been computed, stop asserting the io.valid signal

  // TODO:
  // Rewrite this logic in a more general fashion
  // so we can easily change the kernel size to, say, 5x5 without
  // chaging any code, just the kernel constants
  //  - Joakim
  val counterStart = Counter(1 + 1 + 1 + 1 + width - 3 + 1 + 1 + width - 3 + 1 + 1)
  val counterEdge = Counter(2)
  val endOfOutput = Counter((width - 2) * (height - 2))
  val counterProcess = Counter(8)
  val computationStarted = RegInit(UInt(1.W), 0.U)
  val processWrapped = RegInit(UInt(1.W), 0.U)
  val computationEnded = RegInit(UInt(1.W), 0.U)

  // Save these values, is used in the tester
  val myWidth: Int = width
  val myHeight: Int = height

  // Store the computed kernel snippets in theese registers
  val kernel_0 = RegInit(FixedPoint(16.W, 8.BP), FixedPoint.fromDouble(0.0, 16.W, 8.BP))
  val kernel_1 = RegInit(FixedPoint(16.W, 8.BP), FixedPoint.fromDouble(0.0, 16.W, 8.BP))
  val kernel_2 = RegInit(FixedPoint(16.W, 8.BP), FixedPoint.fromDouble(0.0, 16.W, 8.BP))
  val kernel_3 = RegInit(FixedPoint(16.W, 8.BP), FixedPoint.fromDouble(0.0, 16.W, 8.BP))
  val kernel_4 = RegInit(FixedPoint(16.W, 8.BP), FixedPoint.fromDouble(0.0, 16.W, 8.BP))
  val kernel_5 = RegInit(FixedPoint(16.W, 8.BP), FixedPoint.fromDouble(0.0, 16.W, 8.BP))
  val kernel_6 = RegInit(FixedPoint(16.W, 8.BP), FixedPoint.fromDouble(0.0, 16.W, 8.BP))
  val kernel_7 = RegInit(FixedPoint(16.W, 8.BP), FixedPoint.fromDouble(0.0, 16.W, 8.BP))
  val kernel_8 = RegInit(FixedPoint(16.W, 8.BP), FixedPoint.fromDouble(0.0, 16.W, 8.BP))

  // K[0][0] K[1][0] K[2][0] kernel element 0, 1, 2
  // K[0][1] K[1][1] K[2][1] kernel element 3, 4, 5
  // K[0][2] K[1][2] K[2][2] kernel element 6, 7, 8

  // Kernel constants, look like this:
  // 0 1 0
  // 1 1 1
  // 0 1 0
  val kernelC0: FixedPoint = FixedPoint.fromDouble(0, 16.W, 8.BP)
  val kernelC1: FixedPoint = FixedPoint.fromDouble(1, 16.W, 8.BP)
  val kernelC2: FixedPoint = FixedPoint.fromDouble(0, 16.W, 8.BP)
  val kernelC3: FixedPoint = FixedPoint.fromDouble(1, 16.W, 8.BP)
  val kernelC4: FixedPoint = FixedPoint.fromDouble(1, 16.W, 8.BP)
  val kernelC5: FixedPoint = FixedPoint.fromDouble(1, 16.W, 8.BP)
  val kernelC6: FixedPoint = FixedPoint.fromDouble(0, 16.W, 8.BP)
  val kernelC7: FixedPoint = FixedPoint.fromDouble(1, 16.W, 8.BP)
  val kernelC8: FixedPoint = FixedPoint.fromDouble(0, 16.W, 8.BP)

  //See paper for explanation
  //Idea is deep pipelines
  //These are not much FIFOS as delay_Ns
  val fifo1_0 = Module(new FIFO(1))
  val fifo2_1 = Module(new FIFO(1))
  val fifo3_2 = Module(new FIFO(width - 3))
  val fifo4_3 = Module(new FIFO(1))
  val fifo5_4 = Module(new FIFO(1))
  val fifo6_5 = Module(new FIFO(width - 3))
  val fifo7_6 = Module(new FIFO(1))
  val fifo8_7 = Module(new FIFO(1))

  //Connect inputs and outputs
  fifo8_7.io.dataIn := 0.U.asFixedPoint(8.BP)
  fifo7_6.io.dataIn := 0.U.asFixedPoint(8.BP)
  fifo6_5.io.dataIn := 0.U.asFixedPoint(8.BP)
  fifo5_4.io.dataIn := 0.U.asFixedPoint(8.BP)
  fifo5_4.io.dataIn := 0.U.asFixedPoint(8.BP)
  fifo4_3.io.dataIn := 0.U.asFixedPoint(8.BP)
  fifo3_2.io.dataIn := 0.U.asFixedPoint(8.BP)
  fifo2_1.io.dataIn := 0.U.asFixedPoint(8.BP)
  fifo1_0.io.dataIn := 0.U.asFixedPoint(8.BP)

  when(isReady === 1.U) {
    when(counterStart.inc()) {
      computationStarted := 1.U
    }

    when(computationStarted === 1.U) {

      when(processWrapped === 0.U) {
        when(counterProcess.inc()) {
          processWrapped := 1.U
        }
      }.otherwise {
        when(counterEdge.inc()) {
          processWrapped := 0.U
        }
      }
    }
    when(processWrapped === 0.U && computationStarted === 1.U && computationEnded === 0.U) {
      when(endOfOutput.inc()) {
        computationEnded := 1.U
      }
      io.tvalid := true.B
    }.otherwise {
      io.tvalid := false.B
    }

    fifo8_7.io.dataIn := io.dataIn
    fifo7_6.io.dataIn := fifo8_7.io.dataOut
    fifo6_5.io.dataIn := fifo7_6.io.dataOut
    fifo5_4.io.dataIn := fifo6_5.io.dataOut
    fifo4_3.io.dataIn := fifo5_4.io.dataOut
    fifo3_2.io.dataIn := fifo4_3.io.dataOut
    fifo2_1.io.dataIn := fifo3_2.io.dataOut
    fifo1_0.io.dataIn := fifo2_1.io.dataOut

    // Computing the value of each kernel corner
    kernel_8 := io.dataIn * kernelC8
    kernel_7 := fifo8_7.io.dataOut * kernelC7
    kernel_6 := fifo7_6.io.dataOut * kernelC6
    kernel_5 := fifo6_5.io.dataOut * kernelC5
    kernel_4 := fifo5_4.io.dataOut * kernelC4
    kernel_3 := fifo4_3.io.dataOut * kernelC3
    kernel_2 := fifo3_2.io.dataOut * kernelC2
    kernel_1 := fifo2_1.io.dataOut * kernelC1
    kernel_0 := fifo1_0.io.dataOut * kernelC0

    io.tdata := (
      kernel_0 +
        kernel_1 +
        kernel_2 +
        kernel_3 +
        kernel_4 +
        kernel_5 +
        kernel_6 +
        kernel_7 +
        kernel_8).asUInt()
  }

  when(io.tready) {
    isReady := 1.U
  }
}
