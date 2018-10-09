 import chisel3._

  class GCD extends Module {
    val io = IO(new Bundle {
      val a  = Input(UInt(32.W))
      val b  = Input(UInt(32.W))
      val e  = Input(Bool())
      val z  = Output(UInt(32.W))
      val v  = Output(Bool())
    })
    val x = Reg(UInt(32.W))
    val y = Reg(UInt(32.W))
    when (x > y) {
      x := x -% y
    }.otherwise {
      y := y -% x
    }
    when (io.e) {
      x := io.a
      y := io.b
    }
    io.z := x
    io.v := y === 0.U
  }

object GCDDriver extends App {
  chisel3.Driver.execute(args, () => new GCD)
}
