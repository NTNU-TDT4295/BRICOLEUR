package accelerators.FixedPoint

import chisel3._
import chisel3.core.FixedPoint

/**
 * Wrapper for doing fixed point division
 * Note that the output unsigned integer
 * represents the bytes of the fixed point number
 * FIXME - question:
 * Do we want the output to be a single unsigned int, like now
 * or do we want it to output two numbers, being the integer and fractional parts
 */
class FixedPointMultiply(width: Int, binaryPoint: Int) extends Module {
  val io = IO(new Bundle {
    val first  = Input(FixedPoint(width.W,binaryPoint.BP))
    val factor = Input(FixedPoint(width.W,binaryPoint.BP))
    val out    = Output(UInt(width.W))
  })

  val factor = RegInit(FixedPoint(width.W,binaryPoint.BP),FixedPoint.fromDouble(0.5,width.W,binaryPoint.BP))
  io.out := ( io.first * factor).asUInt
  // io.out := ( io.first * io.factor).asUInt
}


class FixedPointMultiplyv2(width: Int, binaryPoint: Int) extends Module {
  val io = IO(new Bundle {
    val first         = Input (UInt(width.W))
    val second        = Input (UInt(width.W))
    // val integerOut    = Output(UInt(width.W))
    // val fractionalOut = Output(UInt(width.W))
    val fixedPointOut = Output(UInt(64.W))
  })

  val operand1 = RegInit(UInt(width.W), 0.U)
  val operand2 = RegInit(UInt(width.W), 0.U)

  operand1 := (io.first << binaryPoint.U)
  operand2 := (io.second << binaryPoint.U)
  // result := operand1.asUInt * operand2.asUInt
  // io.fixedPointOut := ( (io.first << binaryPoint.U) * (io.second << binaryPoint.U) ).asUInt
  io.fixedPointOut := operand1.asUInt * operand2.asUInt
}
