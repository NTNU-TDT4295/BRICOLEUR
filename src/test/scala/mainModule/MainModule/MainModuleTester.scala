package mainModule.MainModule

import chisel3._
import chisel3.core.FixedPoint
import chisel3.iotesters.{ChiselFlatSpec, PeekPokeTester, TesterOptionsManager}
import accelerators.Grayscale.Grayscale

class MainModuleUnitTester(c: MainModule, width: Int, height: Int) extends PeekPokeTester(c) {

  ////////
  // TODO:
  // Push "image data" the correct way
  // check output from greyscale
  //
  // TODO:
  // Push output from greyscale to gauss
  // in a proper way
  // check output from gauss
  //
  // TODO:
  // Push output from gauss to dilate
  // in a proper way
  // check output from dilate
  //
  // TODO:
  // Check final output
  // from the complete pipeline
  ////////

  poke(c.io.loadingValues, true.B)
  val array = Array(
    1,2,3, // pixel 1
    2,3,4, // pixel 2
    3,4,5, // pixel 3
    4,5,6, // pixel 4
    1,2,3, // pixel 5
    2,3,4, // pixel 6
    3,4,5, // pixel 7
    4,5,6, // pixel 8
    1,2,3, // pixel 9
    2,3,4  // pixel 10
  )
  var steps = 0
  var index = 0
  val expected = Array(
    463 ,
    719 ,
    975 ,
    1231,
    463 ,
    719 ,
    975 ,
    1231,
    463 ,
    719)
  val cycles   = Array(
    3 ,
    6 ,
    9 ,
    12,
    15,
    18,
    21,
    24,
    27,
    30
  )

  // for (i <- array) {
  for( i <- 0 until 99 ){
    println("cycle:"+ steps.toString+ "\t outputgrey: " + peek(c.io.dataOutGray).toString + "\tvalidgray: " + peek(c.io.grayValid).toString +" outputgauss: " + peek(c.io.dataOutGauss).toString() + "\tvalidgauss: " + peek(c.io.gaussValid).toString() )

	poke(c.io.dataIn, FixedPoint.fromDouble(i, 16.W, 8.BP))
	step(1)
    steps += 1
  }

    println("cycle:"+ steps.toString+ "\t outputgrey: " + peek(c.io.dataOutGray).toString + "\tvalidgray: " + peek(c.io.grayValid).toString +" outputgauss: " + peek(c.io.dataOutGauss).toString() + "\tvalidgauss: " + peek(c.io.gaussValid).toString() )

  expect(c.io.gaussValid, 1)

}

class MainModuleTester extends ChiselFlatSpec {
  "MainModule" should "output something" in {
    iotesters.Driver.execute(() => new MainModule(16,8,10,10), new TesterOptionsManager) {
      c => new MainModuleUnitTester(c, 10, 10)
    } should be(true)
  }
}
