module Inverter( // @[:@3.2]
  input   clock, // @[:@4.4]
  input   reset, // @[:@5.4]
  input   io_dataIn, // @[:@6.4]
  output  io_dataOut // @[:@6.4]
);
  assign io_dataOut = ~ io_dataIn; // @[Inverter.scala 13:14:@9.4]
endmodule
