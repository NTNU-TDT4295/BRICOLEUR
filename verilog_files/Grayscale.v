module Grayscale( // @[:@3.2]
  input         clock, // @[:@4.4]
  input         reset, // @[:@5.4]
  input  [15:0] io_dataIn, // @[:@6.4]
  input         io_loadingValues, // @[:@6.4]
  output [15:0] io_dataOut, // @[:@6.4]
  output        io_dataValid // @[:@6.4]
);
  reg [15:0] b0; // @[Grayscale.scala 28:19:@8.4]
  reg [31:0] _RAND_0;
  reg [15:0] b1; // @[Grayscale.scala 29:19:@9.4]
  reg [31:0] _RAND_1;
  reg [15:0] b2; // @[Grayscale.scala 30:19:@10.4]
  reg [31:0] _RAND_2;
  reg [1:0] value; // @[Counter.scala 26:33:@11.4]
  reg [31:0] _RAND_3;
  wire  _T_24; // @[Grayscale.scala 38:28:@15.6]
  wire [15:0] _GEN_0; // @[Grayscale.scala 38:37:@16.6]
  wire  _T_26; // @[Grayscale.scala 41:28:@19.6]
  wire [15:0] _GEN_1; // @[Grayscale.scala 41:37:@20.6]
  wire  _T_28; // @[Grayscale.scala 44:28:@23.6]
  wire [15:0] _GEN_2; // @[Grayscale.scala 44:37:@24.6]
  wire [15:0] _GEN_3; // @[Grayscale.scala 37:26:@14.4]
  wire [15:0] _GEN_4; // @[Grayscale.scala 37:26:@14.4]
  wire [15:0] _GEN_5; // @[Grayscale.scala 37:26:@14.4]
  wire [2:0] _T_32; // @[Counter.scala 35:22:@29.4]
  wire [1:0] _T_33; // @[Counter.scala 35:22:@30.4]
  wire [1:0] _GEN_6; // @[Counter.scala 37:21:@32.4]
  wire [31:0] _T_35; // @[Grayscale.scala 50:26:@36.6]
  wire [31:0] _T_36; // @[Grayscale.scala 50:36:@37.6]
  wire [32:0] _T_37; // @[Grayscale.scala 50:31:@38.6]
  wire [31:0] _T_38; // @[Grayscale.scala 50:31:@39.6]
  wire [31:0] _T_39; // @[Grayscale.scala 50:31:@40.6]
  wire [31:0] _T_40; // @[Grayscale.scala 50:46:@41.6]
  wire [32:0] _T_41; // @[Grayscale.scala 50:41:@42.6]
  wire [31:0] _T_42; // @[Grayscale.scala 50:41:@43.6]
  wire [31:0] _T_43; // @[Grayscale.scala 50:41:@44.6]
  wire [31:0] _GEN_7; // @[Grayscale.scala 49:23:@35.4]
  wire [23:0] _GEN_9; // @[Grayscale.scala 35:14:@13.4 Grayscale.scala 50:20:@45.6]
  wire [15:0] _GEN_10; // @[Grayscale.scala 35:14:@13.4 Grayscale.scala 50:20:@45.6]
  assign _T_24 = value == 2'h0; // @[Grayscale.scala 38:28:@15.6]
  assign _GEN_0 = _T_24 ? $signed(io_dataIn) : $signed(b0); // @[Grayscale.scala 38:37:@16.6]
  assign _T_26 = value == 2'h1; // @[Grayscale.scala 41:28:@19.6]
  assign _GEN_1 = _T_26 ? $signed(io_dataIn) : $signed(b1); // @[Grayscale.scala 41:37:@20.6]
  assign _T_28 = value == 2'h2; // @[Grayscale.scala 44:28:@23.6]
  assign _GEN_2 = _T_28 ? $signed(io_dataIn) : $signed(b2); // @[Grayscale.scala 44:37:@24.6]
  assign _GEN_3 = io_loadingValues ? $signed(_GEN_0) : $signed(b0); // @[Grayscale.scala 37:26:@14.4]
  assign _GEN_4 = io_loadingValues ? $signed(_GEN_1) : $signed(b1); // @[Grayscale.scala 37:26:@14.4]
  assign _GEN_5 = io_loadingValues ? $signed(_GEN_2) : $signed(b2); // @[Grayscale.scala 37:26:@14.4]
  assign _T_32 = value + 2'h1; // @[Counter.scala 35:22:@29.4]
  assign _T_33 = _T_32[1:0]; // @[Counter.scala 35:22:@30.4]
  assign _GEN_6 = _T_28 ? 2'h0 : _T_33; // @[Counter.scala 37:21:@32.4]
  assign _T_35 = $signed(b0) * $signed(16'sh4d); // @[Grayscale.scala 50:26:@36.6]
  assign _T_36 = $signed(b1) * $signed(16'sh97); // @[Grayscale.scala 50:36:@37.6]
  assign _T_37 = $signed(_T_35) + $signed(_T_36); // @[Grayscale.scala 50:31:@38.6]
  assign _T_38 = _T_37[31:0]; // @[Grayscale.scala 50:31:@39.6]
  assign _T_39 = $signed(_T_38); // @[Grayscale.scala 50:31:@40.6]
  assign _T_40 = $signed(b2) * $signed(16'sh1c); // @[Grayscale.scala 50:46:@41.6]
  assign _T_41 = $signed(_T_39) + $signed(_T_40); // @[Grayscale.scala 50:41:@42.6]
  assign _T_42 = _T_41[31:0]; // @[Grayscale.scala 50:41:@43.6]
  assign _T_43 = $signed(_T_42); // @[Grayscale.scala 50:41:@44.6]
  assign _GEN_7 = _T_28 ? $signed(_T_43) : $signed(32'sh0); // @[Grayscale.scala 49:23:@35.4]
  assign _GEN_9 = _GEN_7[31:8]; // @[Grayscale.scala 35:14:@13.4 Grayscale.scala 50:20:@45.6]
  assign _GEN_10 = _GEN_9[15:0]; // @[Grayscale.scala 35:14:@13.4 Grayscale.scala 50:20:@45.6]
  assign io_dataOut = $signed(_GEN_10); // @[Grayscale.scala 35:14:@13.4 Grayscale.scala 50:20:@45.6]
  assign io_dataValid = value == 2'h2; // @[Grayscale.scala 34:16:@12.4 Grayscale.scala 51:22:@46.6]
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
  b0 = _RAND_0[15:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_1 = {1{`RANDOM}};
  b1 = _RAND_1[15:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_2 = {1{`RANDOM}};
  b2 = _RAND_2[15:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_3 = {1{`RANDOM}};
  value = _RAND_3[1:0];
  `endif // RANDOMIZE_REG_INIT
  end
`endif // RANDOMIZE
  always @(posedge clock) begin
    if (reset) begin
      b0 <= 16'sh0;
    end else begin
      if (io_loadingValues) begin
        if (_T_24) begin
          b0 <= io_dataIn;
        end
      end
    end
    if (reset) begin
      b1 <= 16'sh0;
    end else begin
      if (io_loadingValues) begin
        if (_T_26) begin
          b1 <= io_dataIn;
        end
      end
    end
    if (reset) begin
      b2 <= 16'sh0;
    end else begin
      if (io_loadingValues) begin
        if (_T_28) begin
          b2 <= io_dataIn;
        end
      end
    end
    if (reset) begin
      value <= 2'h0;
    end else begin
      if (_T_28) begin
        value <= 2'h0;
      end else begin
        value <= _T_33;
      end
    end
  end
endmodule
