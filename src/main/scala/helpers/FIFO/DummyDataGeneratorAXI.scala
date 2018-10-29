package helpers.FIFO

import chisel3._

/**
  * A dummy data generator that spits out an infinite series of 32 bits bytes oscillating between
  * 0 and pow(2,32).
  */
class DummyDataGeneratorAXI extends Module {
  val io = IO(new Bundle {
    val tready = Input(Bool())
    val tvalid = Output(Bool())
    val tlast = Output(Bool())
    val tdata = Output(UInt(32.W))
    val tkeep = Output(UInt(4.W))
  })

  io.tvalid := true.B
  io.tlast := false.B
  io.tkeep := ~(0.U(4.W))

  val data = RegInit(UInt(32.W), 0.U)
  var counter = RegInit(UInt(8.W), 1.U)
 
  io.tdata := data
  
  //io.tdata := counter
  when(io.tready) {
    when(counter === 1.U) {
      data := 10.U
      counter := counter + 1.U
    }
    when(counter === 2.U){
      data := 20.U
      counter := counter + 1.U
    }
    when(counter === 3.U){
      data := 30.U
      counter := 1.U
    }
  }
}

//object DummyDataGeneratorAXI extends App {
//  chisel3.Driver.execute(args, () => new DummyDataGenerator)
//}
