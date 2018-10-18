package accelerators.FixedPoint

import chisel3._
import chisel3.core.FixedPoint
import chisel3.iotesters.{ChiselFlatSpec, PeekPokeTester, TesterOptionsManager}

class FPMulTesterv2(c: FixedPointMultiplyv2, w: Int, bp: Int) extends PeekPokeTester(c) {
  val factor = 2.0f
  var testArray = Array.fill(10) {
	BigInt(0)
  }
  var resultArray = Array.fill(10) {
	0.0f
  }

  for (ii <- 0 until 10) {
	poke(c.io.first, ii.U)
	// poke(c.io.factor, FixedPoint.fromDouble(1/factor,w.W, bp.BP))
	poke(c.io.second, 2)
	resultArray(ii) = ii / factor

	step(1)

	testArray(ii) = peek(c.io.fixedPointOut)
	println(testArray(ii).toString)

	var intpart = testArray(ii) >> bp
	var floatpart = (testArray(ii) & (1 << bp) - 1)
	var test = floatpart.toFloat / (1 << bp).toFloat

	println(s"${ii.toFloat} / $factor")
	println(s"got ${intpart}${test.toString.substring(1)} - should be ${resultArray(ii)}")
	println(s"integer part:\t${intpart}")
	println(s"fractional part:\t${floatpart}")
	println("")
  }
}


/**
  * Test using the FixedPoint class from chisel3.core
  * this might be sufficient for what we're trying to do?
  * I'm not sure.
  * - Joakim
  */
class FPMulTester(c: FixedPointMultiply, w: Int, bp: Int) extends PeekPokeTester(c) {
  val factor = 2.0f
  var testArray = Array.fill(10) {
	BigInt(0)
  }
  var resultArray = Array.fill(10) {
	0.0f
  }

  for (ii <- 0 until 10) {
	poke(c.io.first, ii.U);
	poke(c.io.factor, FixedPoint.fromDouble(1 / factor, w.W, bp.BP));
	resultArray(ii) = ii / factor

	step(1)

	testArray(ii) = peek(c.io.out)

	var intpart = testArray(ii) >> bp
	var floatpart = (testArray(ii) & (1 << bp) - 1)
	var test = floatpart.toFloat / (1 << bp).toFloat

	println(s"${ii.toFloat} / $factor")
	println(s"got ${intpart}${test.toString.substring(1)} - should be ${resultArray(ii)}")
	println(s"integer part:\t${intpart}")
	println(s"fractional part:\t${floatpart}")
	println("")
  }
}

class FixedPointTester extends ChiselFlatSpec {
  "FixedPoint" should "correctly handle fixed point calculations" in {
	// chisel3.iotesters.Driver.execute(() => new accelerators.Fixed(), new TesterOptionsManager) {(c) => new accelerators.FPCoreTester(c)}
	iotesters.Driver.execute(() => new FixedPointMultiply(16, 8), new TesterOptionsManager) {
	  c => new FPMulTester(c, 16, 8)
	}
	// chisel3.Driver.execute(args, () => new FixedPointMultiply(16,8))
  }
}
