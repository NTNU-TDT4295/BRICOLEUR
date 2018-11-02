package accelerators.GaussianBlur

import chisel3._
import chisel3.core.{FixedPoint}
import chisel3.iotesters.{ChiselFlatSpec, PeekPokeTester, TesterOptionsManager}
import java.awt.image.BufferedImage
import javax.imageio.ImageIO

//accelerators.GaussianBlur.Tester for the Gauss module,
//lots of moving parts, this could probably be more elegant
// TODO:
// expect some nice shit
//  - Joakim

class GaussianBlurUnitTester(c: GaussianBlur) extends PeekPokeTester(c) {
  //Testdata to be fed into the pipe

  var testArray = Array.fill(c.myWidth * c.myHeight) {
    FixedPoint.fromDouble(0, 32.W, 16.BP)
  }
  for (jj <- 0 until testArray.length) {
	testArray(jj) = FixedPoint.fromDouble(127, 32.W, 16.BP)
  }
  //Array for the values that comes out of the pipe
  val resultArray = Array.fill((c.myWidth - 2) * (c.myHeight - 2)) {
	0
  }

  var resultIndex = 0
  var ii          = 0
  var isNotDone   = true
  var steps       = 0
  var max_steps   = 80000
  var dataValid   = 0
  poke(c.io.tvalidIn,true.B)
  poke(c.io.tready,true.B)
  step(1);
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
  var inputString  = ""
  var outputString = ""
  val bp           = 16

  for (ii <- 0 until testArray.length) {
	if ((ii % c.myWidth) == 0) {
	  inputString += "\n"
	}
    inputString += ( testArray(ii).toInt >> bp ) + "\t"

  }
  println(inputString)
  for (ii <- 0 until resultArray.length) {
	if ((ii % (c.myWidth - 2)) == 0) {
	  println("")
	}
    // print(s"${resultArray(ii)} ")
	var intpart = resultArray(ii) >> bp
	var floatpart = (resultArray(ii) & (1 << bp) - 1)
	var test = floatpart.toFloat / (1 << bp).toFloat
	print(s"${intpart} ")
	// print(s"${intpart}${test.toString.substring(1)} ")

  }
  println(outputString)


}


class GaussGeneralTester(c: GaussianBlurGeneral) extends PeekPokeTester(c) {
  var validCounter = 0
  for(i <- 0 until 200){
    poke(c.io.dataIn, FixedPoint.fromDouble(10.0, 32.W, 16.BP))
    poke(c.io.writeEnable, true.B)

    step(1)
    println("")
    print(peek(c.io.dataOut))
    print(" ")
    val valid = peek(c.io.valid).toInt

    validCounter += valid

  }
  print("Valid Counter: ")
  print(validCounter)
}


//Test that the gaussian blur element is working with an actual image
/*
class GaussianImageTester(c: GaussianBlur) extends PeekPoketester {
  //Load the image
  val image = ImageIO.read(new File("data/image.jpg"))
  val height = image.getHeight
  val width = image.getWidth
  val chiselImage = new BuffredIMage(width, height, image.getType)
  val testImage = new BuffredIMage(width, height, image.getType)

  //Do the gaussian blur in scala


  //Do the gaussian blur with chisel


  //Verify the results


  //Save the images
}
*/

// after copying the file, run sbt, then compile, then run the Tester
class GaussianBlurTester extends ChiselFlatSpec {

  "GaussianBlur" should "correctly blur an image" in {
	//chisel3.Driver.execute(args, () => new GaussianBlur(320, 240))
	// The arguments for GaussianBlur determines the dimensions of the data to be put in, aka the image size
	iotesters.Driver.execute(() => new GaussianBlur(320,240), new TesterOptionsManager) {
	  c => new GaussianBlurUnitTester(c)
	}
  }

  // "GaussianBlurGeneral" should "work" in {
  //   iotesters.Driver.execute(() => new GaussianBlurGeneral(30, 240, 5, 0.84), new TesterOptionsManager) {
  //     c => new GaussGeneralTester(c)
  //   }
  // }
}
