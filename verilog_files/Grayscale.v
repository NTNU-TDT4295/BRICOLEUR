module Grayscale( // @[:@3.2]
  input         clock, // @[:@4.4]
  input         reset, // @[:@5.4]
  input  [15:0] io_dataIn, // @[:@6.4]
  input         io_loadingValues, // @[:@6.4]
  output [15:0] io_dataOut, // @[:@6.4]
  output        io_dataValid // @[:@6.4]
);
  reg [15:0] out; // @[Grayscale.scala 27:20:@8.4]
  reg [31:0] _RAND_0;
  reg  started; // @[Grayscale.scala 29:23:@9.4]
  reg [31:0] _RAND_1;
  reg [1:0] value; // @[Counter.scala 26:33:@10.4]
  reg [31:0] _RAND_2;
  wire  _T_21; // @[Grayscale.scala 36:28:@14.6]
  wire [31:0] _T_22; // @[Grayscale.scala 37:24:@16.8]
  wire  _GEN_1; // @[Grayscale.scala 39:20:@18.8]
  wire [23:0] _GEN_11; // @[Grayscale.scala 36:37:@15.6]
  wire [23:0] _GEN_12; // @[Grayscale.scala 36:37:@15.6]
  wire [31:0] _GEN_2; // @[Grayscale.scala 36:37:@15.6]
  wire  _GEN_3; // @[Grayscale.scala 36:37:@15.6]
  wire  _GEN_4; // @[Grayscale.scala 36:37:@15.6]
  wire  _T_26; // @[Grayscale.scala 46:28:@25.6]
  wire [31:0] _T_27; // @[Grayscale.scala 47:31:@27.8]
  wire [31:0] _GEN_15; // @[Grayscale.scala 47:18:@28.8]
  wire [32:0] _T_28; // @[Grayscale.scala 47:18:@28.8]
  wire [31:0] _T_29; // @[Grayscale.scala 47:18:@29.8]
  wire [31:0] _T_30; // @[Grayscale.scala 47:18:@30.8]
  wire [31:0] _GEN_5; // @[Grayscale.scala 46:37:@26.6]
  wire  _T_32; // @[Grayscale.scala 49:28:@33.6]
  wire [31:0] _T_33; // @[Grayscale.scala 50:31:@35.8]
  wire [32:0] _T_34; // @[Grayscale.scala 50:18:@36.8]
  wire [31:0] _T_35; // @[Grayscale.scala 50:18:@37.8]
  wire [31:0] _T_36; // @[Grayscale.scala 50:18:@38.8]
  wire [31:0] _GEN_6; // @[Grayscale.scala 49:37:@34.6]
  wire [31:0] _GEN_7; // @[Grayscale.scala 35:26:@13.4]
  wire  _GEN_9; // @[Grayscale.scala 35:26:@13.4]
  wire [2:0] _T_40; // @[Counter.scala 35:22:@43.4]
  wire [1:0] _T_41; // @[Counter.scala 35:22:@44.4]
  wire [1:0] _GEN_10; // @[Counter.scala 37:21:@46.4]
  wire [23:0] _GEN_21; // @[Grayscale.scala 37:11:@17.8 Grayscale.scala 47:11:@31.8 Grayscale.scala 50:11:@39.8]
  wire [15:0] _GEN_22; // @[Grayscale.scala 37:11:@17.8 Grayscale.scala 47:11:@31.8 Grayscale.scala 50:11:@39.8]
  assign _T_21 = value == 2'h0; // @[Grayscale.scala 36:28:@14.6]
  assign _T_22 = $signed(io_dataIn) * $signed(16'sh4d); // @[Grayscale.scala 37:24:@16.8]
  assign _GEN_1 = started ? started : 1'h1; // @[Grayscale.scala 39:20:@18.8]
  assign _GEN_11 = {{8{out[15]}},out}; // @[Grayscale.scala 36:37:@15.6]
  assign _GEN_12 = $signed(_GEN_11) << 8; // @[Grayscale.scala 36:37:@15.6]
  assign _GEN_2 = _T_21 ? $signed(_T_22) : $signed({{8{_GEN_12[23]}},_GEN_12}); // @[Grayscale.scala 36:37:@15.6]
  assign _GEN_3 = _T_21 ? started : 1'h0; // @[Grayscale.scala 36:37:@15.6]
  assign _GEN_4 = _T_21 ? _GEN_1 : started; // @[Grayscale.scala 36:37:@15.6]
  assign _T_26 = value == 2'h1; // @[Grayscale.scala 46:28:@25.6]
  assign _T_27 = $signed(io_dataIn) * $signed(16'sh97); // @[Grayscale.scala 47:31:@27.8]
  assign _GEN_15 = {{8{_GEN_12[23]}},_GEN_12}; // @[Grayscale.scala 47:18:@28.8]
  assign _T_28 = $signed(_GEN_15) + $signed(_T_27); // @[Grayscale.scala 47:18:@28.8]
  assign _T_29 = _T_28[31:0]; // @[Grayscale.scala 47:18:@29.8]
  assign _T_30 = $signed(_T_29); // @[Grayscale.scala 47:18:@30.8]
  assign _GEN_5 = _T_26 ? $signed(_T_30) : $signed(_GEN_2); // @[Grayscale.scala 46:37:@26.6]
  assign _T_32 = value == 2'h2; // @[Grayscale.scala 49:28:@33.6]
  assign _T_33 = $signed(io_dataIn) * $signed(16'sh1c); // @[Grayscale.scala 50:31:@35.8]
  assign _T_34 = $signed(_GEN_15) + $signed(_T_33); // @[Grayscale.scala 50:18:@36.8]
  assign _T_35 = _T_34[31:0]; // @[Grayscale.scala 50:18:@37.8]
  assign _T_36 = $signed(_T_35); // @[Grayscale.scala 50:18:@38.8]
  assign _GEN_6 = _T_32 ? $signed(_T_36) : $signed(_GEN_5); // @[Grayscale.scala 49:37:@34.6]
  assign _GEN_7 = io_loadingValues ? $signed(_GEN_6) : $signed({{8{_GEN_12[23]}},_GEN_12}); // @[Grayscale.scala 35:26:@13.4]
  assign _GEN_9 = io_loadingValues ? _GEN_4 : started; // @[Grayscale.scala 35:26:@13.4]
  assign _T_40 = value + 2'h1; // @[Counter.scala 35:22:@43.4]
  assign _T_41 = _T_40[1:0]; // @[Counter.scala 35:22:@44.4]
  assign _GEN_10 = _T_32 ? 2'h0 : _T_41; // @[Counter.scala 37:21:@46.4]
  assign io_dataOut = out; // @[Grayscale.scala 33:14:@12.4]
  assign io_dataValid = io_loadingValues ? _GEN_3 : 1'h0; // @[Grayscale.scala 32:16:@11.4 Grayscale.scala 40:22:@19.10]
  assign _GEN_21 = _GEN_7[31:8]; // @[Grayscale.scala 37:11:@17.8 Grayscale.scala 47:11:@31.8 Grayscale.scala 50:11:@39.8]
  assign _GEN_22 = _GEN_21[15:0]; // @[Grayscale.scala 37:11:@17.8 Grayscale.scala 47:11:@31.8 Grayscale.scala 50:11:@39.8]
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE
  integer initvar;
  initial begin
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
  `ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  out = _RAND_0[15:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_1 = {1{`RANDOM}};
  started = _RAND_1[0:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_2 = {1{`RANDOM}};
  value = _RAND_2[1:0];
  `endif // RANDOMIZE_REG_INIT
  end
`endif // RANDOMIZE
  always @(posedge clock) begin
    if (reset) begin
      out <= 16'sh0;
    end else begin
      out <= $signed(_GEN_22);
    end
    if (reset) begin
      started <= 1'h0;
    end else begin
      if (io_loadingValues) begin
        if (_T_21) begin
          if (!(started)) begin
            started <= 1'h1;
          end
        end
      end
    end
    if (reset) begin
      value <= 2'h0;
    end else begin
      if (_T_32) begin
        value <= 2'h0;
      end else begin
        value <= _T_41;
      end
    end
  end
endmodule
