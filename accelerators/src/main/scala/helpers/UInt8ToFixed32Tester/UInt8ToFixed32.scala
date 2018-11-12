package helpers.UInt8ToFixed32Tester

import chisel3._
import chisel3.core.FixedPoint

class UInt8ToFixed32 extends Module {
  val io = IO(new Bundle {
    val input = Input(UInt(8.W))
    val output = Output(FixedPoint(32.W, 16.BP))
  })

  io.output := io.input.asFixedPoint(16.BP)
}
