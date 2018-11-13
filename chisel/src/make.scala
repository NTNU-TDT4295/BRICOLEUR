import chisel3._
import chisel3.util._

object MakeCircuits extends App {
	def compile(target: String, dut: () => chisel3.experimental.RawModule) = {
		val args = s"--target-dir ip/${target}".split(" +")
		chisel3.Driver.execute(args, dut)
	}

    compile("OV5642", () => new OV5642())
}
