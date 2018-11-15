package accelerators.Threshold

import chisel3._

/**
  * Threshold operation – everything over limit is 255, everything under (and including limit) is 0.
  *
  * @param limit : Limit for which values should be filtered
  */
class Threshold(limit: Int) extends Module {
  val io = IO(new Bundle {
    val input = Input(UInt(8.W))
    val output = Output(UInt(8.W))
  })

  when(io.input <= limit.U) {
    io.output := 0.U
  }.otherwise {
    io.output := 255.U
  }
}
