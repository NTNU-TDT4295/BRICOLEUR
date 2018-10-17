package accelerators.Grayscale

import chisel3._
import chisel3.core.FixedPoint
import chisel3.iotesters.{ChiselFlatSpec, PeekPokeTester, TesterOptionsManager}

class GrayscaleUnitTester(c: Grayscale) extends PeekPokeTester(c) {
  poke(c.io.loadingValues, true.B)
  val array = Array(1, 2, 3)

  for (i <- array) {
	poke(c.io.dataIn, FixedPoint.fromDouble(i, 16.W, 8.BP))
	step(1)
  }

  poke(c.io.loadingValues, false.B)

  step(2)

  // (463 & ((1 << 8) -1) = 207)
  // ((463 - 207 + 1) & ((1 << 8) - 1) = 1) integer value
  // (207 / (1 << 8) = 0,81) decimal value
  // 463 is equivalent to 1.81
  expect(c.io.dataOut, 463)
}

class GrayscaleTester extends ChiselFlatSpec {
  "Grayscale" should "correctly average a single RGB value" in {
	iotesters.Driver.execute(() => new Grayscale(), new TesterOptionsManager) {
	  c => new GrayscaleUnitTester(c)
	} should be(true)
  }
}