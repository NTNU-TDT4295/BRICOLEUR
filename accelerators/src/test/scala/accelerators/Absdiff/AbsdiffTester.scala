package accelerators.Absdiff

import chisel3._
import chisel3.iotesters.{PeekPokeTester, ChiselFlatSpec, TesterOptionsManager}

/**
  * The test works like this: First fill up Absdiff with image 1, which is an array of integer values from 0
  * to (width - 2) * (height - 2), which for example is 10 * 10, which results in 100
  *
  * @param c           : Absdiff module
  * @param width       : Width of image
  * @param height      : Height of image
  * @param dataWidth   : dataWidth of bus
  * @param binaryPoint : binaryPoint of bus
  */
class AbsdiffUnitTester(c: Absdiff, width: Int, height: Int, dataWidth: Int, binaryPoint: Int) extends PeekPokeTester(c) {
  poke(c.io.lastIn, false.B)

  val numberOfElements: Int = width * height

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
  for (i <- image1.indices) {
    // If we're at the last index, assert that this is in fact the last index
    if (i == image1.length - 1) {
      poke(c.io.lastIn, true.B)
      poke(c.io.input, image1(i))
    } else {
      poke(c.io.input, image1(i))
      step(1)
    }
  }

  // Wait a cycle so that the first output value can be computed
  step(1)

  poke(c.io.lastIn, false.B)

  for (i <- resultValues.indices) {
    poke(c.io.input, image2(i))
    step(1)
    val actualOutput = peek(c.io.output).U
    var expectedOutput = 0.U

    if (image1(i) >= image2(i)) {
      expectedOutput = Math.abs(image1(i) - image2(i)).asUInt()
    } else {
      expectedOutput = Math.abs(image2(i) - image1(i)).asUInt()
    }

    resultValues(i) = actualOutput
    expect(c.io.output, expectedOutput)
  }

  print("\n=========== Output from absdiff ================== \n")
  var otherCounter = 0
  for (i <- resultValues.indices) {
    if (resultValues(i).toInt <= 10) {
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
    val p = Array(10, 10, 32, 16)
    iotesters.Driver.execute(() => new Absdiff(p(0), p(1), p(2), p(3)), new TesterOptionsManager) {
      c => new AbsdiffUnitTester(c, p(0), p(1), p(2), p(3))
    } should be(true)
  }
}


