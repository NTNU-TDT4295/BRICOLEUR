import chisel3._
import chisel3.core.Input
import chisel3.iotesters.TesterOptionsManager
import chisel3.iotesters.PeekPokeTester
import chisel3.util.Counter

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

  //Screwy counter logic, no time to explain
  val counterStart = Counter(1+1+1+1+width-3+1+1+width-3+1+1)
  val counterEdge = Counter(2)
  val endOfOutput = Counter((width-2)*(height-2))
  //val counterWidth = RegInit(UInt(32.W), 0.U)
  //counterWidth := counterWidth
  val counterProcess = Counter(8)
  //val discard = Reginit()
  val computationStarted = RegInit(UInt(8.W), 0.U)
  //computationStarted := computationStarted
  val processWrapped = RegInit(UInt(8.W), 0.U)
  //countingToEdge := countingToEdge
  //val countingOverEdge = RegInit(UInt(8.W), 0.U)
  //countingOverEdge :=countingOverEdge
  val computationEnded = RegInit(UInt(8.W), 0.U)
  val delay1 = RegInit(UInt(8.W), 0.U)
   
  //processWrapped := delay1

  //val accProcess = RegInit(UInt(8.W), 0.U)
  //val accEdge = RegInit(UInt(8.W), 0.U)
  // accProcess := accProcess
  // accEdge := accEdge

  

  when(counterStart.inc()){
    computationStarted := 1.U
    //counterWidth := 1.U+counterWidth
    //io.valid := true.B
  }

  when(computationStarted === 1.U){
    
    when (processWrapped === 0.U){
      when(counterProcess.inc()){
        processWrapped := 1.U
      }
    }.otherwise{
      when(counterEdge.inc()){
        processWrapped := 0.U
      }
    }
  }
  when(processWrapped === 0.U && computationStarted === 1.U && computationEnded === 0.U){
    when(endOfOutput.inc()){
      computationEnded := 1.U
    }
    io.valid := true.B
  }.otherwise{
    io.valid := false.B
  }
  // Save these values, is used in the tester
  val myWidth = width
  val myHeight = height
  

  // K[0][0] K[1][0] K[2][0]  kernel element 0, 1, 2
  // K[0][1] K[1][1] K[2][1] kernel element 3, 4, 5
  // K[0][2] K[1][2] K[2][2] kernel element 6, 7, 8
  
  
  //See paper for explanation
  //Idea is deep pipelines
  //
  val fifo1_0 = Module(new FIFO(1))
  val fifo2_1 = Module(new FIFO(1))
  val fifo3_2 = Module(new FIFO(width-3))
  val fifo4_3 = Module(new FIFO(1))
  val fifo5_4 = Module(new FIFO(1))
  val fifo6_5 = Module(new FIFO(width-3))
  val fifo7_6 = Module(new FIFO(1))
  val fifo8_7 = Module(new FIFO(1))
  

  //println("Before fifo init")
  
  fifo8_7.io.dataIn := io.dataIn
  fifo7_6.io.dataIn := fifo8_7.io.dataOut
  fifo6_5.io.dataIn := fifo7_6.io.dataOut
  fifo5_4.io.dataIn := fifo6_5.io.dataOut
  fifo4_3.io.dataIn := fifo5_4.io.dataOut
  fifo3_2.io.dataIn := fifo4_3.io.dataOut
  fifo2_1.io.dataIn := fifo3_2.io.dataOut
  fifo1_0.io.dataIn := fifo2_1.io.dataOut
  
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
  val kernelC0  = 0.U
  val kernelC1  = 0.U
  val kernelC2  = 0.U
  val kernelC3  = 0.U
  val kernelC4  = 1.U
  val kernelC5  = 0.U
  val kernelC6  = 0.U
  val kernelC7  = 0.U
  val kernelC8  = 0.U
  
  
  kernel_8 := io.dataIn * kernelC8
  kernel_7 := fifo8_7.io.dataOut*kernelC7
  kernel_6 := fifo7_6.io.dataOut*kernelC6
  kernel_5 := fifo6_5.io.dataOut*kernelC5
  kernel_4 := fifo5_4.io.dataOut*kernelC4
  kernel_3 := fifo4_3.io.dataOut*kernelC3
  kernel_2 := fifo3_2.io.dataOut*kernelC2
  kernel_1 := fifo2_1.io.dataOut*kernelC1
  kernel_0 := fifo1_0.io.dataOut*kernelC0
  
  
  io.dataOut := kernel_0+kernel_1+kernel_2+kernel_3+kernel_4+kernel_5+kernel_6+kernel_7+kernel_8
  

}
//TEster for the Gauss module, lots of moving parts, this could probably be more elegant
class GaussTester(c: GaussianBlur) extends PeekPokeTester(c){
  //Testdata to be fed into the pipe
  
  var testArray = Array.fill(c.myWidth*c.myHeight) { 0.U }
  for (jj <- 0 until testArray.length){
    testArray(jj) = jj.U
    //testArray(jj) = 1.U
  }
  //Array for the values that comes out of the pipe
  val resultArray = Array.fill((c.myWidth-2)*(c.myHeight-2)){ 0 }
  
  var resultIndex = 0
  var ii = 0
  var isNotDone = true
  var steps = 0
  var max_steps = 10000
  var dataValid = 0
  while(isNotDone){ // Do some testing
    
    if (ii<testArray.length){
      //println("pushing data " + testArray(ii).toInt)
      poke(c.io.dataIn, testArray(ii))
      ii +=1
    }
    else{
      poke(c.io.dataIn, 0.U)
    }
 
    //println("data out is " + peek(c.io.dataOut).toInt)
    
    if(resultIndex<resultArray.length){
      dataValid = peek(c.io.valid).toInt
      if (dataValid==1){
        resultArray(resultIndex) = peek(c.io.dataOut).toInt
      
        //resultIndex +=1
         resultIndex +=1
      }
    }
    steps +=1
    step(1)// Cycles the module, letting registers update etc
   
    if (steps>max_steps){
      isNotDone = false
    }
  
  
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
    if ((ii%(c.myWidth-2))==0){
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



