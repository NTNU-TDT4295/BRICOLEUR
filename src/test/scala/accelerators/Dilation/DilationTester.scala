package accelerators.Dilation

import chisel3._
import chisel3.iotesters.{ChiselFlatSpec, PeekPokeTester, TesterOptionsManager}

/**
  * Test the dilation module
  * @param c: The dilation module to be tested
  */
class DilationUnitTester(c: Dilation) extends PeekPokeTester(c) {
  //Testdata to be fed into the pipe

  var testArray: Array[UInt] = Array.fill(c.myWidth * c.myHeight) {
	0.U
  }
  for (jj <- testArray.indices) {
	testArray(jj) = jj.U
  }
  //Array for the values that comes out of the pipe
  val resultArray: Array[Int] = Array.fill((c.myWidth - 2) * (c.myHeight - 2)) {
	0
  }

  var resultIndex = 0
  var ii = 0
  var isNotDone = true
  var steps = 0
  var max_steps = 10000
  var dataValid = 0
  while (isNotDone) { // Do some testing

	if (ii < testArray.length) {
	  poke(c.io.dataIn, testArray(ii))
	  ii += 1
	}
	else {
	  poke(c.io.dataIn, 0.U)
	}


	if (resultIndex < resultArray.length) {
	  dataValid = peek(c.io.valid).toInt
	  if (dataValid == 1) {
		resultArray(resultIndex) = peek(c.io.dataOut).toInt

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
  val bp = 8

  for (ii <- testArray.indices) {
	if ((ii % c.myWidth) == 0) {
	  inputString += "\n"
	}
	inputString += testArray(ii).toInt + "\t"

  }
  println(inputString)
  for (ii <- resultArray.indices) {
	if ((ii % (c.myWidth - 2)) == 0) {
	  println("")
	}
	var intpart = resultArray(ii) >> bp
	val floatpart = resultArray(ii) & (1 << bp) - 1
	val test = floatpart.toFloat / (1 << bp).toFloat
	print(s"${resultArray(ii)}${test.toString.substring(1)} ")

  }

  println(outputString)
}

class DilationTester extends ChiselFlatSpec {
  "Dilation" should "correctly dilate an image" in {
	// The arguments for Dilation determines the dimensions of the data to be put in, aka the image size
	iotesters.Driver.execute(() => new Dilation(10, 10), new TesterOptionsManager) {
	  c => new DilationUnitTester(c)
	}
  }
}