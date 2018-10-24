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

  val out = RegInit(FixedPoint(16.W, 8.BP), FixedPoint.fromDouble(0, 16.W, 8.BP))

  val started =RegInit(Bool(), false.B)
  val counter = Counter(3)

  io.dataValid := false.B
  io.dataOut := out

  when(io.loadingValues) {
	when(counter.value === 0.U) {
      out := io.dataIn * f0

      when(started){
        io.dataValid := true.B
      }.otherwise{
        started := true.B
      }

	}
	when(counter.value === 1.U) {
      out := out +  io.dataIn * f1
	}
	when(counter.value === 2.U) {
      out := out +  io.dataIn * f2
	}
  }

  counter.inc()

}
