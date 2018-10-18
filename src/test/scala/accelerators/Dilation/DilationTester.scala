package accelerators.Dilation

import chisel3._
import chisel3.iotesters.{ChiselFlatSpec, PeekPokeTester, TesterOptionsManager}

//accelerators.Dilation.Tester for the Dilation module, lots of moving parts, this could probably be more elegant
// TODO:
// rewrite for use with sbt test
// expect some nice shit
//  - Joakim
class DilationUnitTester(c: Dilation) extends PeekPokeTester(c) {
  //Testdata to be fed into the pipe

  var testArray = Array.fill(c.myWidth * c.myHeight) {
	0.U
  }
  for (jj <- 0 until testArray.length) {
	testArray(jj) = jj.U
  }
  //Array for the values that comes out of the pipe
  val resultArray = Array.fill((c.myWidth - 2) * (c.myHeight - 2)) {
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

  for (ii <- 0 until testArray.length) {
	if ((ii % c.myWidth) == 0) {
	  inputString += "\n"
	}
	inputString += testArray(ii).toInt + "\t"

  }
  println(inputString)
  for (ii <- 0 until resultArray.length) {
	if ((ii % (c.myWidth - 2)) == 0) {
	  println("")
	}
	var intpart = resultArray(ii) >> bp
	var floatpart = (resultArray(ii) & (1 << bp) - 1)
	var test = floatpart.toFloat / (1 << bp).toFloat
	print(s"${resultArray(ii)}${test.toString.substring(1)} ")

  }
  println(outputString)


}

// after copying the file, run sbt, then compile, then run the Tester
class DilationTester extends ChiselFlatSpec {
  "Dilation" should "correctly dilate an image" in {
	//chisel3.Driver.execute(args, () => new GaussianBlur(320, 240))
	// The arguments for Dilation determines the dimensions of the data to be put in, aka the image size
	iotesters.Driver.execute(() => new Dilation(10, 10), new TesterOptionsManager) {
	  c => new DilationUnitTester(c)
	}
  }
}