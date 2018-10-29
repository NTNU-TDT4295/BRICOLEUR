module Grayscale( // @[:@3.2]
  input         clock, // @[:@4.4]
  input         reset, // @[:@5.4]
  input  [15:0] io_dataIn, // @[:@6.4]
  input         io_tready, // @[:@6.4]
  output        io_tvalid, // @[:@6.4]
  output        io_tlast, // @[:@6.4]
  output [15:0] io_tdata, // @[:@6.4]
  output [3:0]  io_tkeep // @[:@6.4]
);
  reg [15:0] out; // @[Grayscale.scala 31:20:@8.4]
  reg [31:0] _RAND_0;
  reg  started; // @[Grayscale.scala 33:24:@9.4]
  reg [31:0] _RAND_1;
  reg [1:0] value; // @[Counter.scala 26:33:@10.4]
  reg [31:0] _RAND_2;
  wire  _T_28; // @[Grayscale.scala 41:22:@16.4]
  wire [31:0] _T_29; // @[Grayscale.scala 42:22:@18.6]
  wire  _GEN_1; // @[Grayscale.scala 44:19:@20.6]
  wire [23:0] _GEN_9; // @[Grayscale.scala 41:31:@17.4]
  wire [23:0] _GEN_10; // @[Grayscale.scala 41:31:@17.4]
  wire [31:0] _GEN_2; // @[Grayscale.scala 41:31:@17.4]
  wire  _GEN_4; // @[Grayscale.scala 41:31:@17.4]
  wire  _T_33; // @[Grayscale.scala 51:22:@27.4]
  wire [31:0] _T_34; // @[Grayscale.scala 52:28:@29.6]
  wire [31:0] _GEN_13; // @[Grayscale.scala 52:16:@30.6]
  wire [32:0] _T_35; // @[Grayscale.scala 52:16:@30.6]
  wire [31:0] _T_36; // @[Grayscale.scala 52:16:@31.6]
  wire [31:0] _T_37; // @[Grayscale.scala 52:16:@32.6]
  wire [31:0] _GEN_5; // @[Grayscale.scala 51:31:@28.4]
  wire  _T_39; // @[Grayscale.scala 55:22:@35.4]
  wire [31:0] _T_40; // @[Grayscale.scala 56:28:@37.6]
  wire [32:0] _T_41; // @[Grayscale.scala 56:16:@38.6]
  wire [31:0] _T_42; // @[Grayscale.scala 56:16:@39.6]
  wire [31:0] _T_43; // @[Grayscale.scala 56:16:@40.6]
  wire [31:0] _GEN_6; // @[Grayscale.scala 55:31:@36.4]
  wire [2:0] _T_47; // @[Counter.scala 35:22:@47.4]
  wire [1:0] _T_48; // @[Counter.scala 35:22:@48.4]
  wire [1:0] _GEN_8; // @[Counter.scala 37:21:@50.4]
  wire [23:0] _GEN_17; // @[Grayscale.scala 42:9:@19.6 Grayscale.scala 52:9:@33.6 Grayscale.scala 56:9:@41.6]
  wire [15:0] _GEN_18; // @[Grayscale.scala 42:9:@19.6 Grayscale.scala 52:9:@33.6 Grayscale.scala 56:9:@41.6]
  assign _T_28 = value == 2'h0; // @[Grayscale.scala 41:22:@16.4]
  assign _T_29 = $signed(io_dataIn) * $signed(16'sh4d); // @[Grayscale.scala 42:22:@18.6]
  assign _GEN_1 = started ? started : 1'h1; // @[Grayscale.scala 44:19:@20.6]
  assign _GEN_9 = {{8{out[15]}},out}; // @[Grayscale.scala 41:31:@17.4]
  assign _GEN_10 = $signed(_GEN_9) << 8; // @[Grayscale.scala 41:31:@17.4]
  assign _GEN_2 = _T_28 ? $signed(_T_29) : $signed({{8{_GEN_10[23]}},_GEN_10}); // @[Grayscale.scala 41:31:@17.4]
  assign _GEN_4 = _T_28 ? _GEN_1 : started; // @[Grayscale.scala 41:31:@17.4]
  assign _T_33 = value == 2'h1; // @[Grayscale.scala 51:22:@27.4]
  assign _T_34 = $signed(io_dataIn) * $signed(16'sh97); // @[Grayscale.scala 52:28:@29.6]
  assign _GEN_13 = {{8{_GEN_10[23]}},_GEN_10}; // @[Grayscale.scala 52:16:@30.6]
  assign _T_35 = $signed(_GEN_13) + $signed(_T_34); // @[Grayscale.scala 52:16:@30.6]
  assign _T_36 = _T_35[31:0]; // @[Grayscale.scala 52:16:@31.6]
  assign _T_37 = $signed(_T_36); // @[Grayscale.scala 52:16:@32.6]
  assign _GEN_5 = _T_33 ? $signed(_T_37) : $signed(_GEN_2); // @[Grayscale.scala 51:31:@28.4]
  assign _T_39 = value == 2'h2; // @[Grayscale.scala 55:22:@35.4]
  assign _T_40 = $signed(io_dataIn) * $signed(16'sh1c); // @[Grayscale.scala 56:28:@37.6]
  assign _T_41 = $signed(_GEN_13) + $signed(_T_40); // @[Grayscale.scala 56:16:@38.6]
  assign _T_42 = _T_41[31:0]; // @[Grayscale.scala 56:16:@39.6]
  assign _T_43 = $signed(_T_42); // @[Grayscale.scala 56:16:@40.6]
  assign _GEN_6 = _T_39 ? $signed(_T_43) : $signed(_GEN_5); // @[Grayscale.scala 55:31:@36.4]
  assign _T_47 = value + 2'h1; // @[Counter.scala 35:22:@47.4]
  assign _T_48 = _T_47[1:0]; // @[Counter.scala 35:22:@48.4]
  assign _GEN_8 = _T_39 ? 2'h0 : _T_48; // @[Counter.scala 37:21:@50.4]
  assign io_tvalid = _T_28 ? started : 1'h0; // @[Grayscale.scala 38:13:@14.4 Grayscale.scala 45:17:@21.8]
  assign io_tlast = 1'h0; // @[Grayscale.scala 36:12:@11.4]
  assign io_tdata = out; // @[Grayscale.scala 39:12:@15.4 Grayscale.scala 60:14:@44.6]
  assign io_tkeep = 4'hf; // @[Grayscale.scala 37:12:@13.4]
  assign _GEN_17 = _GEN_6[31:8]; // @[Grayscale.scala 42:9:@19.6 Grayscale.scala 52:9:@33.6 Grayscale.scala 56:9:@41.6]
  assign _GEN_18 = _GEN_17[15:0]; // @[Grayscale.scala 42:9:@19.6 Grayscale.scala 52:9:@33.6 Grayscale.scala 56:9:@41.6]
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
      out <= $signed(_GEN_18);
    end
    if (reset) begin
      started <= 1'h0;
    end else begin
      if (_T_28) begin
        if (!(started)) begin
          started <= 1'h1;
        end
      end
    end
    if (reset) begin
      value <= 2'h0;
    end else begin
      if (_T_39) begin
        value <= 2'h0;
      end else begin
        value <= _T_48;
      end
    end
  end
endmodule
