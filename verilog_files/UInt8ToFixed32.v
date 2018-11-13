module UInt8ToFixed32( // @[:@3.2]
  input         clock, // @[:@4.4]
  input         reset, // @[:@5.4]
  input  [7:0]  io_input, // @[:@6.4]
  output [31:0] io_output // @[:@6.4]
);
  wire [38:0] _GEN_0; // @[UInt8ToFixed32.scala 12:24:@8.4]
  wire [38:0] _T_10; // @[UInt8ToFixed32.scala 12:24:@8.4]
  assign _GEN_0 = {{31'd0}, io_input}; // @[UInt8ToFixed32.scala 12:24:@8.4]
  assign _T_10 = _GEN_0 << 5'h10; // @[UInt8ToFixed32.scala 12:24:@8.4]
  assign io_output = _T_10[31:0]; // @[UInt8ToFixed32.scala 12:13:@9.4]
endmodule
