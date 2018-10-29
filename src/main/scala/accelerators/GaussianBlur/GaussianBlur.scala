package accelerators.GaussianBlur

import chisel3._
import chisel3.core.{FixedPoint, Input}
import chisel3.util.Counter
import helpers.FIFO.FIFO

class GaussianBlur(width: Int, height: Int) extends Module {
  // TODO:
  // would be nice to pass kernel constants
  // and kernel size into the Module as a parameter

  // TODO:
  // also pass in data width and binary point values
  // as parameters
  //  - Joakim
  val io = IO(new Bundle{
    val dataIn = Input(FixedPoint(16.W,8.BP))
    val clock = Input(Bool())

    // AXI signals
    val tdata = Output(UInt(16.W))
    val tvalid = Output(Bool())
    val tready = Input(Bool())
    val tlast = Output(Bool())
    val tkeep = Output(UInt(4.W))
  })

  io.tdata := 0.U
  io.tlast := false.B
  io.tkeep := ~0.U
  io.tvalid := false.B

  //Screwy counter logic, idea is to wait until all queues are loaded, then skip a few cycles when at the edge of image by enabling and disabling io.valid
  // When all valid data has been computed, stop asserting the io.valid signal

  // TODO:
  // Rewrite this logic in a more general fashion
  // so we can easily change the kernel size to, say, 5x5 without
  // chaging any code, just the kernel constants
  //  - Joakim
  val counterStart = Counter(1+1+1+1+width-3+1+1+width-3+1+1)
  val counterEdge = Counter(2)
  val endOfOutput = Counter((width-2)*(height-2))
  val counterProcess = Counter(8)
  val computationStarted = RegInit(UInt(1.W), 0.U)
  val processWrapped = RegInit(UInt(1.W), 0.U)
  val computationEnded = RegInit(UInt(1.W), 0.U)

  when(counterStart.inc()){
    computationStarted := 1.U
  }

  when(computationStarted === 1.U){

    when (processWrapped === 0.U){
      when(counterProcess.inc()){
        processWrapped := 1.U
      }
      }.otherwise{
        when(counterEdge.inc()){
          processWrapped := 0.U
        }
      }
  }
  when(processWrapped === 0.U && computationStarted === 1.U && computationEnded === 0.U){
    when(endOfOutput.inc()){
      computationEnded := 1.U
    }
    io.tvalid := true.B
    }.otherwise{
      io.tvalid := false.B
    }
    // Save these values, is used in the tester
    val myWidth = width
    val myHeight = height


    // K[0][0] K[1][0] K[2][0]  kernel element 0, 1, 2
    // K[0][1] K[1][1] K[2][1] kernel element 3, 4, 5
    // K[0][2] K[1][2] K[2][2] kernel element 6, 7, 8


    //See paper for explanation
    //Idea is deep pipelines
    //
    //These are not much FIFOS as delay_Ns
    val fifo1_0 = Module(new FIFO(1))
    val fifo2_1 = Module(new FIFO(1))
    val fifo3_2 = Module(new FIFO(width-3))
    val fifo4_3 = Module(new FIFO(1))
    val fifo5_4 = Module(new FIFO(1))
    val fifo6_5 = Module(new FIFO(width-3))
    val fifo7_6 = Module(new FIFO(1))
    val fifo8_7 = Module(new FIFO(1))


    //Connect inputs and outputs
    fifo8_7.io.dataIn := io.dataIn
    fifo7_6.io.dataIn := fifo8_7.io.dataOut
    fifo6_5.io.dataIn := fifo7_6.io.dataOut
    fifo5_4.io.dataIn := fifo6_5.io.dataOut
    fifo4_3.io.dataIn := fifo5_4.io.dataOut
    fifo3_2.io.dataIn := fifo4_3.io.dataOut
    fifo2_1.io.dataIn := fifo3_2.io.dataOut
    fifo1_0.io.dataIn := fifo2_1.io.dataOut


    // Store the computed kernel snippets in theese registers
    val kernel_0 = RegInit(FixedPoint(16.W,8.BP), FixedPoint.fromDouble(0.0,16.W,8.BP))
    val kernel_1 = RegInit(FixedPoint(16.W,8.BP), FixedPoint.fromDouble(0.0,16.W,8.BP))
    val kernel_2 = RegInit(FixedPoint(16.W,8.BP), FixedPoint.fromDouble(0.0,16.W,8.BP))
    val kernel_3 = RegInit(FixedPoint(16.W,8.BP), FixedPoint.fromDouble(0.0,16.W,8.BP))
    val kernel_4 = RegInit(FixedPoint(16.W,8.BP), FixedPoint.fromDouble(0.0,16.W,8.BP))
    val kernel_5 = RegInit(FixedPoint(16.W,8.BP), FixedPoint.fromDouble(0.0,16.W,8.BP))
    val kernel_6 = RegInit(FixedPoint(16.W,8.BP), FixedPoint.fromDouble(0.0,16.W,8.BP))
    val kernel_7 = RegInit(FixedPoint(16.W,8.BP), FixedPoint.fromDouble(0.0,16.W,8.BP))
    val kernel_8 = RegInit(FixedPoint(16.W,8.BP), FixedPoint.fromDouble(0.0,16.W,8.BP))



    //Kernel constants, in this case set to an identity matrix
    val kernelC0 = FixedPoint.fromDouble(0.077847,16.W,8.BP)
    val kernelC1 = FixedPoint.fromDouble(0.123317,16.W,8.BP)
    val kernelC2 = FixedPoint.fromDouble(0.077847,16.W,8.BP)
    val kernelC3 = FixedPoint.fromDouble(0.123317,16.W,8.BP)
    val kernelC4 = FixedPoint.fromDouble(0.195346,16.W,8.BP)
    val kernelC5 = FixedPoint.fromDouble(0.123317,16.W,8.BP)
    val kernelC6 = FixedPoint.fromDouble(0.077847,16.W,8.BP)
    val kernelC7 = FixedPoint.fromDouble(0.123317,16.W,8.BP)
    val kernelC8 = FixedPoint.fromDouble(0.077847,16.W,8.BP)

    // Guss 3x3 kernel with standard deviation = 1
    //0.077847	0.123317	0.077847
    //0.123317	0.195346	0.123317
    //0.077847	0.123317	0.077847
    //

    // Computing the value of each kernel corner
    kernel_8 := io.dataIn * kernelC8
    kernel_7 := fifo8_7.io.dataOut*kernelC7
    kernel_6 := fifo7_6.io.dataOut*kernelC6
    kernel_5 := fifo6_5.io.dataOut*kernelC5
    kernel_4 := fifo5_4.io.dataOut*kernelC4
    kernel_3 := fifo4_3.io.dataOut*kernelC3
    kernel_2 := fifo3_2.io.dataOut*kernelC2
    kernel_1 := fifo2_1.io.dataOut*kernelC1
    kernel_0 := fifo1_0.io.dataOut*kernelC0

    when (io.tready) {
      // The output function
      io.tdata := (
        kernel_0 +
          kernel_1 +
          kernel_2 +
          kernel_3 +
          kernel_4 +
          kernel_5 +
          kernel_6 +
          kernel_7 +
          kernel_8 ).asUInt
    }

}


//object GaussDriver extends App{
//  chisel3.Driver.execute(args, () => new GaussianBlur(10, 10))

//}
