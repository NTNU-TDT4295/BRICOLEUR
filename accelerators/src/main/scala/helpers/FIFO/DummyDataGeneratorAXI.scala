package helpers.FIFO

import chisel3._
import chisel3.experimental.FixedPoint

/**
  * A dummy data generator that spits out an infinite series of 16 bits, alternating between the fixpoint rep of 10, 20 and 30
  */
class DummyDataGeneratorAXI extends Module {
  val io = IO(new Bundle {
    val tready = Input(Bool())
    val tvalid = Output(Bool())
    val tlast = Output(Bool())
    val tdata = Output(FixedPoint(16.W, 8.BP))
    val tkeep = Output(UInt(4.W))
  })

  io.tvalid := true.B
  io.tlast := false.B
  io.tkeep := ~(0.U(4.W))

  val data = RegInit(FixedPoint(16.W, 8.BP), FixedPoint.fromDouble(0, 16.W, 8.BP))
  var counter = RegInit(UInt(8.W), 1.U)
  var isReady = RegInit(UInt(1.W), 0.U)
  io.tdata := data
  
  //io.tdata := counter
  when(isReady === 1.U) {
    when(counter === 1.U) {
      data :=  FixedPoint.fromDouble(10, 16.W, 8.BP)
      counter := counter + 1.U
    }
    when(counter === 2.U){
      data :=  FixedPoint.fromDouble(20, 16.W, 8.BP)
      counter := counter + 1.U
    }
    when(counter === 3.U){
      data :=  FixedPoint.fromDouble(30, 16.W, 8.BP)
      counter := 1.U
    }
  }
  when(io.tready){
    isReady := 1.U
  }
}

//object DummyDataGeneratorAXI extends App {
//  chisel3.Driver.execute(args, () => new DummyDataGenerator)
//}
