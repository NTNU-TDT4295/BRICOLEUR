package accelerators.Dilation

import chisel3._
import chisel3.iotesters.{ChiselFlatSpec, PeekPokeTester, TesterOptionsManager}
import chisel3.core.{FixedPoint}

/**
  * Test the dilation module
  *
  * @param c : The dilation module to be tested
  */
class DilationUnitTester(c: Dilation, dataWidth:Int, binaryPoint:Int) extends PeekPokeTester(c) {
  //Testdata to be fed into the pipe

  var testArray = Array.fill(c.myWidth * c.myHeight) {
    FixedPoint.fromDouble(0, dataWidth.W, binaryPoint.BP)
  }
  for (jj <- testArray.indices) {
	testArray(jj) = FixedPoint.fromDouble(jj, dataWidth.W, binaryPoint.BP)
  }
  //Array for the values that comes out of the pipe
  val resultArray: Array[Int] = Array.fill((c.myWidth - 2) * (c.myHeight - 2)) {
    0
  }

  var resultIndex = 0
  var ii = 0
  var isNotDone = true
  var steps = 0

  // FIXME:
  // finn på noe smart
  // med denne variablene
  // max_steps
  // - Joakim
  var max_steps = 80000
  var dataValid = 0
  poke(c.io.tvalidIn, true.B)
  poke(c.io.tready, true.B)
  step(1)
  while (isNotDone) { // Do some testing
    if (ii < testArray.length) {
      poke(c.io.dataIn, testArray(ii))
      ii += 1
    }
    else {
      poke(c.io.dataIn, 0.U)
    }


    if (resultIndex < resultArray.length) {
      dataValid = peek(c.io.tvalid).toInt
      if (dataValid == 1) {
        resultArray(resultIndex) = peek(c.io.tdata).toInt

        resultIndex += 1
      }
    }
    steps += 1
    step(1) // Cycles the module, letting registers update etc

    if (steps > max_steps) { // Runs until designated amount of cycles has passed
      isNotDone = false
    }
  }

  // Below is output formatting to get a nice overview of what is happening
  var inputString = ""
  var outputString = ""

  for (ii <- testArray.indices) {
    if ((ii % c.myWidth) == 0) {
      inputString += "\n"
    }
    inputString += ( testArray(ii).toInt >> binaryPoint ) + "\t"

  }
  println(inputString)
  for (ii <- resultArray.indices) {
    if ((ii % (c.myWidth - 2)) == 0) {
      println("")
    }
    var intpart = resultArray(ii) >> binaryPoint
    val floatpart = resultArray(ii) & (1 << binaryPoint) - 1
    val test = floatpart.toFloat / (1 << binaryPoint).toFloat
    print(s"${intpart}${test.toString.substring(1)} ")

  }

  println(outputString)
}

class DilationTester extends ChiselFlatSpec {
  val dataWidth:Int = 32
  val binaryPoint:Int = 16
  "Dilation" should "correctly dilate an image" in {
    // The arguments for Dilation determines the dimensions of the data to be put in, aka the image size
    iotesters.Driver.execute(() => new Dilation(10, 10,dataWidth,binaryPoint), new TesterOptionsManager) {
      c => new DilationUnitTester(c,dataWidth,binaryPoint)
    }
  }
}
