package accelerators.Absdiff

import chisel3._
import chisel3.iotesters.{ChiselFlatSpec, PeekPokeTester, TesterOptionsManager}

class AbsdiffUnitTester(c: Absdiff, width: Int, height: Int, dataWidth: Int, binaryPoint: Int) extends PeekPokeTester(c) {
  poke(c.io.lastIn, false.B)
  val numberOfElements: Int = (width - 2) * (height - 2)

  // First image initialization
  val image1: Array[Int] = Array.fill(numberOfElements) {
    0
  }

  for (i <- 0 until numberOfElements) {
    image1(i) = i
  }

  // Second image initialization
  val image2: Array[Int] = image1.clone().reverse

  // Result image
  val resultValues: Array[UInt] = Array.fill(numberOfElements) {
    0.U
  }

  // Send all but the last value
  for (i <- 0 until image1.length - 1) {
    poke(c.io.input, image1(i))
    step(1)
  }

  // Sending out the last value
  poke(c.io.lastIn, true.B)
  poke(c.io.input, image1.last)

  // Wait a cycle so that the first output value can be computed
  step(1)

  for (i <- resultValues.indices) {
    poke(c.io.input, image2(i))
    resultValues(i) = peek(c.io.output).U
    expect(c.io.output, Math.abs(image1(i) - image2(i)))
    step(1)
  }

  print("\n=========== Output from absdiff ================== \n")
  var otherCounter = 0
  for (i <- resultValues.indices) {
    if (resultValues(i).toInt < 11) {
      // Pad the first ten numbers for b-e-a-utiful output
      print(s"% 2d ".format(resultValues(i).toInt))
    } else {
      print(s"${resultValues(i).toInt} ")
    }

    if (otherCounter == 9) {
      print("\n")
      otherCounter = 0
    } else {
      otherCounter += 1
    }
  }
}

class AbsdiffTester extends ChiselFlatSpec {
  "absdiff" should "work" in {
    val p = Array(12, 12, 32, 16)
    iotesters.Driver.execute(() => new Absdiff(p(0), p(1), p(2), p(3)), new TesterOptionsManager) {
      c => new AbsdiffUnitTester(c, p(0), p(1), p(2), p(3))
    } should be(true)
  }
}


