package mainModule.MainModule

import chisel3._
import chisel3.core.FixedPoint
import chisel3.iotesters.{ChiselFlatSpec, PeekPokeTester, TesterOptionsManager}
import accelerators.Grayscale.Grayscale

class MainModuleUnitTester(c: MainModule, width: Int, height: Int) extends PeekPokeTester(c) {

  ////////
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
    2,3,4, // pixel 10

    1,2,3, // pixel 11
    2,3,4, // pixel 12
    3,4,5, // pixel 13
    4,5,6, // pixel 14
    1,2,3, // pixel 15
    2,3,4, // pixel 16
    3,4,5, // pixel 17
    4,5,6, // pixel 18
    1,2,3, // pixel 19
    2,3,4, // pixel 20

    1,2,3, // pixel 21
    2,3,4, // pixel 22
    3,4,5, // pixel 23
    4,5,6, // pixel 24
    1,2,3  // pixel 25
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
    719 ,
    975 ,
    1231,
    463 ,
    719 ,
    975 ,
    1231,
    463 ,
    719 ,
    975 ,
    1231,
    463 ,
    719 ,
    975 ,
    1231,
    463
  )
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
    30,
    33,
    36,
    39,
    42,
    45,
    48,
    51,
    54,
    57,
    60,
    63,
    66,
    69,
    72,
    75
  )

  // for (i <- array) {
  for( i <- 0 until 99 ){
    // println("cycle:"+ steps.toString+ "\t outputgrey: " + peek(c.io.dataOutGray).toString + "\tvalidgray: " + peek(c.io.grayValid).toString +" outputgauss: " + peek(c.io.dataOutGauss).toString() + "\tvalidgauss: " + peek(c.io.gaussValid).toString() )

    if(i < array.length){
      poke(c.io.dataIn, FixedPoint.fromDouble(array(i), 16.W, 8.BP))
    }
    else{
      poke(c.io.dataIn, FixedPoint.fromDouble(0, 16.W, 8.BP))
    }
	step(1)
    steps += 1
  }

    // println("cycle:"+ steps.toString+ "\t outputgrey: " + peek(c.io.dataOutGray).toString + "\tvalidgray: " + peek(c.io.grayValid).toString +" outputgauss: " + peek(c.io.dataOutGauss).toString() + "\tvalidgauss: " + peek(c.io.gaussValid).toString() )

  expect(c.io.gaussValid, 1)

}

class MainModuleTester extends ChiselFlatSpec {
  "MainModule" should "output something" in {
    iotesters.Driver.execute(() => new MainModule(16,8,10,10), new TesterOptionsManager) {
      c => new MainModuleUnitTester(c, 5,5)
    } should be(true)
  }
}
