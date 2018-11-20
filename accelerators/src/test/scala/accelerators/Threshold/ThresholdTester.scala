package accelerators.Threshold

import chisel3._
import chisel3.iotesters.{ChiselFlatSpec, PeekPokeTester, TesterOptionsManager}

class ThresholdUnitTester(c: Threshold) extends PeekPokeTester(c) {
  val testValues = Array(35, 70, 100, 10, 40, 255)
  val expectedValues = Array(0, 255, 255, 0, 0, 255)

  poke(c.io.tvalidIn, true.B)

  for (i <- testValues.indices) {
    poke(c.io.dataIn, testValues(i))
    expect(c.io.tdata, expectedValues(i))
  }
}

class ThresholdTester extends ChiselFlatSpec {
  "threshold" should "work" in {
    iotesters.Driver.execute(() => new Threshold(40), new TesterOptionsManager) {
      c => new ThresholdUnitTester(c)
    } should be(true)
  }
}


