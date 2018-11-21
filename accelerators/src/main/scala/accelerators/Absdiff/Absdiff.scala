package accelerators.Absdiff

import chisel3._
import chisel3.util.Counter

/**
  * Perform the absolute difference between two images
  * It will first fill up the queue with values from Gaussian Blur, and then when the io.lastOut
  * signal is asserted from Gaussian Blur, it will perform the operation and send out a value.
  *
  * @param width       : Width of image from Gaussian Blur, which is less than the original
  * @param height      : Height of image from Gaussian Blur, which is less than the original
  * @param dataWidth   : Data width of signal, same as output from Gaussian Blur
  * @param binaryPoint : Binary point of signal, same as ouput from Gaussian Blur
  */
class Absdiff(width: Int, height: Int, dataWidth: Int, binaryPoint: Int) extends Module {
  val io = IO(new Bundle {
    // lastOut signal from Gaussian Blur routes to this lastIn signal
    val lastIn = Input(Bool())
    // tdata signal from Gaussian Blur routes to this dataIn signal
    val dataIn = Input(UInt(8.W))
    // tvalid signal from Gaussian Blur routes to this tvalidIn signal
    val tvalidIn = Input(Bool())
    // treadyIn
    val treadyIn = Input(Bool())
    // tdata signal from here routes to threshold input signal
    val tdata = Output(UInt(8.W))
    // tvalidOut signal from here routes to Threshold tvalid signal
    val tvalidOut = Output(Bool())
    // treadyOut signal from here routes to Gaussian Blur tready signal
    val treadyOut = Output(Bool())
    // lastOut
    val lastOut = Output(Bool())
  })

  // Registers
  val result = RegInit(UInt(8.W), 0.U)
  val dataOut = Wire(UInt(dataWidth.W))
  val previousAddr = Wire(UInt(dataWidth.W))

  // Booleans
  val startCalculating = RegInit(Bool(), false.B)
  val oneCycleDelay = RegInit(Bool(), false.B)
  val oneWrapDelay = RegInit(Bool(), false.B)
  val isReady = RegInit(Bool(), false.B)

  val addr = Counter(width * height)
  val memory = Mem(width * height, UInt(dataWidth.W))
  dataOut := memory.read(addr.value)

  // Initialization
  io.tdata := 0.U
  io.tvalidOut := false.B
  io.treadyOut := true.B
  io.lastOut := false.B
  previousAddr := 0.U

  when(io.treadyIn) {
    isReady := true.B
  }

  when(io.tvalidIn && (io.treadyIn || isReady)) {
    // Checking this boolean value before setting it will make it wait a cycle
    when(startCalculating) {
      when(dataOut > io.dataIn) {
        result := dataOut - io.dataIn
      }.otherwise {
        result := io.dataIn - dataOut
      }

      // Saturation arithmetic, which absdiff has to do, will define a range to operate inside.
      // If a result goes below or above the limits of this range, it's clamped to the respective limit.
      when(result < 0.U) {
        result := 0.U
      }

      when(result > 255.U) {
        result := 255.U
      }

      io.tvalidOut := true.B
      io.tdata := result
    }

    when(!startCalculating) {
      when(io.lastIn) {
        startCalculating := true.B
      }
    }

    // To avoid writing and reading on the same cycle, store the previous address for later
    previousAddr := addr.value
    when(addr.inc()) {
      oneWrapDelay := true.B
    }
  }

  when(addr.value === 0.U && oneWrapDelay) {
    io.lastOut := true.B
  }.otherwise {
    io.lastOut := false.B
  }

  when(oneCycleDelay) {
    memory.write(previousAddr, io.dataIn)
  }

  when(!oneCycleDelay) {
    oneCycleDelay := true.B
  }
}
