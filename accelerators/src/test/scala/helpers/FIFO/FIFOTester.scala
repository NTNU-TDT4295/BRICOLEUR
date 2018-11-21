package helpers.FIFO

import chisel3._
import chisel3.iotesters.{ChiselFlatSpec, PeekPokeTester, TesterOptionsManager}

class FIFOUnitTester(c: FIFO) extends PeekPokeTester(c) {
  poke(c.io.dataIn, 3)

  step(5)

  expect(c.io.dataOut, 3)
}

class FIFOTester extends ChiselFlatSpec {
  "FIFO" should "correctly delay an element" in {
    iotesters.Driver.execute(() => new FIFO(5, 32, 16), new TesterOptionsManager) {
      c => new FIFOUnitTester(c)
    } should be(true)
  }
}
