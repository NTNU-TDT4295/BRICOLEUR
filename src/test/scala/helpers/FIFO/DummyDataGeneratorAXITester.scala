package helpers.FIFO

import chisel3._
import chisel3.iotesters.{ChiselFlatSpec, PeekPokeTester, TesterOptionsManager}

class DummyDataGeneratorAXIUnitTester(c: DummyDataGeneratorAXI) extends PeekPokeTester(c) {
  expect(c.io.tvalid, true)
  expect(c.io.tkeep, 1) // 4 bit signal is high => (1111)_2 = (15)_10
  expect(c.io.tlast, false)
  expect(c.io.tdata, 0)

  step(1)

  expect(c.io.tvalid, true)
  expect(c.io.tkeep, 1) // 4 bit signal is high => (1111)_2 = (15)_10
  expect(c.io.tlast, false)
  expect(c.io.tdata, 4294967295L)

  step(1)

  expect(c.io.tvalid, true)
  expect(c.io.tkeep, 1) // 4 bit signal is high => (1111)_2 = (15)_10
  expect(c.io.tlast, false)
  expect(c.io.tdata, 0)

  step(1)

  expect(c.io.tvalid, true)
  expect(c.io.tkeep, 1) // 4 bit signal is high => (1111)_2 = (15)_10
  expect(c.io.tlast, false)
  expect(c.io.tdata, 4294967295L)
}

class DummyDataGeneratorAXITester extends ChiselFlatSpec {
  "DummyDataGenerator" should "correctly and continuously generate dummy data" in {
    iotesters.Driver.execute(() => new DummyDataGeneratorAXI(), new TesterOptionsManager) {
      c => new DummyDataGeneratorAXIUnitTester(c)
    } should be(true)
  }
}
