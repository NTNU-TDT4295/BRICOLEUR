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
  poke(c.io.tvalidIn, false.B)

  val numberOfElements: Int = width * height

  // First image initialization
  val image1: Array[Int] = Array.fill(numberOfElements) {
    0
  }

  // Second image initialization
  val image2: Array[Int] = Array.fill(numberOfElements) {
    0
  }

  for (i <- 0 until numberOfElements) {
    image1(i) = 0
    image2(i) = 127
  }

  // Result image
  val resultValues: Array[UInt] = Array.fill(numberOfElements) {
    0.U
  }

  // Expected values
  val firstPart: Array[UInt] = Array.fill(numberOfElements) {
    127.U
  }

  val expectedResults: Array[UInt] = firstPart

  poke(c.io.tvalidIn, true.B)

  // Send all but the last value
  for (i <- image1.indices) {
    poke(c.io.dataIn, image1(i))

    if (i == image1.length - 1) {
      // If we're at the last index, assert that this is in fact the last index
      poke(c.io.lastIn, true.B)
    } else {
      step(1)
    }
  }

  step(1)

  poke(c.io.lastIn, false.B)

  for (i <- resultValues.indices) {
    poke(c.io.dataIn, image2(i))

    step(1)

    resultValues(i) = peek(c.io.tdata).U
    expect(c.io.tdata, expectedResults(i))

    if (i == resultValues.length - 1) {
      expect(c.io.lastOut, true.B)
    } else {
      expect(c.io.lastOut, false.B)
    }
  }

  print("\n=========== Output from absdiff ================== \n\n")
  val arrayToEnumerate: Array[UInt] = resultValues
  var otherCounter = 0
  print("\t")
  for (i <- arrayToEnumerate.indices) {
    if (arrayToEnumerate(i).toInt <= 10) {
      // Pad the first ten numbers for b-e-a-utiful output
      print(s"% 2d ".format(arrayToEnumerate(i).toInt))
    } else {
      print(s"${arrayToEnumerate(i).toInt} ")
    }

    if (otherCounter == width - 1) {
      print("\n\t")
      otherCounter = 0
    } else {
      otherCounter += 1
    }
  }
  print("\n=========== Output from absdiff ==================\n\n")
}

class AbsdiffTester extends ChiselFlatSpec {
  "absdiff" should "work" in {
    val p = Array(320, 240, 32, 16)
    iotesters.Driver.execute(() => new Absdiff(p(0), p(1), p(2), p(3)), new TesterOptionsManager) {
      c => new AbsdiffUnitTester(c, p(0), p(1), p(2), p(3))
    } should be(true)
  }
}


