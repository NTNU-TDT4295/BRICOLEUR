package accelerators.Threshold

import chisel3._

/**
  * Threshold operation – everything over limit clamps to 255, everything under (and including limit) clamps to 0.
  *
  * @param limit : Limit for which values should be filtered
  */
class Threshold(limit: Int) extends Module {
  val io = IO(new Bundle {
    // Gaussian blur validOut -> this tvalidIn
    val tvalidIn = Input(Bool())
    // Gaussian Blur tdata -> this dataIn
    val dataIn = Input(UInt(8.W))
    // this tdata -> Dilation dataIn
    val tdata = Output(UInt(8.W))
    // this treadyOut -> Absdiff tready
    val treadyOut = Output(Bool())
  })

  io.treadyOut := true.B
  io.tdata := 0.U

  when(io.tvalidIn) {
    when(io.dataIn <= limit.U) {
      io.tdata := 0.U
    }.otherwise {
      io.tdata := 255.U
    }
  }
}
