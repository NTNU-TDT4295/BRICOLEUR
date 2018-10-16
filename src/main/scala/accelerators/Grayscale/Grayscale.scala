package accelerators.Grayscale

import chisel3._
import chisel3.util.Counter

/**
  * accelerators.RGB2Gray module that calculates the grayscale value of a pixel by doing (R + G + B) / 3.
  * It's actually not very good, since each color have equal effect on the image. It should
  * rather be (0.3 * R) + (0.59 * G) + (0.11 * B), but I haven't looked into supporting
  * fixed point numbers yet.
  */
class Grayscale extends Module {
  val io = IO(new Bundle {
	val dataIn = Input(UInt(8.W))
	val loadingValues = Input(Bool())
	val dataOut = Output(UInt(8.W))
	val dataValid = Output(Bool())
  })

  val v = RegInit(0.U)
  val counter = Counter(3)

  io.dataValid := false.B
  io.dataOut := 0.U

  // Compute the sum as we get the values
  when(io.loadingValues) {
	v := v + io.dataIn
  }

  when(counter.inc()) {
	io.dataValid := true.B
	io.dataOut := v / 3.U
  }
}