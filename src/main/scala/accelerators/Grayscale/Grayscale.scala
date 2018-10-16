package accelerators.Grayscale

import chisel3._
import chisel3.core.FixedPoint
import chisel3.util.Counter

/**
  * accelerators.RGB2Gray module that calculates the grayscale value of a pixel by doing (R + G + B) / 3.
  * It's actually not very good, since each color have equal effect on the image. It should
  * rather be (0.3 * R) + (0.59 * G) + (0.11 * B), but I haven't looked into supporting
  * fixed point numbers yet.
  */
class Grayscale extends Module {
  val io = IO(new Bundle {
	val dataIn = Input(UInt(32.W))
	val loadingValues = Input(Bool())
	val dataOut = Output(FixedPoint(32.W, 16.BP))
	val dataValid = Output(Bool())
  })

  val factors = Array(0.3, 0.59, 0.11)
  val v  = RegInit(FixedPoint(32.W,16.BP),FixedPoint.fromDouble(0.0,32.W,16.BP))
  val counter = Counter(3)
  var i = 0

  io.dataValid := false.B
  io.dataOut := FixedPoint.fromDouble(0.0, 32.W, 16.BP)

  // Compute the sum as we get the values
  when(io.loadingValues) {
	v := v + FixedPoint.fromDouble(0.0, 32.W, 16.BP)
	i += 1
  }

  when(counter.inc()) {
	io.dataValid := true.B
	io.dataOut := v
  }
}