module Fixed32ToUInt8( // @[:@3.2]
  input         clock, // @[:@4.4]
  input         reset, // @[:@5.4]
  input  [31:0] io_input, // @[:@6.4]
  output [7:0]  io_output // @[:@6.4]
);
  wire [31:0] _T_10; // @[Fixed32ToUInt8.scala 11:24:@8.4]
  assign _T_10 = io_input >> 5'h10; // @[Fixed32ToUInt8.scala 11:24:@8.4]
  assign io_output = _T_10[7:0]; // @[Fixed32ToUInt8.scala 11:13:@9.4]
endmodule
