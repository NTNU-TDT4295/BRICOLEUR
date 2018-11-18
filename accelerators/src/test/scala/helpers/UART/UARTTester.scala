package helpers.UART

import chisel3._
import chisel3.iotesters.{ChiselFlatSpec, PeekPokeTester, TesterOptionsManager}

class UARTUnitTester(c: UARTMain) extends PeekPokeTester(c) {
  poke(c.io.rxd, 1)

  expect(c.io.rxd, 0)
}

class UARTTester extends ChiselFlatSpec {
  "UART" should "correctly function" in {
    iotesters.Driver.execute(() => new UARTMain(50000000, 115200), new TesterOptionsManager) {
      c => new UARTUnitTester(c)
    } should be(true)
  }
}
