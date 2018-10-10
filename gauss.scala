import chisel3._
import chisel3.core.Input
import chisel3.iotesters.TesterOptionsManager
import chisel3.iotesters.PeekPokeTester

class FIFO(depth: Int) extends Module{
  val io = IO(new Bundle{
    val dataIn = Input(UInt(8.W))
    val dataOut = Output(UInt(8.W))
    //val move = Input(Bool())
    //val isFull = Output(Bool())
    //val isEmpty = Output(Bool())
    
  })
  val bank = Array.fill(depth) {RegInit(UInt(8.W), 0.U)}
  //println("Depth is", depth)
  if (depth > 1){
  
    for (ii <- 1 until depth){
      bank(ii) := bank(ii-1)
    }
  }
  io.dataOut := bank(depth-1)
  bank(0) := io.dataIn

}

class GaussianBlur(width: Int, height: Int) extends Module {
  val io = IO(new Bundle{
  val dataIn = Input(UInt(8.W))
  val dataOut = Output(UInt(8.W))
  val clock = Input(Bool())
  val valid = Output(Bool())

    })
  // Save these values, is used in the tester
  val myWidth = width
  val myHeight = height
  //io.dataIn := 0.U
  //io.dataOut := 1.U
  //io.clock := false.B
  io.valid := false.B //TODO: figure out if possible to assert a data valid signal


  // K[0][0] K[1][0] K[2][0]  kernel element 0, 1, 2
  // K[0][1] K[1][1] K[2][1] kernel element 3, 4, 5
  // K[0][2] K[1][2] K[2][2] kernel element 6, 7, 8
  
  
  //See paper for explanation
  //Idea is deep pipelines
  //
  val fifo0_1 = Module(new FIFO(1))
  val fifo1_2 = Module(new FIFO(1))
  val fifo2_3 = Module(new FIFO(width-3))
  val fifo3_4 = Module(new FIFO(1))
  val fifo4_5 = Module(new FIFO(1))
  val fifo5_6 = Module(new FIFO(width-3))
  val fifo6_7 = Module(new FIFO(1))
  val fifo7_8 = Module(new FIFO(1))
  

  //println("Before fifo init")
  
  fifo0_1.io.dataIn := io.dataIn
  fifo1_2.io.dataIn := fifo0_1.io.dataOut
  fifo2_3.io.dataIn := fifo1_2.io.dataOut
  fifo3_4.io.dataIn := fifo2_3.io.dataOut
  fifo4_5.io.dataIn := fifo3_4.io.dataOut
  fifo5_6.io.dataIn := fifo4_5.io.dataOut
  fifo6_7.io.dataIn := fifo5_6.io.dataOut
  fifo7_8.io.dataIn := fifo6_7.io.dataOut
  
  //fifo7_8.io.dataOut := 0.U // Is this necessary?

  //println("Got to after fifo wiring")

  val kernel_0 = RegInit(UInt(8.W), 0.U)
  val kernel_1 = RegInit(UInt(8.W), 0.U)
  val kernel_2 = RegInit(UInt(8.W), 0.U)
  val kernel_3 = RegInit(UInt(8.W), 0.U)
  val kernel_4 = RegInit(UInt(8.W), 0.U)
  val kernel_5 = RegInit(UInt(8.W), 0.U)
  val kernel_6 = RegInit(UInt(8.W), 0.U)
  val kernel_7 = RegInit(UInt(8.W), 0.U)
  val kernel_8 = RegInit(UInt(8.W), 0.U)
  

  
  //Kernel constants 
  val kernelC0  = 1.U
  val kernelC1  = 2.U
  val kernelC2  = 3.U
  val kernelC3  = 4.U
  val kernelC4  = 5.U
  val kernelC5  = 6.U
  val kernelC6  = 7.U
  val kernelC7  = 8.U
  val kernelC8  = 9.U
  
  
  kernel_0 := io.dataIn * kernelC0
  kernel_1 := fifo0_1.io.dataOut*kernelC1
  kernel_2 := fifo1_2.io.dataOut*kernelC2
  kernel_3 := fifo2_3.io.dataOut*kernelC3
  kernel_4 := fifo2_3.io.dataOut*kernelC4
  kernel_5 := fifo3_4.io.dataOut*kernelC5
  kernel_6 := fifo4_5.io.dataOut*kernelC6
  kernel_7 := fifo5_6.io.dataOut*kernelC7
  kernel_8 := fifo6_7.io.dataOut*kernelC8


  io.dataOut := kernel_0+kernel_1+kernel_2+kernel_3+kernel_4+kernel_5+kernel_6+kernel_7+kernel_8


}
//TEster for the Gauss module, lots of moving parts, this could probably be more elegant
class GaussTester(c: GaussianBlur) extends PeekPokeTester(c){
  //Testdata to be fed into the pipe
  val testArray = Array.fill(c.myWidth*c.myHeight) { 1.U }
  //Array for the values that comes out of the pipe
  val resultArray = Array.fill(2*c.myWidth*c.myHeight){ 0 }
  
  var resultIndex = 0
  var ii = 0
  var isNotDone = true

  while(isNotDone){
    
    if (ii<testArray.length){
      //println("pushing data " + testArray(ii).toInt)
      poke(c.io.dataIn, testArray(ii))
      ii +=1
    }
    else{
      poke(c.io.dataIn, 0.U)
    }

    //if (peek(c.io.dataOut).toInt != 0){
    
      //println("data out is " + peek(c.io.dataOut).toInt)
      resultArray(resultIndex) = peek(c.io.dataOut).toInt
      resultIndex +=1
      if(resultIndex==resultArray.length){
        isNotDone=false
      }
    //}
    step(1)// Cycles the module, letting registers update etc

  }

  // Below is output formatting to get a nice overview of what is happening
  var inputString = ""
  var outputString = ""

  for (ii <- 0 until testArray.length){
    if ((ii%c.myWidth)==0){
      inputString += "\n"
    }
    inputString += testArray(ii).toInt + "\t"
  }
  for (ii <- 0 until resultArray.length){
    if ((ii%c.myWidth)==0){
      outputString += "\n"
    }
    outputString += resultArray(ii).toInt + "\t"

  }
  println(inputString)
  println(outputString)


}
/**
object GaussDriver extends App{
  chisel3.Driver.execute(args, () => new GaussianBlur )
  
}
*/
// after copying the file, run sbt, then compile, then run the Tester
object Tester extends App{
  //val gauss = new GaussianBlur
  
  // The arguments for GaussianBlur determines the dimensions of the data to be put in, aka the image size
  chisel3.iotesters.Driver.execute(() => new GaussianBlur(10, 10), new TesterOptionsManager) {(c) => new GaussTester(c)}   

}



