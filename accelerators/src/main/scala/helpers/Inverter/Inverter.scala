package helpers.Inverter

import chisel3._

class Inverter() extends Module {
  val io = IO(new Bundle {
    val dataIn = Input(UInt(1.W))
    val dataOut = Output(UInt(1.W))

  })

  io.dataOut := ~io.dataIn


}
