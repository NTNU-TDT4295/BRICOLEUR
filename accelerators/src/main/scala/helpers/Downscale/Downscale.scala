package helpers.Downscale

import chisel3._
import chisel3.core.FixedPoint
import chisel3.util.Counter

/**
  * Based on 1280 x 960 resolution IN and 320 x 240 OUT
  *
  * @param originalWidth
  * @param originalHeight
  * @param newWidth
  * @param newHeight
  * @param dataWidth
  * @param binaryPoint
  */
class Downscale(val originalWidth: Int,
                val originalHeight: Int,
                val newWidth: Int,
                val newHeight: Int,
                val dataWidth: Int,
                val binaryPoint: Int) extends Module {
  val io = IO(new Bundle {
    val dataIn = Input(FixedPoint(dataWidth.W, binaryPoint.BP))
    val dataOut = Output(FixedPoint(dataWidth.W, binaryPoint.BP))
    val dataValid = Output(Bool())
  })

  // Initialization
  io.dataOut := 0.U.asFixedPoint(binaryPoint.BP)
  io.dataValid := false.B

  // Number of columns that should be skipped between two non-ignored columns
  val interColumnSkipCounter = Counter(originalWidth / newWidth)
  // Number of rows that should be skipped between two non-ignored rows
  val interRowSkipCount = Counter(originalHeight / newHeight)

  val skipRow = RegInit(Bool(), true.B)
  val skipColumn = RegInit(Bool(), true.B)

  val columnCounter = Counter(originalWidth)
  val rowCounter = Counter(originalHeight)

  when(columnCounter.inc()) {
    // Assume we're skipping a row
    skipRow := true.B

    when(interRowSkipCount.inc()) {
      // We have counted to a row that should not be ignored
      skipRow := false.B
    }
  }

  when(!skipRow) {
    // We're currently on a row that should not be ignored.
    when(interColumnSkipCounter.inc()) {
      // At this point we have skipped enough of the previous rows and skipped enough of the columns on this
      // non-ignored row, so output a value.
      io.dataValid := true.B
      io.dataOut := io.dataIn
    }
  }
}
