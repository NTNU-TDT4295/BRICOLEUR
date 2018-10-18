package helpers.FIFO

import chisel3._
import chisel3.core.{FixedPoint, Input}

class FIFO(depth: Int) extends Module { // Defining the behaviour of the accelerators.FIFO queue
  val io = IO(new Bundle {
	val dataIn = Input(FixedPoint(16.W, 8.BP))
	val dataOut = Output(FixedPoint(16.W, 8.BP))

  })
  // val bank = Array.fill(depth) {RegInit(UInt(8.W), 0.U)}
  val bank = Array.fill(depth) {
	RegInit(FixedPoint(16.W, 8.BP),
	  FixedPoint.fromDouble(0.0, 16.W, 8.BP))
  }
  if (depth > 1) {
	for (ii <- 1 until depth) {
	  bank(ii) := bank(ii - 1)
	}
  }
  io.dataOut := bank(depth - 1)
  bank(0) := io.dataIn

}