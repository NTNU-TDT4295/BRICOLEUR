package accelerators.Grayscale

import chisel3.core.FixedPoint
import chisel3.{UInt, _}

/**
  * accelerators.RGB2Gray module that calculates the grayscale value of a pixel by doing (R + G + B) / 3.
  * It's actually not very good, since each color have equal effect on the image. It should
  * rather be (0.3 * R) + (0.59 * G) + (0.11 * B), but I haven't looked into supporting
  * fixed point numbers yet.
  */
class Grayscale extends Module {

  val io = IO(new Bundle {
    val dataIn = Input(FixedPoint(32.W, 16.BP))

    // AXI signals
    val tready = Input(Bool())
    val tvalid = Output(Bool())
    val tdata = Output(FixedPoint(32.W, 16.BP))
    val tkeep = Output(UInt(4.W))
    val lastIn = Input(Bool())
    val lastOut = Output(Bool())
    val tvalidIn = Input(Bool())
    val treadyOut = Output(Bool())
  })

  // Assert tready out only once
  /*
  val hasAssertedTReadyOut = RegInit(Bool(), false.B)
  when(!hasAssertedTReadyOut) {
    io.treadyOut := true.B
    hasAssertedTReadyOut := true.B
  }.otherwise {
    io.treadyOut := false.B
  }
*/
  // The three factors that R, G and B color channels should be multipled with, respectively
  val f0: FixedPoint = FixedPoint.fromDouble(0.3, 32.W, 16.BP)
  val f1: FixedPoint = FixedPoint.fromDouble(0.59, 32.W, 16.BP)
  val f2: FixedPoint = FixedPoint.fromDouble(0.11, 32.W, 16.BP)
  
  val out = RegInit(FixedPoint(32.W, 16.BP), FixedPoint.fromDouble(0, 32.W, 16.BP))

  val started = RegInit(Bool(), false.B)
  //val counter = Counter(3)
  val counter = RegInit(UInt(4.W), 0.U)
  io.lastOut := false.B
  io.tkeep := ~0.U(4.W)
  io.tvalid := false.B
  io.tdata := out//FixedPoint.fromDouble(0, 32.W, 16.BP)
  val isReady = RegInit(Bool(), false.B)
  val isValid = RegInit(Bool(), false.B)
  io.treadyOut := isReady
  
  when(io.tvalidIn && isReady) {
    //io.treadyOut := true.B

    when(counter === 0.U) {
      out := io.dataIn * f0
      counter := counter + 1.U
      //isValid := false.B
      //isReady := false.B

      //io.treadyOut := true.B
    }

    when(counter === 1.U) {
      out := out + io.dataIn * f1
      counter := counter + 1.U
      //isValid := false.B
      //isReady := false.B

      //io.treadyOut := true.B
    }

    when(counter === 2.U) {
      out := out + io.dataIn * f2
      io.tvalid:= true.B
      //when(io.lastIn){
        //io.lastOut := true.B
      //}
      isReady := false.B
      //io.treadyOut := .B
      //isValid := false.B
      counter := 0.U
    }
  }

  when(io.tready) {
    isReady := true.B
    //io.treadyOut := true.B
  }
  when(io.tvalidIn){
    isValid := true.B
  }


}
