package helpers.Inverter

import chisel3._
import chisel3.iotesters.{ChiselFlatSpec, PeekPokeTester, TesterOptionsManager}

class InverterUnitTester(c: Inverter) extends PeekPokeTester(c) {
  poke(c.io.dataIn, 1)

  expect(c.io.dataOut, 0)
  step(1)
  poke(c.io.dataIn, 0)
  expect(c.io.dataOut, 1)
}

class InverterTester extends ChiselFlatSpec {
  "Inverter" should "invert the input bit" in {
	iotesters.Driver.execute(() => new Inverter(), new TesterOptionsManager) {
	  c => new InverterUnitTester(c)
	} should be(true)
  }
}
