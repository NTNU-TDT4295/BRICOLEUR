package accelerators.Grayscale

import chisel3._
import chisel3.iotesters.{ChiselFlatSpec, PeekPokeTester, TesterOptionsManager}

class GrayscaleUnitTester(c: Grayscale) extends PeekPokeTester(c) {
  poke(c.io.loadingValues, true.B)
  val array = Array(1, 2, 3)

  for (i <- array) {
	poke(c.io.dataIn, i)
	step(1)
  }

  poke(c.io.loadingValues, false.B)

  step(2)

  expect(c.io.dataOut, 2.U)
}

class GrayscaleTester extends ChiselFlatSpec {
  "Grayscale" should "correctly average a single RGB value" in {
	iotesters.Driver.execute(() => new Grayscale(), new TesterOptionsManager) {
	  c => new GrayscaleUnitTester(c)
	} should be(true)
  }
}