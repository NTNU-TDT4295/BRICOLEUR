package accelerators.Grayscale

import chisel3._
import chisel3.util.Counter
import chisel3.experimental.FixedPoint

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

  val factors = Array(0.3, 0.59, 0.11)
  val v = RegInit(FixedPoint(16.W, 8.BP), FixedPoint.fromDouble(0.0, 16.W, 8.BP))
  val byteArray = Array(
	FixedPoint.fromDouble(0, 16.W, 8.BP),
	FixedPoint.fromDouble(0, 16.W, 8.BP),
	FixedPoint.fromDouble(0, 16.W, 8.BP)
  )
  val counter = Counter(3)

  io.dataValid := false.B
  io.dataOut := FixedPoint.fromDouble(0.0, 16.W, 8.BP)

  // Fill the byte array as the value comes in
  when(io.loadingValues) {
	for (i <- 0 until 3) {
	  when(counter.value === i.U) {
		byteArray(i) = io.dataIn
		printf(p"byteArray(${i.U}) = ${io.dataIn.asUInt()}\n")
	  }
	}
  }

  // When the byte array is filled, loop over, compute and send signal out
  when(counter.inc()) {
	for (i <- 0 until 3) {
	  val byte = byteArray(i).asFixedPoint(8.BP)
	  val factor = FixedPoint.fromDouble(factors(i), 16.W, 8.BP)
	  v := v + byte
	  printf(p"i = ${i.U}\n")
	  printf(p"byte = ${byte.asUInt()}\n")
	  printf(p"factor = ${factor.asUInt()}\n")
	  printf(p"v = ${v.asUInt()}\n\n")
	}

	io.dataValid := true.B
	io.dataOut := v
  }
}