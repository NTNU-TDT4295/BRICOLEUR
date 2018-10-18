package accelerators.Grayscale

import chisel3.experimental.FixedPoint
import chisel3.util.Counter
import chisel3.{UInt, _}

/**
  * accelerators.RGB2Gray module that calculates the grayscale value of a pixel by doing (R + G + B) / 3.
  * It's actually not very good, since each color have equal effect on the image. It should
  * rather be (0.3 * R) + (0.59 * G) + (0.11 * B), but I haven't looked into supporting
  * fixed point numbers yet.
  */
class Grayscale extends Module {

  val io = IO(new Bundle {
	val dataIn = Input(FixedPoint(16.W, 8.BP))
	val loadingValues = Input(Bool())
	val dataOut = Output(FixedPoint(16.W, 8.BP))
	val dataValid = Output(Bool())
  })

  // The three factors that R, G and B color channels should be multipled with, respectively
  val f0: FixedPoint = FixedPoint.fromDouble(0.3, 16.W, 8.BP)
  val f1: FixedPoint = FixedPoint.fromDouble(0.59, 16.W, 8.BP)
  val f2: FixedPoint = FixedPoint.fromDouble(0.11, 16.W, 8.BP)

  // Registers for the individual byte values coming in
  val b0 = RegInit(FixedPoint(16.W, 8.BP), FixedPoint.fromDouble(0, 16.W, 8.BP))
  val b1 = RegInit(FixedPoint(16.W, 8.BP), FixedPoint.fromDouble(0, 16.W, 8.BP))
  val b2 = RegInit(FixedPoint(16.W, 8.BP), FixedPoint.fromDouble(0, 16.W, 8.BP))

  val counter = Counter(3)

  io.dataValid := false.B
  io.dataOut := FixedPoint.fromDouble(0.0, 16.W, 8.BP)

  when(io.loadingValues) {
	when(counter.value === 0.U) {
	  b0 := io.dataIn
	}
	when(counter.value === 1.U) {
	  b1 := io.dataIn
	}
	when(counter.value === 2.U) {
	  b2 := io.dataIn
	}
  }

  when(counter.inc()) {
	io.dataOut := b0 * f0 + b1 * f1 + b2 * f2
	io.dataValid := true.B
  }
}