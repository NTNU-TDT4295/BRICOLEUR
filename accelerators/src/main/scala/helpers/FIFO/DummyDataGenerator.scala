package helpers.FIFO

import chisel3._

/**
  * A dummy data generator that spits out an infinite series of bytes. Each three byte makes up
  * a pixel. The idea is that this generator should simulate the data coming from the camera.
  * These data should, in the pipeline, be moved to the gryscaling step.
  * Right now it's just producing pixels with the following values (R: 0, G: 1, B: 2).
  */
class DummyDataGenerator extends Module {
  val io = IO(new Bundle {
    val dataOut = Output(UInt(8.W))
    val outputValid = Output(Bool())
  })

  io.outputValid := false.B

  // Should produce three byte values, constituting an individual pixel, before declaring
  // that the data is valid.
  var counter = RegInit(UInt(8.W), 0.U)

  io.dataOut := counter

  when(counter === 2.U) {
    io.outputValid := true.B
    counter := 0.U
  }.otherwise {
    counter := counter + 1.U
  }
}
