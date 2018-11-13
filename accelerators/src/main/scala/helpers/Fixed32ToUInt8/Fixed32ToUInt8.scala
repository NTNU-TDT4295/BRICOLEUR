package helpers.Fixed32ToUInt8

import chisel3._

class Fixed32ToUInt8() extends Module {
  val io = IO(new Bundle {
    val input = Input(UInt(32.W))
    val output = Output(UInt(8.W))
  })

  io.output := io.input>>16.U
}
