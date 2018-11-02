package accelerators

import chisel3._
import helpers.Inverter
import helpers.FIFO.DummyDataGeneratorAXI
import accelerators.GaussianBlur.GaussianBlur
import accelerators.Dilation.Dilation
import accelerators.Grayscale.Grayscale

// This is the main to compile all needed modules to verilog, run the compile.sh script and look for them in verilog_files
object Verilogify extends App{
  chisel3.Driver.execute(args, () => new GaussianBlur(320, 240))
  chisel3.Driver.execute(args, ()=> new Inverter)
  chisel3.Driver.execute(args, ()=> new Dilation(320, 240))
  chisel3.Driver.execute(args, ()=> new Grayscale)
  chisel3.Driver.execute(args, ()=> new DummyDataGeneratorAXI)



}
