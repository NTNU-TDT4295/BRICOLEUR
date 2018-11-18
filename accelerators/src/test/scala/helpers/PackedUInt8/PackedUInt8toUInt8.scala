package helpers.PackedUInt8

import chisel3._
import chisel3.iotesters.{ChiselFlatSpec, PeekPokeTester, TesterOptionsManager}

class PackedUInt8toUInt8UnitTester(c: PackedUInt8toUInt8) extends PeekPokeTester(c) {
  val input = c.io.input
  val output = c.io.output

  expect(input.ready, true)
  poke(input.bits.DATA, 0x03020100)
  poke(input.valid, true)
  poke(input.bits.LAST, false)

  step(1)

  poke(input.bits.DATA, 0x07060504)
  poke(input.bits.LAST, true)

  step(1)
  poke(input.valid, false)

  expect(output.valid, true)
  poke(output.ready, true)
  expect(output.bits.DATA, 0)
  expect(output.bits.LAST, false)

  step(1)

  expect(output.valid, true)
  poke(output.ready, true)
  expect(output.bits.DATA, 1)
  expect(output.bits.LAST, false)

  step(1)

  expect(output.valid, true)
  poke(output.ready, true)
  expect(output.bits.DATA, 2)
  expect(output.bits.LAST, false)

  step(1)

  expect(output.valid, true)
  poke(output.ready, true)
  expect(output.bits.DATA, 3)
  expect(output.bits.LAST, false)

  step(1)

  expect(output.valid, true)
  poke(output.ready, true)
  expect(output.bits.DATA, 4)
  expect(output.bits.LAST, false)

  step(1)

  expect(output.valid, true)
  poke(output.ready, true)
  expect(output.bits.DATA, 5)
  expect(output.bits.LAST, false)

  step(1)

  expect(output.valid, true)
  poke(output.ready, true)
  expect(output.bits.DATA, 6)
  expect(output.bits.LAST, false)

  step(1)

  expect(output.valid, true)
  poke(output.ready, true)
  expect(output.bits.DATA, 7)
  expect(output.bits.LAST, true)

  step(1)
  expect(output.valid, false)
}

class PackedUInt8toUInt8Tester extends ChiselFlatSpec {
  "PackedUInt8toUInt8" should "work" in {
    iotesters.Driver.execute(() => new PackedUInt8toUInt8(), new TesterOptionsManager) {
      c => new PackedUInt8toUInt8UnitTester(c)
    } should be(true)
  }
}
