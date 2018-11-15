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
    val lastIn = Input(Bool())
    val input = Input(UInt(8.W))
    val output = Output(UInt(8.W))
  })

  // Initialization
  io.output := 0.U

  // Registers
  val result = RegInit(UInt(8.W), 0.U)

  // Booleans
  val startCalculating = RegInit(Bool(), false.B)

  // Queues
  val queue = Module(new FIFOAltUInt(width * height, dataWidth, binaryPoint))

  // Checking this boolean value before setting it will make it wait a cycle
  when(startCalculating) {
    when(queue.io.dataOut > io.input) {
      result := queue.io.dataOut - io.input
    }.otherwise {
      result := io.input - queue.io.dataOut
    }

    // Saturation arithmetic, which absdiff has to do, will define a range to operate inside.
    // If a result goes below or above the limits of this range, it's clamped to the respective limit.
    when(result < 0.U) {
      result := 0.U
    }

    when(result > 255.U) {
      result := 255.U
    }

    io.output := result
  }

  when(!startCalculating) {
    when(io.lastIn) {
      startCalculating := true.B
    }
  }

  queue.io.pushing := true.B
  queue.io.dataIn := io.input
}
