package helpers.UInt8ToFixed32Tester

import chisel3._
import chisel3.iotesters.{ChiselFlatSpec, PeekPokeTester, TesterOptionsManager}

class UInt8ToFixed32UnitTester(c: UInt8ToFixed32) extends PeekPokeTester(c) {
  poke(c.io.input, 0)

  expect(c.io.output, 0x0)

  step(1)

  poke(c.io.input, 10)

  expect(c.io.output, 0xA)

  step(1)

  poke(c.io.input, 255)
  expect(c.io.output, 0xFFFFFFFF)
}

class UInt8ToFixed32Tester extends ChiselFlatSpec {
  "uint8tofixed32" should "work" in {
    iotesters.Driver.execute(() => new UInt8ToFixed32(), new TesterOptionsManager) {
      c => new UInt8ToFixed32UnitTester(c)
    } should be(true)
  }
}
