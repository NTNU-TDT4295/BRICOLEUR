import chisel3._
import chisel3.iotesters.TesterOptionsManager
import chisel3.iotesters.PeekPokeTester
import chisel3.core.FixedPoint
import chisel3.core.Data

/**
 * Wrapper for doing fixed point division
 * Note that the output unsigned integer
 * represents the bytes of the fixed point number
 * FIXME - question:
 * Do we want the output to be a single unsigned int, like now
 * or do we want it to output two numbers, being the integer and fractional parts
 */
class FixedPointMultiply(width: Int, binaryPoint: Int) extends Module {
  val io = IO(new Bundle {
    val first  = Input(FixedPoint(width.W,binaryPoint.BP))
    val factor = Input(FixedPoint(width.W,binaryPoint.BP))
    val out    = Output(UInt(width.W))
  })

  val factor = RegInit(FixedPoint(width.W,binaryPoint.BP),FixedPoint.fromDouble(0.5,width.W,binaryPoint.BP))
  io.out := ( io.first * factor).asUInt
  // io.out := ( io.first * io.factor).asUInt
}


class FixedPointMultiplyv2(width: Int, binaryPoint: Int) extends Module {
  val io = IO(new Bundle {
    val first         = Input (UInt(width.W))
    val second        = Input (UInt(width.W))
    // val integerOut    = Output(UInt(width.W))
    // val fractionalOut = Output(UInt(width.W))
    val fixedPointOut = Output(UInt(64.W))
  })

  val operand1 = RegInit(UInt(width.W), 0.U)
  val operand2 = RegInit(UInt(width.W), 0.U)

  operand1 := (io.first << binaryPoint.U)
  operand2 := (io.second << binaryPoint.U)
  // result := operand1.asUInt * operand2.asUInt
  // io.fixedPointOut := ( (io.first << binaryPoint.U) * (io.second << binaryPoint.U) ).asUInt
  io.fixedPointOut := operand1.asUInt * operand2.asUInt
}

class FPMulTesterv2(c: FixedPointMultiplyv2, w: Int, bp: Int) extends PeekPokeTester(c){
  val factor = 2.0f
  var testArray = Array.fill(10) { BigInt(0) }
  var resultArray = Array.fill(10) { 0.0f }

  for(ii <- 0 until 10){
    poke(c.io.first, ii.U)
    // poke(c.io.factor, FixedPoint.fromDouble(1/factor,w.W, bp.BP))
    poke(c.io.second, 2)
    resultArray(ii) = ii/factor

    step(1)

    testArray(ii) = peek(c.io.fixedPointOut)
    println(testArray(ii).toString)

    var intpart =  testArray(ii) >> bp
    var floatpart = (testArray(ii) & (1 << bp)-1)
    var test = floatpart.toFloat / (1 << bp).toFloat

    println(s"${ii.toFloat} / $factor")
    println(s"got ${intpart}${test.toString.substring(1)} - should be ${resultArray(ii)}")
    println(s"integer part:\t${intpart}")
    println(s"fractional part:\t${floatpart}")
    println("")
  }
}


/**
 * Test using the FixedPoint class from chisel3.core
 * this might be sufficient for what we're trying to do?
 * I'm not sure.
 * - Joakim
 */
class FPMulTester(c: FixedPointMultiply, w: Int, bp: Int) extends PeekPokeTester(c){
  val factor = 2.0f
  var testArray = Array.fill(10) { BigInt(0) }
  var resultArray = Array.fill(10) { 0.0f }

  for(ii <- 0 until 10){
    poke(c.io.first, ii.U);
    poke(c.io.factor, FixedPoint.fromDouble(1/factor, w.W, bp.BP));
    resultArray(ii) = ii/factor

    step(1)

    testArray(ii) = peek(c.io.out)

    var intpart =  testArray(ii) >> bp
    var floatpart = (testArray(ii) & (1 << bp)-1)
    var test = floatpart.toFloat / (1 << bp).toFloat

    println(s"${ii.toFloat} / $factor")
    println(s"got ${intpart}${test.toString.substring(1)} - should be ${resultArray(ii)}")
    println(s"integer part:\t${intpart}")
    println(s"fractional part:\t${floatpart}")
    println("")
  }
}

object fixedTester extends App{
  // chisel3.iotesters.Driver.execute(() => new FixedPointMultiplyv2(16,8), new TesterOptionsManager) {(c) => new FPMulTesterv2(c,16,8)}
  chisel3.iotesters.Driver.execute(() => new FixedPointMultiply(16,8), new TesterOptionsManager) {(c) => new FPMulTester(c,16,8)}
  // chisel3.Driver.execute(args, () => new FixedPointMultiply(16,8))

}
