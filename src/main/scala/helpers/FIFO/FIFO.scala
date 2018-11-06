package helpers.FIFO

import chisel3._
import chisel3.core.{FixedPoint, Input}

class FIFO(depth: Int, dataWidth: Int, binaryPoint:Int) extends Module { // Defining the behaviour of the accelerators.FIFO queue
  val io = IO(new Bundle {
	val dataIn = Input(FixedPoint(dataWidth.W, binaryPoint.BP))
	val dataOut = Output(FixedPoint(dataWidth.W, binaryPoint.BP))

  })
  // val bank = Array.fill(depth) {RegInit(UInt(8.W), 0.U)}
  val bank = Array.fill(depth) {
	RegInit(FixedPoint(dataWidth.W, binaryPoint.BP),
	  FixedPoint.fromDouble(0.0, dataWidth.W, binaryPoint.BP))
  }
  if (depth > 1) {
	for (ii <- 1 until depth) {
	  bank(ii) := bank(ii - 1)
	}
  }
  io.dataOut := bank(depth - 1)
  bank(0) := io.dataIn

}


class FIFOAlt(depth: Int,dataWidth:Int, binaryPoint:Int) extends Module { // Defining the behaviour of the accelerators.FIFO queue
  val io = IO(new Bundle {
	val dataIn = Input(FixedPoint(dataWidth.W, binaryPoint.BP))
        val pushing = Input(Bool())
	val dataOut = Output(FixedPoint(dataWidth.W, binaryPoint.BP))

  })
  // val bank = Array.fill(depth) {RegInit(UInt(8.W), 0.U)}
  val bank = Array.fill(depth) {
	RegInit(FixedPoint(dataWidth.W, binaryPoint.BP),
	  FixedPoint.fromDouble(0.0, dataWidth.W, binaryPoint.BP))
  }
  if (depth > 1) {
      for (ii <- 1 until depth) {
          when(io.pushing){
	    bank(ii) := bank(ii - 1)
          }.otherwise{
            bank(ii) := bank(ii)
          }
      }
  }
  when(io.pushing){
    bank(0) := io.dataIn
  }.otherwise{
    bank(0) := bank(0)
  }
  io.dataOut := bank(depth - 1)

}
