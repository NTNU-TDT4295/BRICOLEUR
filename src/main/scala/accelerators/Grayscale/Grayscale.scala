package accelerators.Grayscale

import chisel3._
import chisel3.util.Counter
import accelerators.FixedPointMultiply
import chisel3.core.FixedPoint

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
  val multiplier = Module(new FixedPointMultiply(32, 16))
  val v  = RegInit(FixedPoint(32.W,16.BP),FixedPoint.fromDouble(0.0,32.W,16.BP))
  val counter = Counter(3)
  var i = 0

  multiplier.io.out := 0.U
  //multiplier.io.factor := FixedPoint.fromDouble(0.0, 32.W, 16.BP)

  io.dataValid := false.B
  io.dataOut := FixedPoint.fromDouble(0.0, 32.W, 16.BP)

  // Compute the sum as we get the values
  when(io.loadingValues) {
	multiplier.io.first := FixedPoint.fromDouble(0.0, 32.W, 16.BP)
	multiplier.io.factor := FixedPoint.fromDouble(factors(i), 32.W, 16.BP)
	v := v + multiplier.io.
	i += 1
  }

  when(counter.inc()) {
	io.dataValid := true.B
	io.dataOut := v
  }
}