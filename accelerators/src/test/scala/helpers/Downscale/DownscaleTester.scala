package helpers.Downscale

import java.awt.image.BufferedImage
import java.io._

import chisel3._
import chisel3.iotesters.{ChiselFlatSpec, PeekPokeTester, TesterOptionsManager}
import javax.imageio.ImageIO

class DownscaleUnitTester(c: Downscale) extends PeekPokeTester(c) {
  val image = ImageIO.read(new File("src/test/scala/helpers/Downscale/gray.png"))
  val outputImage = new BufferedImage(c.newWidth, c.newHeight, image.getType)

  var nextX = 0
  var nextY = 0
  var validCount = 0

  for (y <- 0 until c.originalHeight) {
    for (x <- 0 until c.originalWidth) {
      val gray = image.getRGB(x, y) & 0xFF

      poke(c.io.dataIn, gray.toInt << 16)

      val hasValidData = peek(c.io.dataValid).toInt
      if (hasValidData == 1) {
        validCount += 1

        val output = peek(c.io.dataOut).toInt >> 16

        outputImage.setRGB(nextX, nextY, (output << 16) + (output << 8) + output)

        if (nextX == c.newWidth - 1) {
          nextX = 0
          nextY += 1
        } else {
          nextX += 1
        }
      }

      step(1)
    }
  }

  ImageIO.write(outputImage, "jpg", new File("src/test/scala/helpers/Downscale/outputImage.jpg"))
}

class DownscaleTester extends ChiselFlatSpec {
  "Downscale" should "work" in {
    iotesters.Driver.execute(() => new Downscale(
      1280,
      960,
      320,
      240,
      32,
      16), new TesterOptionsManager) {
      c => new DownscaleUnitTester(c)
    }
  }
}
