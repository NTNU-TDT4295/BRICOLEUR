package accelerators

import chisel3._
import accelerators.Absdiff.Absdiff
import accelerators.Dilation.Dilation
import accelerators.GaussianBlur.GaussianBlur
import accelerators.Grayscale.Grayscale
import accelerators.Threshold.Threshold
import helpers.FIFO.DummyDataGeneratorAXI
import helpers.Fixed32ToUInt8.Fixed32ToUInt8
import helpers.Inverter.Inverter
import helpers.UInt8ToFixed32Tester.UInt8ToFixed32

// This is the main to compile all needed modules to verilog, run the compile.sh script and look for them in verilog_files
object Verilogify extends App {
  chisel3.Driver.execute(args, () => new GaussianBlur(320, 240, 32, 16))
  chisel3.Driver.execute(args, () => new Inverter)
  chisel3.Driver.execute(args, () => new Dilation(320, 240, 32, 16))
  chisel3.Driver.execute(args, () => new Grayscale(32, 16))
  chisel3.Driver.execute(args, () => new DummyDataGeneratorAXI)
  chisel3.Driver.execute(args, () => new UInt8ToFixed32)
  chisel3.Driver.execute(args, () => new Fixed32ToUInt8)
  chisel3.Driver.execute(args, () => new Absdiff(318, 238, 32, 16))
  chisel3.Driver.execute(args, () => new Threshold(40))
}
