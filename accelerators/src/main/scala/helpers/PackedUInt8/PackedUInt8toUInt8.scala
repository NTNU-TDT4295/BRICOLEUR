package helpers.PackedUInt8

import chisel3._
import chisel3.util._

class Stream extends Bundle {
  val DATA = UInt(32.W)
  val KEEP = UInt(4.W)
  val LAST = Bool()
}

class PackedUInt8toUInt8  extends Module {
  val io = IO(new Bundle {
    val input = Flipped(Decoupled(new Stream))
    val output = Decoupled(new Stream)
  })

  val queue = Module(new Queue(
    new Bundle {
      val data = UInt(32.W)
      val last = Bool()
    }, 2
  ))
  val enq = queue.io.enq
  val deq = queue.io.deq

  enq.valid := io.input.valid
  io.input.ready := enq.ready
  enq.bits.data := io.input.bits.DATA
  enq.bits.last := io.input.bits.LAST

  val pack = RegInit(0.U(32.W))
  val last = RegInit(false.B)

  val outputting = RegInit(false.B)
  val out_count = Counter(4)

  deq.ready := false.B

  when(!outputting && deq.valid) {
    deq.ready := true.B
    outputting := true.B
    pack := deq.bits.data
    last := deq.bits.last
  }

  io.output.valid := outputting
  io.output.bits.LAST := false.B
  io.output.bits.KEEP := true.B
  io.output.bits.DATA := pack(7,0)
  when(outputting && io.output.ready) {
    pack := Cat(0.U(8.W), pack(31,8))
    val finished_pack = out_count.inc()
    when(finished_pack) {
      io.output.bits.LAST := last
      outputting := deq.valid || !last
      when(deq.valid) {
        deq.ready := true.B
        pack := deq.bits.data
        last := deq.bits.last
      }
    }
  }
}
