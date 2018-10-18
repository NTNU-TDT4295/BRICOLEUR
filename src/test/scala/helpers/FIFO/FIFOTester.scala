package helpers.FIFO

import chisel3._
import chisel3.iotesters.{ChiselFlatSpec, PeekPokeTester, TesterOptionsManager}

class FIFOUnitTester(c: FIFO) extends PeekPokeTester(c) {
  poke(c.io.dataIn, 3)

  step(6)

  val test = peek(c.io.dataOut)

  // TODO: This evaluates to true regardless of the expected value, so not sure what to do
  expectFixedPoint(c.io.dataOut, 3.0, "Didn't get expected fixed point")
}

class FIFOTester extends ChiselFlatSpec {
  "FIFO" should "correctly delay an element" in {
	iotesters.Driver.execute(() => new FIFO(5), new TesterOptionsManager) {
	  c => new FIFOUnitTester(c)
	} should be(true)
  }
}
