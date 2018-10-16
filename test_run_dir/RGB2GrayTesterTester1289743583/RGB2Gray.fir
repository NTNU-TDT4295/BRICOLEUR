;buildInfoPackage: chisel3, version: 3.1.3, scalaVersion: 2.11.12, sbtVersion: 1.1.1, builtAtString: 2018-09-12 19:37:29.007, builtAtMillis: 1536781049007
circuit accelerators.RGB2Gray :
  module accelerators.RGB2Gray :
    input clock : Clock
    input reset : UInt<1>
    output io : {flip dataIn : UInt<8>, flip loadingValues : UInt<1>, dataOut : UInt<8>, dataValid : UInt<1>}
    
    reg v : UInt, clock with : (reset => (reset, UInt<1>("h00"))) @[grayscale.scala 19:18]
    reg value : UInt<2>, clock with : (reset => (reset, UInt<2>("h00"))) @[Counter.scala 26:33]
    io.dataValid <= UInt<1>("h00") @[grayscale.scala 22:16]
    io.dataOut <= UInt<1>("h00") @[grayscale.scala 23:14]
    when io.loadingValues : @[grayscale.scala 26:26]
      node _T_19 = add(v, io.dataIn) @[grayscale.scala 27:16]
      node _T_20 = tail(_T_19, 1) @[grayscale.scala 27:16]
      v <= _T_20 @[grayscale.scala 27:11]
      skip @[grayscale.scala 26:26]
    node _T_22 = eq(value, UInt<2>("h02")) @[Counter.scala 34:24]
    node _T_24 = add(value, UInt<1>("h01")) @[Counter.scala 35:22]
    node _T_25 = tail(_T_24, 1) @[Counter.scala 35:22]
    value <= _T_25 @[Counter.scala 35:13]
    when _T_22 : @[Counter.scala 37:21]
      value <= UInt<1>("h00") @[Counter.scala 37:29]
      skip @[Counter.scala 37:21]
    when _T_22 : @[grayscale.scala 30:23]
      io.dataValid <= UInt<1>("h01") @[grayscale.scala 31:22]
      node _T_29 = div(v, UInt<2>("h03")) @[grayscale.scala 32:25]
      io.dataOut <= _T_29 @[grayscale.scala 32:20]
      skip @[grayscale.scala 30:23]
    
