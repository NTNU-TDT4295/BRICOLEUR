import chisel3._
import chisel3.core.withClock
import chisel3.core.withClockAndReset
import chisel3.util._

import async.AsyncFifo

class Address extends Bundle {
  val ADDR = UInt(32.W)
  val PROT = UInt(3.W)
}

class RData extends Bundle {
  val DATA = UInt(32.W)
  val RESP = UInt(2.W)
}

class Stream extends Bundle {
  val DATA = UInt(32.W)
  val KEEP = UInt(4.W)
  val LAST = Bool()
}

class Video extends Bundle {
    val p_clk = Input(Clock())
    val vsync = Bool()
    val href = Bool()
    val data = UInt(8.W)
}

class Counter extends Module {
  val io = IO(new Bundle {

    val video = Input(new Video)

    val frame_counter = Output(UInt(32.W))

    val p_clks_per_line = Output(UInt(32.W))
    val lines = Output(UInt(32.W))

    val bytes_per_frame = Output(UInt(32.W))
  })

  val p_clk_counter_v = RegInit(UInt(32.W), 0.U)
  val frame_counter = RegInit(UInt(32.W), 0.U)
  val p_clks_per_line = RegInit(UInt(32.W), 0.U)
  val p_clk_counter_h = RegInit(UInt(32.W), 0.U)
  val line_counter = RegInit(UInt(32.W), 0.U)
  val lines = RegInit(UInt(32.W), 0.U)
  val frame_byte_counter = RegInit(UInt(32.W), 0.U)
  val bytes_per_frame = RegInit(UInt(32.W), 0.U)

  when(io.video.vsync) {
    when(p_clk_counter_v =/= 0.U) {
      p_clk_counter_v := 0.U
      frame_counter := frame_counter + 1.U

      lines := line_counter
      line_counter := 0.U

      bytes_per_frame := frame_byte_counter
      frame_byte_counter := 0.U
    }
  } .otherwise {
    p_clk_counter_v := p_clk_counter_v + 1.U
  }

  when(!io.video.href) {
    when(p_clk_counter_h =/= 0.U) {
      p_clks_per_line := p_clk_counter_h
      p_clk_counter_h := 0.U
      when(!io.video.vsync) {
        line_counter := line_counter + 1.U
      }
    }
  } .otherwise {
    p_clk_counter_h := p_clk_counter_h + 1.U
    frame_byte_counter := frame_byte_counter + 1.U
  }

  io.frame_counter := frame_counter
  io.p_clks_per_line := p_clks_per_line
  io.lines := lines
  io.bytes_per_frame := bytes_per_frame
}

class VideoCapture extends Module {
  val io = IO(new Bundle {
    val video = Input(new Video)
    val Q = DecoupledIO(UInt(9.W))
  })

  val start_frame = RegInit(Bool(), false.B)

  when(io.video.vsync) {
    start_frame := true.B
  }

  when(start_frame && io.video.href) {
    start_frame := false.B
  }

  val enq = io.Q
  enq.bits := Cat(start_frame, io.video.data)
  when(enq.ready && io.video.href) {
    enq.valid := true.B
  } .otherwise {
    enq.valid := false.B
  }

}

class OV5642 extends Module {
  val io = IO(new Bundle {
    val AR = Flipped(Decoupled(new Address))
    val DR = Decoupled(new RData)
    val stream = Decoupled(new Stream)

    val video = Input(new Video)
  })

  val counter = withClock(io.video.p_clk) {
    Module(new Counter)
  }

  val capture = withClock(io.video.p_clk) {
    Module(new VideoCapture)
  }

  counter.io.video <> io.video
  capture.io.video <> io.video

  // Asynchronous FIFO to cross pixel clock <> PL clock domains
  val video_fifo = Module(new AsyncFifo(UInt(9.W), 64))
  video_fifo.io.queue.enq <> capture.io.Q
  video_fifo.io.enq_clk := io.video.p_clk
  video_fifo.io.deq_clk := clock
  val deq = video_fifo.io.queue.deq

  /*********************************************
   * AXI stream for sending video data to the PS
   */
  val transferred = RegInit(UInt(32.W), 0.U)

  io.stream.bits.DATA := Cat(0.U(24.W), deq.bits(7,0))
  // The DataMover IP in the AXI DMA IP does not support sparse null bytes
  // Once the first data byte has been transferred, KEEP must be fully asserted
  io.stream.bits.KEEP := 0xf.U
  io.stream.bits.LAST := false.B
  io.stream.valid := false.B

  deq.ready := false.B

  // Flip to true to start capturing data.
  // Needed to synchronise frames with the DMA,
  // initialise a DMA first, then read control register 0x20 to set this to true
  val running = RegInit(false.B)

  // Wait for frame start
  val frame_started = RegInit(false.B)
  val frame_data_valid = Wire(Bool())
  val frame_data_eaten = RegInit(0.U(32.W))
  frame_data_valid := frame_started
  when(running && deq.valid && !frame_started) {
    deq.ready := true.B
    when(deq.bits(8) && frame_data_eaten > 8.U) {
      frame_started := true.B
      frame_data_valid := true.B
      frame_data_eaten := 0.U
    } .otherwise {
      frame_data_eaten := frame_data_eaten + 1.U
    }
  }

  // Temporary register for holding pixel data until we have 32 bits to send
  val stream_data_tmp = RegInit(0.U(32.W))

  when(io.stream.ready && deq.valid && frame_data_valid) {
    deq.ready := true.B
    when(transferred % 4.U === 3.U) {
      // We've dequeued 4 bytes of pixel data
      // Push out 32 bits of data, 24 bits from the temporary register and
      // 8 bits from the currently dequeued pixel
      io.stream.bits.DATA := Cat(stream_data_tmp, deq.bits(7,0))
      io.stream.valid := true.B
    } .otherwise {
      // Shift in 8 bits of pixel data into the temporary data register
      stream_data_tmp := Cat(stream_data_tmp(15,0), deq.bits(7,0))
    }

    // Frame transfer finished
    // TODO: Fix transfer length. Use the detected pixels per frame or a
    // control regiser
    when(transferred >= (2592 * 1944 * 2 - 1).U) {
      io.stream.bits.LAST := true.B
      transferred := 0.U
      frame_started := false.B
      running := false.B
    } .otherwise {
      transferred := transferred + 1.U
    }
  }

  /****************************************
   * AXI4-Lite interfaced control registers
   */
  val addr = RegInit(UInt(32.W), 0.U)

  val idle :: transferring :: Nil = Enum(2)
  val state = RegInit(idle)

  io.DR.bits.DATA := 0.U
  io.DR.bits.RESP := 0.U

  switch(state) {
    is(idle) {
      when(io.AR.valid) {
        addr := io.AR.bits.ADDR
        state := transferring
      }
    }

    is(transferring) {
      when(io.DR.ready) {
        val reg = addr & 0xFF.U
        when(reg === 0.U) {
          io.DR.bits.DATA := counter.io.bytes_per_frame
        } .elsewhen(reg === 4.U) {
          io.DR.bits.DATA := counter.io.frame_counter
        } .elsewhen(reg === 8.U) {
          io.DR.bits.DATA := counter.io.p_clks_per_line
        } .elsewhen(reg === 0xC.U) {
          io.DR.bits.DATA := counter.io.lines
        } .elsewhen(reg === 0x10.U) {
          io.DR.bits.DATA := transferred
        } .elsewhen(reg === 0x14.U) {
          io.DR.bits.DATA := deq.valid
        } .elsewhen(reg === 0x18.U) {
          io.DR.bits.DATA := io.stream.ready
        } .elsewhen(reg === 0x1C.U) {
          io.DR.bits.DATA := video_fifo.io.queue.enq.ready
        } .elsewhen(reg === 0x20.U) {
          io.DR.bits.DATA := 0x42.U
          running := true.B
        } .elsewhen(reg === 0x24.U) {
          io.DR.bits.DATA := running
        } .otherwise {
          io.DR.bits.DATA := 0x0BADF00D.U
        }
        state := idle
      }
    }
  }

  io.DR.valid := (state === transferring)
  io.AR.ready := state === idle

}
