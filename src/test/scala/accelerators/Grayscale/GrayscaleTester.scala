package accelerators.Grayscale

import chisel3._
import chisel3.core.FixedPoint
import chisel3.iotesters.{ChiselFlatSpec, PeekPokeTester, TesterOptionsManager}


class GrayscaleOne(c: Grayscale) extends PeekPokeTester(c) {
  poke(c.io.loadingValues, true.B)
  val array = Array(1, 2, 3)
  var steps = 0

  for (i <- array) {

    println("cycle:"+ steps.toString +"\t output: " + peek(c.io.dataOut).toString() + "\tvalid: " + peek(c.io.dataValid).toString() )

	poke(c.io.dataIn, FixedPoint.fromDouble(i, 16.W, 8.BP))
	step(1)
    steps += 1
  }

  println("cycle:"+ steps.toString +"\t output: " + peek(c.io.dataOut).toString() + "\tvalid: " + peek(c.io.dataValid).toString() )

  // (463 & ((1 << 8) -1) = 207)
  // ((463 - 207 + 1) & ((1 << 8) - 1) = 1) integer value
  // (207 / (1 << 8) = 0,81) decimal value
  // 463 is equivalent to 1.81
  expect(c.io.dataValid, 1)
  expect(c.io.dataOut, 463)
}

class GrayscaleSeveral(c: Grayscale) extends PeekPokeTester(c) {
  poke(c.io.loadingValues, true.B)
  val array = Array( 1,2,3, 2,3,4, 3,4,5, 4,5,6)
  var steps = 0
  var index = 0
  val expected = Array(463,719,975,1231)
  val cycles   = Array(3,6,9,12)

  for (i <- array) {
    println("cycle:"+ steps.toString +"\t output: " + peek(c.io.dataOut).toString() + "\tvalid: " + peek(c.io.dataValid).toString() )

	poke(c.io.dataIn, FixedPoint.fromDouble(i, 16.W, 8.BP))
	step(1)
    steps += 1
    if(steps == cycles(index)){
      expect(c.io.dataValid, 1)
      expect(c.io.dataOut, expected(index))
      index += 1
    }
  }

  println("cycle:"+ steps.toString +"\t output: " + peek(c.io.dataOut).toString() + "\tvalid: " + peek(c.io.dataValid).toString() )

  expect(c.io.dataValid, 1)
  expect(c.io.dataOut, 1231)

}

class GrayscaleTester extends ChiselFlatSpec {
  "Grayscale" should "correctly average a single RGB value" in {
	iotesters.Driver.execute(() => new Grayscale(), new TesterOptionsManager) {
	  c => new GrayscaleOne(c)
	} should be(true)
  }

  "Grayscale" should "correctly average four RGB values" in {
	iotesters.Driver.execute(() => new Grayscale(), new TesterOptionsManager) {
	  c => new GrayscaleSeveral(c)
	} should be(true)
  }
}
