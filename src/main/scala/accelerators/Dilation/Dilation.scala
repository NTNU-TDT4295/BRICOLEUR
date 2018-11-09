package accelerators.Dilation

import chisel3._
import chisel3.core.{FixedPoint, Input}
import chisel3.util.Counter
import helpers.FIFO.FIFO
import helpers.FIFO.FIFOAlt
import scala.math

class Dilation(width: Int, height: Int, dataWidth: Int, binaryPoint: Int) extends Module {
  // TODO:
  // would be nice to pass kernel constants
  // and kernel size into the Module as a parameter

  // TODO:
  // also pass in data width and binary point values
  // as parameters
  //  - Joakim
  val io = IO(new Bundle {
    val dataIn = Input(FixedPoint(dataWidth.W, binaryPoint.BP))

    // AXI signals
    val tready = Input(Bool())
    val tvalidIn = Input(Bool())
    val treadyOut = Output(Bool())
    val tvalid = Output(Bool())
    val lastOut = Output(Bool())
    val lastIn = Input(Bool())

    val tdata = Output(FixedPoint(dataWidth.W, binaryPoint.BP))
    //val tdata      = Output(UInt(dataWidth.W))
    val tkeep = Output(UInt(4.W))
  })
  // Screwy counter logic, idea is to wait until all queues are loaded,
  // then skip a few cycles when at the edge of image by enabling and disabling io.valid
  // When all valid data has been computed, stop asserting the io.valid signal

  // TODO:
  // Rewrite this logic in a more general fashion
  // so we can easily change the kernel size to, say, 5x5 without
  // chaging any code, just the kernel constants
  //  - Joakim

  val counterStart = Counter(1 + 1 + 1 + 1 + width - 3 + 1 + 1 + width - 3 + 1 + 1)
  val counterEdge = Counter(2)
  val endOfOutput = Counter((width - 2) * (height - 2))
  val counterProcess = Counter(width - 2)
  val computationStarted = RegInit(Bool(), false.B)
  val processWrapped = RegInit(Bool(), false.B)
  val computationEnded = RegInit(Bool(), false.B)
  val isReady = RegInit(Bool(), false.B)
  //val isReadyOut = RegInit(Bool(), false.B)
  val isPushing = RegInit(Bool(), false.B)
  val myWidth = width
  val myHeight = height

  io.tdata := FixedPoint.fromDouble(0, dataWidth.W, binaryPoint.BP)
  io.lastOut := false.B
  io.tkeep := ~(0.U(4.W))
  io.tvalid := false.B
  io.treadyOut := isReady

  when(computationEnded && computationStarted && io.tvalidIn){
    computationEnded := false.B
    computationStarted := false.B
  }

  when(isReady && io.tvalidIn) {
    isPushing := true.B
    //io.treadyOut := true.B

    when(counterStart.inc()) {
      computationStarted := true.B
    }

    when(computationStarted) {

      when(~processWrapped) {
        when(counterProcess.inc()) {
          processWrapped := true.B
        }
      }.otherwise {
        when(counterEdge.inc()) {
          processWrapped := false.B
        }
      }
    }
    when(~processWrapped && computationStarted && ~computationEnded) {
      when(endOfOutput.inc()) {
        computationEnded := true.B
        io.lastOut := true.B
      }
      io.tvalid := true.B
      isReady := false.B // Force circuit to recheck if DMA is ready
      //isReadyOut := false.B
      //isPushing := false.B
    }.otherwise {
      io.tvalid := false.B
    }


    // K[0][0] K[1][0] K[2][0] kernel element 0, 1, 2
    // K[0][1] K[1][1] K[2][1] kernel element 3, 4, 5
    // K[0][2] K[1][2] K[2][2] kernel element 6, 7, 8

    //See paper for explanation
    //Idea is deep pipelines

    val fifo1_0 = Module(new FIFOAlt(1, dataWidth, binaryPoint))
    val fifo2_1 = Module(new FIFOAlt(1, dataWidth, binaryPoint))
    val fifo3_2 = Module(new FIFOAlt(width - 3, dataWidth, binaryPoint))
    val fifo4_3 = Module(new FIFOAlt(1, dataWidth, binaryPoint))
    val fifo5_4 = Module(new FIFOAlt(1, dataWidth, binaryPoint))
    val fifo6_5 = Module(new FIFOAlt(width - 3, dataWidth, binaryPoint))
    val fifo7_6 = Module(new FIFOAlt(1, dataWidth, binaryPoint))
    val fifo8_7 = Module(new FIFOAlt(1, dataWidth, binaryPoint))


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

    // The output function
    val kernels = Array(
      fifo2_1.io.dataOut
      , fifo4_3.io.dataOut
      , fifo5_4.io.dataOut
      , fifo6_5.io.dataOut
      , fifo8_7.io.dataOut
    )
/*
    var minimum = 255.U.asFixedPoint(16.BP)

    for (i <- kernels.indices) {
      when(kernels(i) < minimum) {
        minimum = kernels(i)
      }
    }
*/
    io.tdata := kernels(0).max(kernels(1).max(kernels(2).max(kernels(3).max(kernels(4)))))
  }.otherwise {
    isPushing := false.B
  }

  when(io.tready) {
    isReady := true.B
    //isReadyOut := true.B
  }
}


