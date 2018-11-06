package accelerators.GaussianBlur

import chisel3._
import chisel3.core.{FixedPoint, Input}
import chisel3.util.Counter
import helpers.FIFO.FIFO
import helpers.FIFO.FIFOAlt
import scala.math

class GaussianBlur(width: Int, height: Int) extends Module {
  // TODO:
  // would be nice to pass kernel constants
  // and kernel size into the Module as a parameter

  // TODO:
  // also pass in data width and binary point values
  // as parameters
  //  - Joakim
  val io = IO(new Bundle{
    val dataIn   = Input(FixedPoint(32.W,16.BP))

    // AXI signals
    val tready    = Input(Bool())
    val tvalidIn  = Input(Bool())
    val treadyOut = Output(Bool())
    val tvalid    = Output(Bool())
    val tlast     = Output(Bool())
    val tdata     = Output(FixedPoint(32.W, 16.BP))
    //val tdata      = Output(UInt(32.W))
    val tkeep     = Output(UInt(4.W))
  })
  // Screwy counter logic, idea is to wait until all queues are loaded,
  // then skip a few cycles when at the edge of image by enabling and disabling io.valid
  // When all valid data has been computed, stop asserting the io.valid signal

  // TODO:
  // Rewrite this logic in a more general fashion
  // so we can easily change the kernel size to, say, 5x5 without
  // chaging any code, just the kernel constants
  //  - Joakim

  val counterStart = Counter(1+1+1+1+width-3+1+1+width-3+1+1)
  val counterEdge = Counter(2)
  val endOfOutput = Counter((width-2)*(height-2))
  val counterProcess = Counter(width-2)
  val computationStarted = RegInit(Bool(), false.B)
  val processWrapped = RegInit(Bool(), false.B)
  val computationEnded = RegInit(Bool(), false.B)
  val isReady = RegInit(Bool(), false.B)
  val isReadyOut = RegInit(Bool(), false.B)
  val isPushing = RegInit(Bool(), false.B)
  val myWidth = width
  val myHeight = height

  io.tdata := FixedPoint.fromDouble(0, 32.W, 16.BP)
  io.tlast := false.B
  io.tkeep := ~(0.U(4.W))
  io.tvalid := false.B
  io.treadyOut := isReadyOut




  when (isReady && io.tvalidIn) {
    isPushing := true.B

    when(counterStart.inc()){
      computationStarted := true.B
    }

    when(computationStarted){

      when (~processWrapped){
        when(counterProcess.inc()){
          processWrapped := true.B
        }
        }.otherwise{
          when(counterEdge.inc()){
            processWrapped := false.B
          }
        }
    }
    when(~processWrapped && computationStarted && ~computationEnded){
      when(endOfOutput.inc()){
        computationEnded := true.B
      }
      io.tvalid := true.B
      isReady := false.B // Force circuit to recheck if DMA is ready
      isReadyOut := false.B
      //isPushing := false.B
    }.otherwise{
      io.tvalid := false.B
    }


      // K[0][0] K[1][0] K[2][0] kernel element 0, 1, 2
      // K[0][1] K[1][1] K[2][1] kernel element 3, 4, 5
      // K[0][2] K[1][2] K[2][2] kernel element 6, 7, 8

      //See paper for explanation
      //Idea is deep pipelines

      val fifo1_0 = Module(new FIFOAlt(1))
      val fifo2_1 = Module(new FIFOAlt(1))
      val fifo3_2 = Module(new FIFOAlt(width-3))
      val fifo4_3 = Module(new FIFOAlt(1))
      val fifo5_4 = Module(new FIFOAlt(1))
      val fifo6_5 = Module(new FIFOAlt(width-3))
      val fifo7_6 = Module(new FIFOAlt(1))
      val fifo8_7 = Module(new FIFOAlt(1))
      

      //Connect inputs and outputs
      fifo8_7.io.dataIn := io.dataIn
      fifo7_6.io.dataIn := fifo8_7.io.dataOut
      fifo6_5.io.dataIn := fifo7_6.io.dataOut
      fifo5_4.io.dataIn := fifo6_5.io.dataOut
      fifo4_3.io.dataIn := fifo5_4.io.dataOut
      fifo3_2.io.dataIn := fifo4_3.io.dataOut
      fifo2_1.io.dataIn := fifo3_2.io.dataOut
      fifo1_0.io.dataIn := fifo2_1.io.dataOut
      
      //Assert this as true when data is valid, as in make fifos update or not
      fifo8_7.io.pushing := isPushing
      fifo7_6.io.pushing := isPushing
      fifo6_5.io.pushing := isPushing
      fifo5_4.io.pushing := isPushing
      fifo4_3.io.pushing := isPushing
      fifo3_2.io.pushing := isPushing
      fifo2_1.io.pushing := isPushing
      fifo1_0.io.pushing := isPushing

      // Store the computed kernel snippets in theese registers
      val kernel_0 = RegInit(FixedPoint(32.W,16.BP), FixedPoint.fromDouble(0.0,32.W,16.BP))
      val kernel_1 = RegInit(FixedPoint(32.W,16.BP), FixedPoint.fromDouble(0.0,32.W,16.BP))
      val kernel_2 = RegInit(FixedPoint(32.W,16.BP), FixedPoint.fromDouble(0.0,32.W,16.BP))
      val kernel_3 = RegInit(FixedPoint(32.W,16.BP), FixedPoint.fromDouble(0.0,32.W,16.BP))
      val kernel_4 = RegInit(FixedPoint(32.W,16.BP), FixedPoint.fromDouble(0.0,32.W,16.BP))
      val kernel_5 = RegInit(FixedPoint(32.W,16.BP), FixedPoint.fromDouble(0.0,32.W,16.BP))
      val kernel_6 = RegInit(FixedPoint(32.W,16.BP), FixedPoint.fromDouble(0.0,32.W,16.BP))
      val kernel_7 = RegInit(FixedPoint(32.W,16.BP), FixedPoint.fromDouble(0.0,32.W,16.BP))
      val kernel_8 = RegInit(FixedPoint(32.W,16.BP), FixedPoint.fromDouble(0.0,32.W,16.BP))

      //Kernel constants, set to actual factual gauss values
      
      val kernelC0 = FixedPoint.fromDouble(0.077847,32.W,16.BP)
      val kernelC1 = FixedPoint.fromDouble(0.123317,32.W,16.BP)
      val kernelC2 = FixedPoint.fromDouble(0.077847,32.W,16.BP)
      val kernelC3 = FixedPoint.fromDouble(0.123317,32.W,16.BP)
      val kernelC4 = FixedPoint.fromDouble(0.195346,32.W,16.BP)
      val kernelC5 = FixedPoint.fromDouble(0.123317,32.W,16.BP)
      val kernelC6 = FixedPoint.fromDouble(0.077847,32.W,16.BP)
      val kernelC7 = FixedPoint.fromDouble(0.123317,32.W,16.BP)
      val kernelC8 = FixedPoint.fromDouble(0.077847,32.W,16.BP)
      
      /*
      val kernelC0 = FixedPoint.fromDouble(0 ,32.W,16.BP)
      val kernelC1 = FixedPoint.fromDouble(0 ,32.W,16.BP)
      val kernelC2 = FixedPoint.fromDouble(0 ,32.W,16.BP)
      val kernelC3 = FixedPoint.fromDouble(0 ,32.W,16.BP)
      val kernelC4 = FixedPoint.fromDouble(1 ,32.W,16.BP)
      val kernelC5 = FixedPoint.fromDouble(0 ,32.W,16.BP)
      val kernelC6 = FixedPoint.fromDouble(0 ,32.W,16.BP)
      val kernelC7 = FixedPoint.fromDouble(0 ,32.W,16.BP)
      val kernelC8 = FixedPoint.fromDouble(0 ,32.W,16.BP)
      */
      // Gauss 3x3 kernel with standard deviation = 1
      // 0.077847	0.123317	0.077847
      // 0.123317	0.195346	0.123317
      // 0.077847	0.123317	0.077847
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

      // The output function
      io.tdata := //(
        kernel_0 +
        kernel_1 +
        kernel_2 +
        kernel_3 +
        kernel_4 +
        kernel_5 +
        kernel_6 +
        kernel_7 +
        kernel_8 //).asUInt
  
  }.otherwise{
    isPushing:=false.B
  }

  when(io.tready) {
    isReady := true.B
    isReadyOut := true.B
  }
}

class GaussianBlurGeneral(width: Int, height: Int, n: Int, std: Double) extends Module {
  val io = IO(new Bundle{
    val dataIn = Input(FixedPoint(32.W, 16.BP))
    val dataOut = Output(FixedPoint(32.W, 16.BP))
    val valid = Output(Bool())
    val writeEnable = Input(Bool())
  })

  io.valid := false.B

  //Generate the kernel values
  //println("GaussianBlurGeneral testing kernel")
  var kernel = Array.fill(n*n){RegInit(FixedPoint(32.W, 16.BP), FixedPoint.fromDouble(0.0, 32.W, 16.BP))}
  //printf(p"Kernel: \n")
  var kernelScalingValue = 0.0
  for(y <- 0 until n){
    //val temp = Vec(n)
    for(x <- 0 until n){
      val kernelValue = math.exp(-(math.pow((n-1)/2 - x, 2) + math.pow((n-1)/2- y, 2))/(2*math.pow(std, 2)))/(2*math.Pi*math.pow(std, 2))


      kernel(y*n + x) := FixedPoint.fromDouble(kernelValue, 32.W, 16.BP)
      kernelScalingValue += kernelValue

      //print(kernelValue)
      //print(" ")
      //printf(p"${(kernel(y*n + x).asUInt)} ")
    }
    //printf(p"\n")
    //println("")
  }
  val kernelScaling = RegInit(FixedPoint.fromDouble(1/kernelScalingValue, 32.W, 16.BP))


  val valueMatrix = Array.fill(n*n){RegInit(FixedPoint(32.W, 16.BP), FixedPoint.fromDouble(0.0, 32.W, 16.BP))}
  for(y <- 0 until n){
    for(x <- 1 until n){

      when(io.writeEnable){
        valueMatrix(y*n + x) := valueMatrix(y*n + x - 1)
        }.otherwise{
          valueMatrix(y*n + x) := valueMatrix(y*n + x)
        }
    }

    if(y < n - 1){
      val queue = Module(new FIFOAlt(width - n))

      queue.io.pushing := io.writeEnable
      queue.io.dataIn := valueMatrix(y*n + n - 1)
      when(io.writeEnable){
        valueMatrix(y*n + n) := queue.io.dataOut
        }.otherwise{
          valueMatrix(y*n + n) := valueMatrix(y*n + n)
        }
    }
  }

  when(io.writeEnable){
    valueMatrix(0) := io.dataIn
    }.otherwise{
      valueMatrix(0) := valueMatrix(0)
    }


    //Logic to sum all the values
    var addMatrix = Array.fill(2*n*n - 1){Wire(FixedPoint(32.W, 16.BP))}

    //The first half of the array is for the nodes, with the child-nodes being
    //2*o and 2*o + 1
    for(o <- 0 until n*n - 1){
      addMatrix(o) := addMatrix(2*o + 1) + addMatrix(2*o + 2)
    }
    //All the leaf-nodes are in the last half of the array, already connected to the other nodes
    //add the values from the kernel and input-values
    //printf(p"Iteration: \n")
    for(o <- 0 until n*n){
      addMatrix(o + n*n - 1) := kernel(o)*valueMatrix(o)

      //printf(p"${kernel(o).asUInt}\n")
      //printf(p"${valueMatrix(o).asUInt}\n")
      //printf(p"${(valueMatrix(o).asUInt)*(kernel(o).asUInt)}\n")
      //printf(p"${addMatrix(o + n*n - 1).asUInt}\n\n")
    }

    val yInCounter = Counter(height)
    val xInCounter = Counter(width)
    val yOutCounter = Counter(height)
    val xOutCounter = Counter(width)


    when(io.writeEnable){
      when(xInCounter.inc()){
        when(yInCounter.inc()){
        }
      }
    }

    val inPos = Wire(UInt())
    inPos := yInCounter.value*width.asUInt + xInCounter.value
    io.valid := false.B
    when(inPos < ((n - 1)/2).U*(width.asUInt + 1.U)){
      io.valid := true.B
      }.elsewhen(inPos >= ((n - 1)/2).U*(width.asUInt + 1.U) && inPos <= (n - 1).U*(width.asUInt + 1.U)){
        io.valid := false.B
        }.elsewhen(inPos > (n - 1).U*(width.asUInt + 1.U)){

          io.valid := true.B
        }

        when(io.valid && io.writeEnable){
          when(xOutCounter.inc()){
            when(yOutCounter.inc()){
            }
          }
        }

        //Start and end, values is just passed through
        when(yOutCounter.value < ((n - 1)/2).U || yOutCounter.value > (height - (n - 1)/2).U){
          io.dataOut := io.dataIn
          }.otherwise{
            when(xOutCounter.value < ((n - 1)/2).U || xOutCounter.value > (width - (n - 1)/2).U){
              io.dataOut := io.dataIn
              }.otherwise{
                io.dataOut := addMatrix(0) * kernelScaling
              }
          }
}

//object GaussDriver extends App{
//  chisel3.Driver.execute(args, () => new GaussianBlur(10, 10))

//}
