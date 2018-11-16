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

  for (i <- 0 until numberOfElements) {
    image1(i) = i
  }

  // Second image initialization
  val image2: Array[Int] = image1.clone().reverse

  // Result image
  val resultValues: Array[UInt] = Array.fill(numberOfElements) {
    0.U
  }

  /*
  This is the expected output:
    99 97 95 93 91 89 87 85 83 81
    79 77 75 73 71 69 67 65 63 61
    59 57 55 53 51 49 47 45 43 41
    39 37 35 33 31 29 27 25 23 21
    19 17 15 13 11  9  7  5  3  1
    1  3  5  7  9 11 13 15 17 19
    21 23 25 27 29 31 33 35 37 39
    41 43 45 47 49 51 53 55 57 59
    61 63 65 67 69 71 73 75 77 79
    81 83 85 87 89 91 93 95 97 99
   */
  val firstPart: Array[UInt] = Array.fill(numberOfElements / 2) {
    1.U
  }

  for (i <- firstPart.indices) {
    if (i > 0) {
      firstPart(i) = (1 + 2 * i).U
    } else {
      firstPart(i) = 1.U
    }
  }

  val expectedResults: Array[UInt] = firstPart.clone().reverse ++ firstPart

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
  }

  print("\n=========== Output from absdiff ================== \n\n")
  val arrayToEnumerat: Array[UInt] = expectedResults
  var otherCounter = 0
  print("\t")
  for (i <- arrayToEnumerat.indices) {
    if (arrayToEnumerat(i).toInt <= 10) {
      // Pad the first ten numbers for b-e-a-utiful output
      print(s"% 2d ".format(arrayToEnumerat(i).toInt))
    } else {
      print(s"${arrayToEnumerat(i).toInt} ")
    }

    if (otherCounter == 9) {
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
    val p = Array(10, 10, 32, 16)
    iotesters.Driver.execute(() => new Absdiff(p(0), p(1), p(2), p(3)), new TesterOptionsManager) {
      c => new AbsdiffUnitTester(c, p(0), p(1), p(2), p(3))
    } should be(true)
  }
}


