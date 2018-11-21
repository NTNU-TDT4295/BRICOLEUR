package mainModule.MainModule

import accelerators.GaussianBlur.GaussianBlur
import accelerators.Grayscale.Grayscale
import chisel3._
import chisel3.core.{FixedPoint, Input}

// Not going to be used?
// discontinued
/**
 * Main Module that wraps the pipeline containing the
 * grayscaling, gaussian blur and dilation.
 * as UInts (binaryPoint bit integer part, 8 bit fractional part)
 *
 * Since Gaussianblur and Dilate can be run at 3 times the speed of grayscale,
 * an explicit clock signal is used
 *
 * FIXME:
 * Are there better solutions than the clocksignal?
 */
class MainModule(dataWidth: Int, binaryPoint: Int, width: Int, height: Int) extends Module {

  val io = IO(new Bundle {
    val dataIn        = Input(FixedPoint(dataWidth.W,binaryPoint.BP))
    val loadingValues = Input(Bool())
    // The below outputs are for debugging purposes.
    // Will add a dataIn and dataValid for the entire module later
    val dataOutGray   = Output(FixedPoint(dataWidth.W,binaryPoint.BP))
    // val dataOutGauss  = Output(UInt(16.W))
    val gaussValid    = Output(Bool())
    val grayValid     = Output(Bool())
  })

  val grayscale     = Module(new Grayscale(dataWidth,binaryPoint)).io
  // val gaussblur     = Module(new GaussianBlur(10,10)).io
  // val dilate        = Module(new Dilation(10,10)).io

  grayscale.dataIn        := io.dataIn
  grayscale.tready        := true.B
  io.dataOutGray          := grayscale.tdata

  // gaussblur.dataIn        := grayscale.tdata
  // gaussblur.tready        := true.B
  // gaussblur.t         := grayscale.tvalid
  // io.dataOutGauss          := gaussblur.tdata

  // io.gaussValid := gaussblur.tvalid
  io.grayValid := grayscale.tvalid

}
