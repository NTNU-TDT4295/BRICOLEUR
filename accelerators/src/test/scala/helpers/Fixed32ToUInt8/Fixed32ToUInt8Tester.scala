package helpers.Fixed32ToUInt8

import chisel3._
import chisel3.iotesters._

class Fixed32ToUInt8UnitTester(c: Fixed32ToUInt8) extends PeekPokeTester(c) {
  poke(c.io.input, 0xFFFFFFFF)

  expect(c.io.output, 255)

  step(1)

  poke(c.io.input, 0x1)

  expect(c.io.output, 1)

  step(1)

  poke(c.io.input, 0x96)

  expect(c.io.output, 150)
}

class Fixed32ToUInt8Tester extends ChiselFlatSpec {
  "Fixed32ToUInt8tester" should "work" in {
    iotesters.Driver.execute(() => new Fixed32ToUInt8(), new TesterOptionsManager) {
      c => new Fixed32ToUInt8UnitTester(c)
    } should be(true)
  }
}
