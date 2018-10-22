package helpers.FIFO

import chisel3._

/**
  * A dummy data generator that spits out an infinite series of 32 bits bytes oscillating between
  * 0 and pow(2,32).
  */
class DummyDataGeneratorAXI extends Module {
  val io = IO(new Bundle {
    val tready = Output(Bool())
    val tvalid = Output(Bool())
    val tlast = Output(Bool())
    val tdata = Output(UInt(32.W))
    val tkeep = Output(UInt(4.W))
  })

  io.tready := true.B
  io.tvalid := true.B
  io.tlast := false.B
  io.tkeep := ~0.U

  val data = RegInit(UInt(32.W), 0.U)
  var counter = RegInit(UInt(8.W), 0.U)

  when(counter === 1.U) {
    io.tdata := ~data
    counter := 0.U
  }.otherwise {
    io.tdata := data
    counter := counter + 1.U
  }
}
