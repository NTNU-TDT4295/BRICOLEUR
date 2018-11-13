package async

import chisel3._
import chisel3.core.withClock
import chisel3.util._

/** Asynchronous Fifo. Used to cross two clock domains.
  *
  * @param gen the type of data in the fifo
  * @param entries the max number of entries in the fifo. The actual
size will be rounded up to the next power of 2 - (size = 1<<log2Ceil(entries))
  * @param enq_clk clock for the input (writing, queuing) side
  * @param deq_clk clock for the output (reading, dequeuing side) side
 */
class AsyncFifo[T<:Data](gen: T, entries: Int) extends Module {
  val io = IO(new Bundle {
    val queue = new QueueIO(gen, entries)
    val enq_clk = Input(new Clock)
    val deq_clk = Input(new Clock)
  })
  val asize = log2Ceil(entries)

  val s1_rptr_gray = withClock(io.enq_clk) { RegInit(UInt((asize + 1).W), 0.U) }
  val s2_rptr_gray = withClock(io.enq_clk) { RegInit(UInt((asize + 1).W), 0.U) }
  val s1_rst_deq   = withClock(io.enq_clk) { RegInit(Bool(), false.B) }
  val s2_rst_deq   = withClock(io.enq_clk) { RegInit(Bool(), false.B) }

  val s1_wptr_gray = withClock(io.deq_clk) { RegInit(UInt((asize + 1).W), 0.U) }
  val s2_wptr_gray = withClock(io.deq_clk) { RegInit(UInt((asize + 1).W), 0.U) }
  val s1_rst_enq   = withClock(io.deq_clk) { RegInit(Bool(), false.B) }
  val s2_rst_enq   = withClock(io.deq_clk) { RegInit(Bool(), false.B) }

  val wptr_bin  = withClock(io.enq_clk) { RegInit(UInt((asize + 1).W), 0.U) }
  val wptr_gray = withClock(io.enq_clk) { RegInit(UInt((asize + 1).W), 0.U) }
  val not_full  = withClock(io.enq_clk) { RegInit(Bool(), false.B) }

  val wptr_bin_next = wptr_bin + (io.queue.enq.valid & not_full)
  val wptr_gray_next = (wptr_bin_next >> 1.U) ^ wptr_bin_next
  val not_full_next = !(wptr_gray_next === Cat(~s2_rptr_gray(asize,asize-1), s2_rptr_gray(asize-2,0)))

  val rptr_bin  = withClock(io.deq_clk) { RegInit(UInt((asize + 1).W), 0.U) }
  val rptr_gray = withClock(io.deq_clk) { RegInit(UInt((asize + 1).W), 0.U) }
  val not_empty = withClock(io.deq_clk) { RegInit(Bool(), false.B) }

  val rptr_bin_next = rptr_bin + (io.queue.deq.ready & not_empty)
  val rptr_gray_next = (rptr_bin_next >> 1.U) ^ rptr_bin_next
  val not_empty_next = !(rptr_gray_next === s2_wptr_gray)

  s2_rptr_gray := s1_rptr_gray; s1_rptr_gray := rptr_gray
  // s2_rst_deq := s1_rst_deq; s1_rst_deq := enq_clk.getReset
  s2_rst_deq := s1_rst_deq; s1_rst_deq := reset
  s2_wptr_gray := s1_wptr_gray; s1_wptr_gray := wptr_gray
  // s2_rst_enq := s1_rst_enq; s1_rst_enq := deq_clk.getReset
  s2_rst_enq := s1_rst_enq; s1_rst_enq := reset

  wptr_bin := wptr_bin_next
  wptr_gray := wptr_gray_next
  not_full := not_full_next && !s2_rst_deq

  rptr_bin := rptr_bin_next
  rptr_gray := rptr_gray_next
  not_empty := not_empty_next && !s2_rst_enq

  io.queue.enq.ready := not_full
  io.queue.deq.valid := not_empty

  val mem = withClock(io.enq_clk) { Mem(1 << asize, gen) }
  when (io.queue.enq.valid && io.queue.enq.ready) {
    mem(wptr_bin(asize-1,0)) := io.queue.enq.bits
  }
  io.queue.deq.bits := mem(rptr_bin(asize-1,0))

  io.queue.count := DontCare // ???
}
