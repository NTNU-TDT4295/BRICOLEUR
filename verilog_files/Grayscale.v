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
  reg [3:0] counter; // @[Grayscale.scala 35:24:@10.4]
  reg [31:0] _RAND_2;
  reg  isReady; // @[Grayscale.scala 40:24:@16.4]
  reg [31:0] _RAND_3;
  wire  _T_31; // @[Grayscale.scala 43:16:@17.4]
  wire [31:0] _T_32; // @[Grayscale.scala 44:22:@19.6]
  wire [4:0] _T_34; // @[Grayscale.scala 45:24:@21.6]
  wire [3:0] _T_35; // @[Grayscale.scala 45:24:@22.6]
  wire  _GEN_1; // @[Grayscale.scala 46:19:@24.6]
  wire [23:0] _GEN_12; // @[Grayscale.scala 43:25:@18.4]
  wire [23:0] _GEN_13; // @[Grayscale.scala 43:25:@18.4]
  wire [31:0] _GEN_2; // @[Grayscale.scala 43:25:@18.4]
  wire [3:0] _GEN_3; // @[Grayscale.scala 43:25:@18.4]
  wire  _GEN_5; // @[Grayscale.scala 43:25:@18.4]
  wire  _T_39; // @[Grayscale.scala 53:16:@31.4]
  wire [31:0] _T_40; // @[Grayscale.scala 54:28:@33.6]
  wire [31:0] _GEN_16; // @[Grayscale.scala 54:16:@34.6]
  wire [32:0] _T_41; // @[Grayscale.scala 54:16:@34.6]
  wire [31:0] _T_42; // @[Grayscale.scala 54:16:@35.6]
  wire [31:0] _T_43; // @[Grayscale.scala 54:16:@36.6]
  wire [31:0] _GEN_6; // @[Grayscale.scala 53:25:@32.4]
  wire [3:0] _GEN_7; // @[Grayscale.scala 53:25:@32.4]
  wire  _T_48; // @[Grayscale.scala 58:16:@42.4]
  wire [31:0] _T_49; // @[Grayscale.scala 59:28:@44.6]
  wire [32:0] _T_50; // @[Grayscale.scala 59:16:@45.6]
  wire [31:0] _T_51; // @[Grayscale.scala 59:16:@46.6]
  wire [31:0] _T_52; // @[Grayscale.scala 59:16:@47.6]
  wire [31:0] _GEN_8; // @[Grayscale.scala 58:25:@43.4]
  wire [3:0] _GEN_9; // @[Grayscale.scala 58:25:@43.4]
  wire  _GEN_10; // @[Grayscale.scala 63:19:@51.4]
  wire [23:0] _GEN_20; // @[Grayscale.scala 44:9:@20.6 Grayscale.scala 54:9:@37.6 Grayscale.scala 59:9:@48.6]
  wire [15:0] _GEN_21; // @[Grayscale.scala 44:9:@20.6 Grayscale.scala 54:9:@37.6 Grayscale.scala 59:9:@48.6]
  assign _T_31 = counter == 4'h0; // @[Grayscale.scala 43:16:@17.4]
  assign _T_32 = $signed(io_dataIn) * $signed(16'sh4d); // @[Grayscale.scala 44:22:@19.6]
  assign _T_34 = counter + 4'h1; // @[Grayscale.scala 45:24:@21.6]
  assign _T_35 = _T_34[3:0]; // @[Grayscale.scala 45:24:@22.6]
  assign _GEN_1 = started ? started : 1'h1; // @[Grayscale.scala 46:19:@24.6]
  assign _GEN_12 = {{8{out[15]}},out}; // @[Grayscale.scala 43:25:@18.4]
  assign _GEN_13 = $signed(_GEN_12) << 8; // @[Grayscale.scala 43:25:@18.4]
  assign _GEN_2 = _T_31 ? $signed(_T_32) : $signed({{8{_GEN_13[23]}},_GEN_13}); // @[Grayscale.scala 43:25:@18.4]
  assign _GEN_3 = _T_31 ? _T_35 : counter; // @[Grayscale.scala 43:25:@18.4]
  assign _GEN_5 = _T_31 ? _GEN_1 : started; // @[Grayscale.scala 43:25:@18.4]
  assign _T_39 = counter == 4'h1; // @[Grayscale.scala 53:16:@31.4]
  assign _T_40 = $signed(io_dataIn) * $signed(16'sh97); // @[Grayscale.scala 54:28:@33.6]
  assign _GEN_16 = {{8{_GEN_13[23]}},_GEN_13}; // @[Grayscale.scala 54:16:@34.6]
  assign _T_41 = $signed(_GEN_16) + $signed(_T_40); // @[Grayscale.scala 54:16:@34.6]
  assign _T_42 = _T_41[31:0]; // @[Grayscale.scala 54:16:@35.6]
  assign _T_43 = $signed(_T_42); // @[Grayscale.scala 54:16:@36.6]
  assign _GEN_6 = _T_39 ? $signed(_T_43) : $signed(_GEN_2); // @[Grayscale.scala 53:25:@32.4]
  assign _GEN_7 = _T_39 ? _T_35 : _GEN_3; // @[Grayscale.scala 53:25:@32.4]
  assign _T_48 = counter == 4'h2; // @[Grayscale.scala 58:16:@42.4]
  assign _T_49 = $signed(io_dataIn) * $signed(16'sh1c); // @[Grayscale.scala 59:28:@44.6]
  assign _T_50 = $signed(_GEN_16) + $signed(_T_49); // @[Grayscale.scala 59:16:@45.6]
  assign _T_51 = _T_50[31:0]; // @[Grayscale.scala 59:16:@46.6]
  assign _T_52 = $signed(_T_51); // @[Grayscale.scala 59:16:@47.6]
  assign _GEN_8 = _T_48 ? $signed(_T_52) : $signed(_GEN_6); // @[Grayscale.scala 58:25:@43.4]
  assign _GEN_9 = _T_48 ? 4'h0 : _GEN_7; // @[Grayscale.scala 58:25:@43.4]
  assign _GEN_10 = io_tready ? 1'h1 : isReady; // @[Grayscale.scala 63:19:@51.4]
  assign io_tvalid = _T_31 ? started : 1'h0; // @[Grayscale.scala 38:13:@14.4 Grayscale.scala 47:17:@25.8]
  assign io_tlast = 1'h0; // @[Grayscale.scala 36:12:@11.4]
  assign io_tdata = isReady ? $signed(out) : $signed(16'sh0); // @[Grayscale.scala 39:12:@15.4 Grayscale.scala 67:14:@56.6]
  assign io_tkeep = 4'hf; // @[Grayscale.scala 37:12:@13.4]
  assign _GEN_20 = _GEN_8[31:8]; // @[Grayscale.scala 44:9:@20.6 Grayscale.scala 54:9:@37.6 Grayscale.scala 59:9:@48.6]
  assign _GEN_21 = _GEN_20[15:0]; // @[Grayscale.scala 44:9:@20.6 Grayscale.scala 54:9:@37.6 Grayscale.scala 59:9:@48.6]
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
  counter = _RAND_2[3:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_3 = {1{`RANDOM}};
  isReady = _RAND_3[0:0];
  `endif // RANDOMIZE_REG_INIT
  end
`endif // RANDOMIZE
  always @(posedge clock) begin
    if (reset) begin
      out <= 16'sh0;
    end else begin
      out <= $signed(_GEN_21);
    end
    if (reset) begin
      started <= 1'h0;
    end else begin
      if (_T_31) begin
        if (!(started)) begin
          started <= 1'h1;
        end
      end
    end
    if (reset) begin
      counter <= 4'h0;
    end else begin
      if (_T_48) begin
        counter <= 4'h0;
      end else begin
        if (_T_39) begin
          counter <= _T_35;
        end else begin
          if (_T_31) begin
            counter <= _T_35;
          end
        end
      end
    end
    if (reset) begin
      isReady <= 1'h0;
    end else begin
      if (io_tready) begin
        isReady <= 1'h1;
      end
    end
  end
endmodule
