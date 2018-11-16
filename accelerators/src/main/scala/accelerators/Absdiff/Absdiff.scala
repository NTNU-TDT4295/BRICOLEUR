package accelerators.Absdiff

import chisel3._
import helpers.FIFO.FIFOAltUInt

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
    // tdata signal from here routes to threshold input signal
    val tdata = Output(UInt(8.W))
    // tvalidOut signal from here routes to Threshold tvalid signal
    val tvalidOut = Output(Bool())
    // treadyOut signal from here routes to Gaussian Blur tready signal
    val treadyOut = Output(Bool())
  })

  // Registers
  val result = RegInit(UInt(8.W), 0.U)

  // Booleans
  val startCalculating = RegInit(Bool(), false.B)

  // Queues
  val queue = Module(new FIFOAltUInt(width * height, dataWidth, binaryPoint))

  // Initialization
  io.tdata := 0.U
  io.tvalidOut := false.B
  io.treadyOut := true.B
  queue.io.dataIn := io.dataIn
  queue.io.pushing := false.B

  when(io.tvalidIn) {
    // Checking this boolean value before setting it will make it wait a cycle
    when(startCalculating) {
      when(queue.io.dataOut > io.dataIn) {
        result := queue.io.dataOut - io.dataIn
      }.otherwise {
        result := io.dataIn - queue.io.dataOut
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

    queue.io.pushing := true.B
    queue.io.dataIn := io.dataIn
  }
}
