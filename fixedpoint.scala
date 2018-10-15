import chisel3._
import chisel3.iotesters.TesterOptionsManager
import chisel3.iotesters.PeekPokeTester
import chisel3.core.FixedPoint
import chisel3.core.Data

class Fixed() extends Module {
  val io = IO(new Bundle {
    val input   = Input(UInt(32.W))
    val inputFP = Input(FixedPoint(32.W,16.BP))
    val outFP   = Output(UInt(32.W))
    val out     = Output(UInt(32.W))
    val const   = Output(UInt(32.W))
  })

  val factorFP  = RegInit(FixedPoint(32.W,16.BP),FixedPoint.fromDouble(0.5,32.W,16.BP))
  val factor    = RegInit(UInt(32.W),2.U)

  io.outFP := ( factorFP * io.inputFP ).asUInt
  io.out := io.input * factor
  io.const := 1.U

}

/**
 * Wrapper for doing fixed point division
 * Note that the output unsigned integer
 * represents the bytes of the fixed point number
 */
class FixedPointMultiply(width: Int, binaryPoint: Int) extends Module {
  val io = IO(new Bundle {
    val first  = Input(FixedPoint(width.W,binaryPoint.BP))
    val factor = Input(FixedPoint(width.W,binaryPoint.BP))
    val out    = Output(UInt(width.W))
  })

  io.out := ( io.first * io.factor).asUInt
}


/**
 * Testing the wrapper class for fixed point division
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
    var floatpart = ( testArray(ii) & (1 << bp) -1 )
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
class FPCoreTester(c: Fixed) extends PeekPokeTester(c){
  for (ii <- 0 until 100){
    poke(c.io.inputFP, FixedPoint.fromBigInt(ii.U,32.W,16.BP))
    poke(c.io.input, ii.U)
    step(1)

    var res = peek(c.io.outFP);
    var intpart =  res >> 16
    var floatpart = ( res & (1 << 16) -1 )
    var test = floatpart.toFloat / (1 << 16).toFloat

    println(s"res: $res")
    println(s"integer part:\t${intpart}")
    println(s"fractional part:\t${floatpart}")
    println(s"test part:\t${test}")
  }
}

object fixedTester extends App{
  // chisel3.iotesters.Driver.execute(() => new Fixed(), new TesterOptionsManager) {(c) => new FPCoreTester(c)}
  chisel3.iotesters.Driver.execute(() => new FixedPointMultiply(16,8), new TesterOptionsManager) {(c) => new FPMulTester(c,16,8)}
  chisel3.Driver.execute(args, () => new FixedPointMultiply(16,8))

}
