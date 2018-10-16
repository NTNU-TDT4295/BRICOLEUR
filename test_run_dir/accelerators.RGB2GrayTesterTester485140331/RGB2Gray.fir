;buildInfoPackage: chisel3, version: 3.1.3, scalaVersion: 2.11.12, sbtVersion: 1.1.1, builtAtString: 2018-09-12 19:37:29.007, builtAtMillis: 1536781049007
circuit RGB2Gray : 
  module RGB2Gray : 
    input clock : Clock
    input reset : UInt<1>
    output io : {flip dataIn : UInt<8>, flip loadingValues : UInt<1>, dataOut : UInt<8>, dataValid : UInt<1>}
    
    reg v : UInt, clock with : (reset => (reset, UInt<1>("h00"))) @[Grayscale.scala 21:18]
    reg value : UInt<2>, clock with : (reset => (reset, UInt<2>("h00"))) @[Counter.scala 26:33]
    io.dataValid <= UInt<1>("h00") @[Grayscale.scala 24:16]
    io.dataOut <= UInt<1>("h00") @[Grayscale.scala 25:14]
    when io.loadingValues : @[Grayscale.scala 28:26]
      node _T_19 = add(v, io.dataIn) @[Grayscale.scala 29:16]
      node _T_20 = tail(_T_19, 1) @[Grayscale.scala 29:16]
      v <= _T_20 @[Grayscale.scala 29:11]
      skip @[Grayscale.scala 28:26]
    node _T_22 = eq(value, UInt<2>("h02")) @[Counter.scala 34:24]
    node _T_24 = add(value, UInt<1>("h01")) @[Counter.scala 35:22]
    node _T_25 = tail(_T_24, 1) @[Counter.scala 35:22]
    value <= _T_25 @[Counter.scala 35:13]
    when _T_22 : @[Counter.scala 37:21]
      value <= UInt<1>("h00") @[Counter.scala 37:29]
      skip @[Counter.scala 37:21]
    when _T_22 : @[Grayscale.scala 32:23]
      io.dataValid <= UInt<1>("h01") @[Grayscale.scala 33:22]
      node _T_29 = div(v, UInt<2>("h03")) @[Grayscale.scala 34:25]
      io.dataOut <= _T_29 @[Grayscale.scala 34:20]
      skip @[Grayscale.scala 32:23]
    
