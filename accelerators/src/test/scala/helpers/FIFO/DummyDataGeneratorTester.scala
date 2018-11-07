package helpers.FIFO

import chisel3._
import chisel3.iotesters.{ChiselFlatSpec, PeekPokeTester, TesterOptionsManager}

class DummyDataGeneratorUnitTester(c: DummyDataGenerator) extends PeekPokeTester(c) {
  // Output is not valid at the first cycle
  expect(c.io.outputValid, false)

  step(2)

  // After two clock cycles it should have produced three values and then the output is valid.
  expect(c.io.outputValid, true)

  step(1)

  // After producing one pixel, it's gone back to false and therefore not ready (at the first cycle).
  expect(c.io.outputValid, false)

  step(2)

  // Second pixel produced, output is valid.
  expect(c.io.outputValid, true)
}

class DummyDataGeneratorTester extends ChiselFlatSpec {
  "DummyDataGenerator" should "correctly and continuously generate dummy data" in {
    iotesters.Driver.execute(() => new DummyDataGenerator(), new TesterOptionsManager) {
      c => new DummyDataGeneratorUnitTester(c)
    } should be(true)
  }
}
