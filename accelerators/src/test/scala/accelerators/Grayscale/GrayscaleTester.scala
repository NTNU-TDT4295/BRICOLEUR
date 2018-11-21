package accelerators.Grayscale

import java.awt.image.BufferedImage
import java.io._

import chisel3._
import chisel3.core.FixedPoint
import chisel3.iotesters.{ChiselFlatSpec, PeekPokeTester, TesterOptionsManager}
import javax.imageio.ImageIO


class GrayscaleOne(c: Grayscale) extends PeekPokeTester(c) {
  //poke(c.io.loadingValues, true.B)
  val array = Array(1, 2, 3)
  var steps = 0
  poke(c.io.tready, true.B)
  for (i <- array) {

    println("cycle:" + steps.toString + "\t output: " + peek(c.io.tdata).toString() + "\tvalid: " + peek(c.io.tvalid).toString())

    poke(c.io.dataIn, FixedPoint.fromDouble(i, 16.W, 8.BP))
    step(1)
    steps += 1
  }

  println("cycle:" + steps.toString + "\t output: " + peek(c.io.tdata).toString() + "\tvalid: " + peek(c.io.tvalid).toString())

  // (463 & ((1 << 8) -1) = 207)
  // ((463 - 207 + 1) & ((1 << 8) - 1) = 1) integer value
  // (207 / (1 << 8) = 0,81) decimal value
  // 463 is equivalent to 1.81
  expect(c.io.tvalid, 1)
  expect(c.io.tdata, 463)
}

class GrayscaleImageTester(c: Grayscale) extends PeekPokeTester(c) {
  /* Load testimage from file, and read out the individual RGB values */
  val image = ImageIO.read(new File("data/image.jpg"))
  val height = image.getHeight
  val width = image.getWidth
  val chiselImage = new BufferedImage(width, height, image.getType())
  val testImage = new BufferedImage(width, height, image.getType())

  poke(c.io.tready, true.B)
  /* Loop through the chisel component, and check that the value is the same as the calculated manually*/
  var error = 0;
  for (y <- 0 until height) {
    for (x <- 0 until width) {
      val color = image.getRGB(x, y)
      val red = ((color & 0xff0000) >> 16)
      val green = ((color & 0xff00) >> 8)
      val blue = ((color & 0xff))
      val testColor = (0.3 * red + 0.59 * green + 0.11 * blue)
      testImage.setRGB(x, y, testColor.toInt * (65536 + 256 + 1))

      //poke(c.io.loadingValues, true.B)
      poke(c.io.dataIn, red << 7)
      step(1)
      poke(c.io.dataIn, green << 7)
      step(1)
      poke(c.io.dataIn, blue << 7)

      val chiselColor = (peek(c.io.tdata) >> 7)

      chiselImage.setRGB(x, y, chiselColor.toInt * (65536 + 256 + 1))

      step(1)

      error = error + Math.abs(chiselColor.toInt - testColor.toInt)

    }
  }
  //

  /* Show the loaded images */
  ImageIO.write(testImage, "jpg", new File("data/grayscale/testImage.jpg"))
  ImageIO.write(chiselImage, "jpg", new File("data/grayscale/chiselImage.jpg"))

  println(s"Error: $error")

  //Check that the average error is less than 1
  expect(((error / (width * height)) < 55555.0).B, true.B)
}

class GrayscaleSeveral(c: Grayscale) extends PeekPokeTester(c) {
  //poke(c.io.loadingValues, true.B)
  val array = Array(1, 2, 3, 2, 3, 4, 3, 4, 5, 4, 5, 6)
  var steps = 0
  var index = 0
  val expected = Array(463, 719, 975, 1231) //TODO: 32bit 16 BP fixpoint nao
  val cycles = Array(3, 6, 9, 12)
  poke(c.io.tvalidIn, true.B)
  poke(c.io.tready, true.B)
  for (i <- array) {
    println("cycle:" + steps.toString + "\t output: " + peek(c.io.tdata).toString() + "\tvalid: " + peek(c.io.tvalid).toString())

    poke(c.io.dataIn, FixedPoint.fromDouble(i, 16.W, 8.BP))
    step(1)
    steps += 1
    if (steps == cycles(index)) {
      expect(c.io.tvalid, 1)
      expect(c.io.tdata, expected(index))
      index += 1
    }
  }

  println("cycle:" + steps.toString + "\t output: " + peek(c.io.tdata).toString() + "\tvalid: " + peek(c.io.tvalid).toString())

  expect(c.io.tvalid, 1)
  expect(c.io.tdata, 1231)

}

class GrayscaleTester extends ChiselFlatSpec {
  "Grayscale" should "correctly average a single RGB value" in {
    iotesters.Driver.execute(() => new Grayscale(32,16), new TesterOptionsManager) {
      c => new GrayscaleOne(c)
    } should be(true)
  }
  /*"Grayscale" should "correctly grayscale any image" in {
    iotesters.Driver.execute(() => new Grayscale(), new TesterOptionsManager) {
      c => new GrayscaleImageTester(c)
    } should be(true)
  }
  */
  "Grayscale" should "correctly average four RGB values" in {
    iotesters.Driver.execute(() => new Grayscale(32,16), new TesterOptionsManager) {
      c => new GrayscaleSeveral(c)
    } should be(true)
  }
}
