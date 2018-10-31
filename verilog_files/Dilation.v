module FIFO( // @[:@3.2]
  input         clock, // @[:@4.4]
  input         reset, // @[:@5.4]
  input  [15:0] io_dataIn, // @[:@6.4]
  output [15:0] io_dataOut // @[:@6.4]
);
  reg [15:0] _T_11; // @[FIFO.scala 14:16:@8.4]
  reg [31:0] _RAND_0;
  assign io_dataOut = _T_11; // @[FIFO.scala 22:14:@9.4]
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
  _T_11 = _RAND_0[15:0];
  `endif // RANDOMIZE_REG_INIT
  end
`endif // RANDOMIZE
  always @(posedge clock) begin
    if (reset) begin
      _T_11 <= 16'sh0;
    end else begin
      _T_11 <= io_dataIn;
    end
  end
endmodule
module FIFO_2( // @[:@21.2]
  input         clock, // @[:@22.4]
  input         reset, // @[:@23.4]
  input  [15:0] io_dataIn, // @[:@24.4]
  output [15:0] io_dataOut // @[:@24.4]
);
  reg [15:0] _T_11; // @[FIFO.scala 14:16:@26.4]
  reg [31:0] _RAND_0;
  reg [15:0] _T_14; // @[FIFO.scala 14:16:@27.4]
  reg [31:0] _RAND_1;
  reg [15:0] _T_17; // @[FIFO.scala 14:16:@28.4]
  reg [31:0] _RAND_2;
  reg [15:0] _T_20; // @[FIFO.scala 14:16:@29.4]
  reg [31:0] _RAND_3;
  reg [15:0] _T_23; // @[FIFO.scala 14:16:@30.4]
  reg [31:0] _RAND_4;
  reg [15:0] _T_26; // @[FIFO.scala 14:16:@31.4]
  reg [31:0] _RAND_5;
  reg [15:0] _T_29; // @[FIFO.scala 14:16:@32.4]
  reg [31:0] _RAND_6;
  assign io_dataOut = _T_29; // @[FIFO.scala 22:14:@39.4]
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
  _T_11 = _RAND_0[15:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_1 = {1{`RANDOM}};
  _T_14 = _RAND_1[15:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_2 = {1{`RANDOM}};
  _T_17 = _RAND_2[15:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_3 = {1{`RANDOM}};
  _T_20 = _RAND_3[15:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_4 = {1{`RANDOM}};
  _T_23 = _RAND_4[15:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_5 = {1{`RANDOM}};
  _T_26 = _RAND_5[15:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_6 = {1{`RANDOM}};
  _T_29 = _RAND_6[15:0];
  `endif // RANDOMIZE_REG_INIT
  end
`endif // RANDOMIZE
  always @(posedge clock) begin
    if (reset) begin
      _T_11 <= 16'sh0;
    end else begin
      _T_11 <= io_dataIn;
    end
    if (reset) begin
      _T_14 <= 16'sh0;
    end else begin
      _T_14 <= _T_11;
    end
    if (reset) begin
      _T_17 <= 16'sh0;
    end else begin
      _T_17 <= _T_14;
    end
    if (reset) begin
      _T_20 <= 16'sh0;
    end else begin
      _T_20 <= _T_17;
    end
    if (reset) begin
      _T_23 <= 16'sh0;
    end else begin
      _T_23 <= _T_20;
    end
    if (reset) begin
      _T_26 <= 16'sh0;
    end else begin
      _T_26 <= _T_23;
    end
    if (reset) begin
      _T_29 <= 16'sh0;
    end else begin
      _T_29 <= _T_26;
    end
  end
endmodule
module Dilation( // @[:@99.2]
  input         clock, // @[:@100.4]
  input         reset, // @[:@101.4]
  input  [15:0] io_dataIn, // @[:@102.4]
  output [15:0] io_dataOut, // @[:@102.4]
  input         io_clock, // @[:@102.4]
  output        io_valid // @[:@102.4]
);
  wire  fifo1_0_clock; // @[Dilation.scala 78:23:@161.4]
  wire  fifo1_0_reset; // @[Dilation.scala 78:23:@161.4]
  wire [15:0] fifo1_0_io_dataIn; // @[Dilation.scala 78:23:@161.4]
  wire [15:0] fifo1_0_io_dataOut; // @[Dilation.scala 78:23:@161.4]
  wire  fifo2_1_clock; // @[Dilation.scala 79:23:@164.4]
  wire  fifo2_1_reset; // @[Dilation.scala 79:23:@164.4]
  wire [15:0] fifo2_1_io_dataIn; // @[Dilation.scala 79:23:@164.4]
  wire [15:0] fifo2_1_io_dataOut; // @[Dilation.scala 79:23:@164.4]
  wire  fifo3_2_clock; // @[Dilation.scala 80:23:@167.4]
  wire  fifo3_2_reset; // @[Dilation.scala 80:23:@167.4]
  wire [15:0] fifo3_2_io_dataIn; // @[Dilation.scala 80:23:@167.4]
  wire [15:0] fifo3_2_io_dataOut; // @[Dilation.scala 80:23:@167.4]
  wire  fifo4_3_clock; // @[Dilation.scala 81:23:@170.4]
  wire  fifo4_3_reset; // @[Dilation.scala 81:23:@170.4]
  wire [15:0] fifo4_3_io_dataIn; // @[Dilation.scala 81:23:@170.4]
  wire [15:0] fifo4_3_io_dataOut; // @[Dilation.scala 81:23:@170.4]
  wire  fifo5_4_clock; // @[Dilation.scala 82:23:@173.4]
  wire  fifo5_4_reset; // @[Dilation.scala 82:23:@173.4]
  wire [15:0] fifo5_4_io_dataIn; // @[Dilation.scala 82:23:@173.4]
  wire [15:0] fifo5_4_io_dataOut; // @[Dilation.scala 82:23:@173.4]
  wire  fifo6_5_clock; // @[Dilation.scala 83:23:@176.4]
  wire  fifo6_5_reset; // @[Dilation.scala 83:23:@176.4]
  wire [15:0] fifo6_5_io_dataIn; // @[Dilation.scala 83:23:@176.4]
  wire [15:0] fifo6_5_io_dataOut; // @[Dilation.scala 83:23:@176.4]
  wire  fifo7_6_clock; // @[Dilation.scala 84:23:@179.4]
  wire  fifo7_6_reset; // @[Dilation.scala 84:23:@179.4]
  wire [15:0] fifo7_6_io_dataIn; // @[Dilation.scala 84:23:@179.4]
  wire [15:0] fifo7_6_io_dataOut; // @[Dilation.scala 84:23:@179.4]
  wire  fifo8_7_clock; // @[Dilation.scala 85:23:@182.4]
  wire  fifo8_7_reset; // @[Dilation.scala 85:23:@182.4]
  wire [15:0] fifo8_7_io_dataIn; // @[Dilation.scala 85:23:@182.4]
  wire [15:0] fifo8_7_io_dataOut; // @[Dilation.scala 85:23:@182.4]
  reg [4:0] value; // @[Counter.scala 26:33:@104.4]
  reg [31:0] _RAND_0;
  reg  value_1; // @[Counter.scala 26:33:@105.4]
  reg [31:0] _RAND_1;
  reg [5:0] value_2; // @[Counter.scala 26:33:@106.4]
  reg [31:0] _RAND_2;
  reg [2:0] value_3; // @[Counter.scala 26:33:@107.4]
  reg [31:0] _RAND_3;
  reg  computationStarted; // @[Dilation.scala 36:35:@108.4]
  reg [31:0] _RAND_4;
  reg  processWrapped; // @[Dilation.scala 37:31:@109.4]
  reg [31:0] _RAND_5;
  reg  computationEnded; // @[Dilation.scala 38:33:@110.4]
  reg [31:0] _RAND_6;
  wire  _T_28; // @[Counter.scala 34:24:@111.4]
  wire [5:0] _T_30; // @[Counter.scala 35:22:@112.4]
  wire [4:0] _T_31; // @[Counter.scala 35:22:@113.4]
  wire [4:0] _GEN_0; // @[Counter.scala 37:21:@115.4]
  wire  _GEN_1; // @[Dilation.scala 40:27:@118.4]
  wire  _T_37; // @[Dilation.scala 46:30:@123.6]
  wire  _T_39; // @[Counter.scala 34:24:@125.8]
  wire [3:0] _T_41; // @[Counter.scala 35:22:@126.8]
  wire [2:0] _T_42; // @[Counter.scala 35:22:@127.8]
  wire  _GEN_2; // @[Dilation.scala 47:37:@129.8]
  wire [1:0] _T_47; // @[Counter.scala 35:22:@135.8]
  wire  _T_48; // @[Counter.scala 35:22:@136.8]
  wire  _GEN_3; // @[Dilation.scala 51:34:@138.8]
  wire [2:0] _GEN_4; // @[Dilation.scala 46:38:@124.6]
  wire  _GEN_5; // @[Dilation.scala 46:38:@124.6]
  wire  _GEN_6; // @[Dilation.scala 46:38:@124.6]
  wire [2:0] _GEN_7; // @[Dilation.scala 44:35:@122.4]
  wire  _GEN_8; // @[Dilation.scala 44:35:@122.4]
  wire  _GEN_9; // @[Dilation.scala 44:35:@122.4]
  wire  _T_54; // @[Dilation.scala 56:31:@145.4]
  wire  _T_56; // @[Dilation.scala 56:81:@146.4]
  wire  _T_57; // @[Dilation.scala 56:61:@147.4]
  wire  _T_59; // @[Counter.scala 34:24:@149.6]
  wire [6:0] _T_61; // @[Counter.scala 35:22:@150.6]
  wire [5:0] _T_62; // @[Counter.scala 35:22:@151.6]
  wire  _GEN_10; // @[Dilation.scala 57:32:@153.6]
  wire [5:0] _GEN_11; // @[Dilation.scala 56:89:@148.4]
  wire  _GEN_12; // @[Dilation.scala 56:89:@148.4]
  reg [15:0] kernel_0; // @[Dilation.scala 100:25:@193.4]
  reg [31:0] _RAND_7;
  reg [15:0] kernel_1; // @[Dilation.scala 101:25:@194.4]
  reg [31:0] _RAND_8;
  reg [15:0] kernel_2; // @[Dilation.scala 102:25:@195.4]
  reg [31:0] _RAND_9;
  reg [15:0] kernel_3; // @[Dilation.scala 103:25:@196.4]
  reg [31:0] _RAND_10;
  reg [15:0] kernel_4; // @[Dilation.scala 104:25:@197.4]
  reg [31:0] _RAND_11;
  reg [15:0] kernel_5; // @[Dilation.scala 105:25:@198.4]
  reg [31:0] _RAND_12;
  reg [15:0] kernel_6; // @[Dilation.scala 106:25:@199.4]
  reg [31:0] _RAND_13;
  reg [15:0] kernel_7; // @[Dilation.scala 107:25:@200.4]
  reg [31:0] _RAND_14;
  reg [15:0] kernel_8; // @[Dilation.scala 108:25:@201.4]
  reg [31:0] _RAND_15;
  wire [31:0] _T_84; // @[Dilation.scala 127:25:@202.4]
  wire [31:0] _T_85; // @[Dilation.scala 128:33:@204.4]
  wire [31:0] _T_86; // @[Dilation.scala 129:33:@206.4]
  wire [31:0] _T_87; // @[Dilation.scala 130:33:@208.4]
  wire [31:0] _T_88; // @[Dilation.scala 131:33:@210.4]
  wire [31:0] _T_89; // @[Dilation.scala 132:33:@212.4]
  wire [31:0] _T_90; // @[Dilation.scala 133:33:@214.4]
  wire [31:0] _T_91; // @[Dilation.scala 134:33:@216.4]
  wire [31:0] _T_92; // @[Dilation.scala 135:33:@218.4]
  wire [16:0] _T_93; // @[Dilation.scala 139:20:@220.4]
  wire [15:0] _T_94; // @[Dilation.scala 139:20:@221.4]
  wire [15:0] _T_95; // @[Dilation.scala 139:20:@222.4]
  wire [16:0] _T_96; // @[Dilation.scala 140:28:@223.4]
  wire [15:0] _T_97; // @[Dilation.scala 140:28:@224.4]
  wire [15:0] _T_98; // @[Dilation.scala 140:28:@225.4]
  wire [16:0] _T_99; // @[Dilation.scala 141:28:@226.4]
  wire [15:0] _T_100; // @[Dilation.scala 141:28:@227.4]
  wire [15:0] _T_101; // @[Dilation.scala 141:28:@228.4]
  wire [16:0] _T_102; // @[Dilation.scala 142:28:@229.4]
  wire [15:0] _T_103; // @[Dilation.scala 142:28:@230.4]
  wire [15:0] _T_104; // @[Dilation.scala 142:28:@231.4]
  wire [16:0] _T_105; // @[Dilation.scala 143:28:@232.4]
  wire [15:0] _T_106; // @[Dilation.scala 143:28:@233.4]
  wire [15:0] _T_107; // @[Dilation.scala 143:28:@234.4]
  wire [16:0] _T_108; // @[Dilation.scala 144:28:@235.4]
  wire [15:0] _T_109; // @[Dilation.scala 144:28:@236.4]
  wire [15:0] _T_110; // @[Dilation.scala 144:28:@237.4]
  wire [16:0] _T_111; // @[Dilation.scala 145:28:@238.4]
  wire [15:0] _T_112; // @[Dilation.scala 145:28:@239.4]
  wire [15:0] _T_113; // @[Dilation.scala 145:28:@240.4]
  wire [16:0] _T_114; // @[Dilation.scala 146:28:@241.4]
  wire [15:0] _T_115; // @[Dilation.scala 146:28:@242.4]
  wire [15:0] _T_116; // @[Dilation.scala 146:28:@243.4]
  wire [23:0] _GEN_14; // @[Dilation.scala 135:12:@219.4]
  wire [15:0] _GEN_15; // @[Dilation.scala 135:12:@219.4]
  wire [23:0] _GEN_16; // @[Dilation.scala 134:12:@217.4]
  wire [15:0] _GEN_17; // @[Dilation.scala 134:12:@217.4]
  wire [23:0] _GEN_18; // @[Dilation.scala 133:12:@215.4]
  wire [15:0] _GEN_19; // @[Dilation.scala 133:12:@215.4]
  wire [23:0] _GEN_20; // @[Dilation.scala 132:12:@213.4]
  wire [15:0] _GEN_21; // @[Dilation.scala 132:12:@213.4]
  wire [23:0] _GEN_22; // @[Dilation.scala 131:12:@211.4]
  wire [15:0] _GEN_23; // @[Dilation.scala 131:12:@211.4]
  wire [23:0] _GEN_24; // @[Dilation.scala 130:12:@209.4]
  wire [15:0] _GEN_25; // @[Dilation.scala 130:12:@209.4]
  wire [23:0] _GEN_26; // @[Dilation.scala 129:12:@207.4]
  wire [15:0] _GEN_27; // @[Dilation.scala 129:12:@207.4]
  wire [23:0] _GEN_28; // @[Dilation.scala 128:12:@205.4]
  wire [15:0] _GEN_29; // @[Dilation.scala 128:12:@205.4]
  wire [23:0] _GEN_30; // @[Dilation.scala 127:12:@203.4]
  wire [15:0] _GEN_31; // @[Dilation.scala 127:12:@203.4]
  FIFO fifo1_0 ( // @[Dilation.scala 78:23:@161.4]
    .clock(fifo1_0_clock),
    .reset(fifo1_0_reset),
    .io_dataIn(fifo1_0_io_dataIn),
    .io_dataOut(fifo1_0_io_dataOut)
  );
  FIFO fifo2_1 ( // @[Dilation.scala 79:23:@164.4]
    .clock(fifo2_1_clock),
    .reset(fifo2_1_reset),
    .io_dataIn(fifo2_1_io_dataIn),
    .io_dataOut(fifo2_1_io_dataOut)
  );
  FIFO_2 fifo3_2 ( // @[Dilation.scala 80:23:@167.4]
    .clock(fifo3_2_clock),
    .reset(fifo3_2_reset),
    .io_dataIn(fifo3_2_io_dataIn),
    .io_dataOut(fifo3_2_io_dataOut)
  );
  FIFO fifo4_3 ( // @[Dilation.scala 81:23:@170.4]
    .clock(fifo4_3_clock),
    .reset(fifo4_3_reset),
    .io_dataIn(fifo4_3_io_dataIn),
    .io_dataOut(fifo4_3_io_dataOut)
  );
  FIFO fifo5_4 ( // @[Dilation.scala 82:23:@173.4]
    .clock(fifo5_4_clock),
    .reset(fifo5_4_reset),
    .io_dataIn(fifo5_4_io_dataIn),
    .io_dataOut(fifo5_4_io_dataOut)
  );
  FIFO_2 fifo6_5 ( // @[Dilation.scala 83:23:@176.4]
    .clock(fifo6_5_clock),
    .reset(fifo6_5_reset),
    .io_dataIn(fifo6_5_io_dataIn),
    .io_dataOut(fifo6_5_io_dataOut)
  );
  FIFO fifo7_6 ( // @[Dilation.scala 84:23:@179.4]
    .clock(fifo7_6_clock),
    .reset(fifo7_6_reset),
    .io_dataIn(fifo7_6_io_dataIn),
    .io_dataOut(fifo7_6_io_dataOut)
  );
  FIFO fifo8_7 ( // @[Dilation.scala 85:23:@182.4]
    .clock(fifo8_7_clock),
    .reset(fifo8_7_reset),
    .io_dataIn(fifo8_7_io_dataIn),
    .io_dataOut(fifo8_7_io_dataOut)
  );
  assign _T_28 = value == 5'h15; // @[Counter.scala 34:24:@111.4]
  assign _T_30 = value + 5'h1; // @[Counter.scala 35:22:@112.4]
  assign _T_31 = _T_30[4:0]; // @[Counter.scala 35:22:@113.4]
  assign _GEN_0 = _T_28 ? 5'h0 : _T_31; // @[Counter.scala 37:21:@115.4]
  assign _GEN_1 = _T_28 ? 1'h1 : computationStarted; // @[Dilation.scala 40:27:@118.4]
  assign _T_37 = processWrapped == 1'h0; // @[Dilation.scala 46:30:@123.6]
  assign _T_39 = value_3 == 3'h7; // @[Counter.scala 34:24:@125.8]
  assign _T_41 = value_3 + 3'h1; // @[Counter.scala 35:22:@126.8]
  assign _T_42 = _T_41[2:0]; // @[Counter.scala 35:22:@127.8]
  assign _GEN_2 = _T_39 ? 1'h1 : processWrapped; // @[Dilation.scala 47:37:@129.8]
  assign _T_47 = value_1 + 1'h1; // @[Counter.scala 35:22:@135.8]
  assign _T_48 = _T_47[0:0]; // @[Counter.scala 35:22:@136.8]
  assign _GEN_3 = value_1 ? 1'h0 : processWrapped; // @[Dilation.scala 51:34:@138.8]
  assign _GEN_4 = _T_37 ? _T_42 : value_3; // @[Dilation.scala 46:38:@124.6]
  assign _GEN_5 = _T_37 ? _GEN_2 : _GEN_3; // @[Dilation.scala 46:38:@124.6]
  assign _GEN_6 = _T_37 ? value_1 : _T_48; // @[Dilation.scala 46:38:@124.6]
  assign _GEN_7 = computationStarted ? _GEN_4 : value_3; // @[Dilation.scala 44:35:@122.4]
  assign _GEN_8 = computationStarted ? _GEN_5 : processWrapped; // @[Dilation.scala 44:35:@122.4]
  assign _GEN_9 = computationStarted ? _GEN_6 : value_1; // @[Dilation.scala 44:35:@122.4]
  assign _T_54 = _T_37 & computationStarted; // @[Dilation.scala 56:31:@145.4]
  assign _T_56 = computationEnded == 1'h0; // @[Dilation.scala 56:81:@146.4]
  assign _T_57 = _T_54 & _T_56; // @[Dilation.scala 56:61:@147.4]
  assign _T_59 = value_2 == 6'h3f; // @[Counter.scala 34:24:@149.6]
  assign _T_61 = value_2 + 6'h1; // @[Counter.scala 35:22:@150.6]
  assign _T_62 = _T_61[5:0]; // @[Counter.scala 35:22:@151.6]
  assign _GEN_10 = _T_59 ? 1'h1 : computationEnded; // @[Dilation.scala 57:32:@153.6]
  assign _GEN_11 = _T_57 ? _T_62 : value_2; // @[Dilation.scala 56:89:@148.4]
  assign _GEN_12 = _T_57 ? _GEN_10 : computationEnded; // @[Dilation.scala 56:89:@148.4]
  assign _T_84 = $signed(io_dataIn) * $signed(16'sh0); // @[Dilation.scala 127:25:@202.4]
  assign _T_85 = $signed(fifo8_7_io_dataOut) * $signed(16'sh100); // @[Dilation.scala 128:33:@204.4]
  assign _T_86 = $signed(fifo7_6_io_dataOut) * $signed(16'sh0); // @[Dilation.scala 129:33:@206.4]
  assign _T_87 = $signed(fifo6_5_io_dataOut) * $signed(16'sh100); // @[Dilation.scala 130:33:@208.4]
  assign _T_88 = $signed(fifo5_4_io_dataOut) * $signed(16'sh100); // @[Dilation.scala 131:33:@210.4]
  assign _T_89 = $signed(fifo4_3_io_dataOut) * $signed(16'sh100); // @[Dilation.scala 132:33:@212.4]
  assign _T_90 = $signed(fifo3_2_io_dataOut) * $signed(16'sh0); // @[Dilation.scala 133:33:@214.4]
  assign _T_91 = $signed(fifo2_1_io_dataOut) * $signed(16'sh100); // @[Dilation.scala 134:33:@216.4]
  assign _T_92 = $signed(fifo1_0_io_dataOut) * $signed(16'sh0); // @[Dilation.scala 135:33:@218.4]
  assign _T_93 = $signed(kernel_0) + $signed(kernel_1); // @[Dilation.scala 139:20:@220.4]
  assign _T_94 = _T_93[15:0]; // @[Dilation.scala 139:20:@221.4]
  assign _T_95 = $signed(_T_94); // @[Dilation.scala 139:20:@222.4]
  assign _T_96 = $signed(_T_95) + $signed(kernel_2); // @[Dilation.scala 140:28:@223.4]
  assign _T_97 = _T_96[15:0]; // @[Dilation.scala 140:28:@224.4]
  assign _T_98 = $signed(_T_97); // @[Dilation.scala 140:28:@225.4]
  assign _T_99 = $signed(_T_98) + $signed(kernel_3); // @[Dilation.scala 141:28:@226.4]
  assign _T_100 = _T_99[15:0]; // @[Dilation.scala 141:28:@227.4]
  assign _T_101 = $signed(_T_100); // @[Dilation.scala 141:28:@228.4]
  assign _T_102 = $signed(_T_101) + $signed(kernel_4); // @[Dilation.scala 142:28:@229.4]
  assign _T_103 = _T_102[15:0]; // @[Dilation.scala 142:28:@230.4]
  assign _T_104 = $signed(_T_103); // @[Dilation.scala 142:28:@231.4]
  assign _T_105 = $signed(_T_104) + $signed(kernel_5); // @[Dilation.scala 143:28:@232.4]
  assign _T_106 = _T_105[15:0]; // @[Dilation.scala 143:28:@233.4]
  assign _T_107 = $signed(_T_106); // @[Dilation.scala 143:28:@234.4]
  assign _T_108 = $signed(_T_107) + $signed(kernel_6); // @[Dilation.scala 144:28:@235.4]
  assign _T_109 = _T_108[15:0]; // @[Dilation.scala 144:28:@236.4]
  assign _T_110 = $signed(_T_109); // @[Dilation.scala 144:28:@237.4]
  assign _T_111 = $signed(_T_110) + $signed(kernel_7); // @[Dilation.scala 145:28:@238.4]
  assign _T_112 = _T_111[15:0]; // @[Dilation.scala 145:28:@239.4]
  assign _T_113 = $signed(_T_112); // @[Dilation.scala 145:28:@240.4]
  assign _T_114 = $signed(_T_113) + $signed(kernel_8); // @[Dilation.scala 146:28:@241.4]
  assign _T_115 = _T_114[15:0]; // @[Dilation.scala 146:28:@242.4]
  assign _T_116 = $signed(_T_115); // @[Dilation.scala 146:28:@243.4]
  assign io_dataOut = $unsigned(_T_116); // @[Dilation.scala 138:14:@245.4]
  assign io_valid = _T_54 & _T_56; // @[Dilation.scala 60:18:@156.6 Dilation.scala 62:18:@159.6]
  assign fifo1_0_clock = clock; // @[:@162.4]
  assign fifo1_0_reset = reset; // @[:@163.4]
  assign fifo1_0_io_dataIn = fifo2_1_io_dataOut; // @[Dilation.scala 96:21:@192.4]
  assign fifo2_1_clock = clock; // @[:@165.4]
  assign fifo2_1_reset = reset; // @[:@166.4]
  assign fifo2_1_io_dataIn = fifo3_2_io_dataOut; // @[Dilation.scala 95:21:@191.4]
  assign fifo3_2_clock = clock; // @[:@168.4]
  assign fifo3_2_reset = reset; // @[:@169.4]
  assign fifo3_2_io_dataIn = fifo4_3_io_dataOut; // @[Dilation.scala 94:21:@190.4]
  assign fifo4_3_clock = clock; // @[:@171.4]
  assign fifo4_3_reset = reset; // @[:@172.4]
  assign fifo4_3_io_dataIn = fifo5_4_io_dataOut; // @[Dilation.scala 93:21:@189.4]
  assign fifo5_4_clock = clock; // @[:@174.4]
  assign fifo5_4_reset = reset; // @[:@175.4]
  assign fifo5_4_io_dataIn = fifo6_5_io_dataOut; // @[Dilation.scala 92:21:@188.4]
  assign fifo6_5_clock = clock; // @[:@177.4]
  assign fifo6_5_reset = reset; // @[:@178.4]
  assign fifo6_5_io_dataIn = fifo7_6_io_dataOut; // @[Dilation.scala 91:21:@187.4]
  assign fifo7_6_clock = clock; // @[:@180.4]
  assign fifo7_6_reset = reset; // @[:@181.4]
  assign fifo7_6_io_dataIn = fifo8_7_io_dataOut; // @[Dilation.scala 90:21:@186.4]
  assign fifo8_7_clock = clock; // @[:@183.4]
  assign fifo8_7_reset = reset; // @[:@184.4]
  assign fifo8_7_io_dataIn = io_dataIn; // @[Dilation.scala 89:21:@185.4]
  assign _GEN_14 = _T_92[31:8]; // @[Dilation.scala 135:12:@219.4]
  assign _GEN_15 = _GEN_14[15:0]; // @[Dilation.scala 135:12:@219.4]
  assign _GEN_16 = _T_91[31:8]; // @[Dilation.scala 134:12:@217.4]
  assign _GEN_17 = _GEN_16[15:0]; // @[Dilation.scala 134:12:@217.4]
  assign _GEN_18 = _T_90[31:8]; // @[Dilation.scala 133:12:@215.4]
  assign _GEN_19 = _GEN_18[15:0]; // @[Dilation.scala 133:12:@215.4]
  assign _GEN_20 = _T_89[31:8]; // @[Dilation.scala 132:12:@213.4]
  assign _GEN_21 = _GEN_20[15:0]; // @[Dilation.scala 132:12:@213.4]
  assign _GEN_22 = _T_88[31:8]; // @[Dilation.scala 131:12:@211.4]
  assign _GEN_23 = _GEN_22[15:0]; // @[Dilation.scala 131:12:@211.4]
  assign _GEN_24 = _T_87[31:8]; // @[Dilation.scala 130:12:@209.4]
  assign _GEN_25 = _GEN_24[15:0]; // @[Dilation.scala 130:12:@209.4]
  assign _GEN_26 = _T_86[31:8]; // @[Dilation.scala 129:12:@207.4]
  assign _GEN_27 = _GEN_26[15:0]; // @[Dilation.scala 129:12:@207.4]
  assign _GEN_28 = _T_85[31:8]; // @[Dilation.scala 128:12:@205.4]
  assign _GEN_29 = _GEN_28[15:0]; // @[Dilation.scala 128:12:@205.4]
  assign _GEN_30 = _T_84[31:8]; // @[Dilation.scala 127:12:@203.4]
  assign _GEN_31 = _GEN_30[15:0]; // @[Dilation.scala 127:12:@203.4]
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
  value = _RAND_0[4:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_1 = {1{`RANDOM}};
  value_1 = _RAND_1[0:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_2 = {1{`RANDOM}};
  value_2 = _RAND_2[5:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_3 = {1{`RANDOM}};
  value_3 = _RAND_3[2:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_4 = {1{`RANDOM}};
  computationStarted = _RAND_4[0:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_5 = {1{`RANDOM}};
  processWrapped = _RAND_5[0:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_6 = {1{`RANDOM}};
  computationEnded = _RAND_6[0:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_7 = {1{`RANDOM}};
  kernel_0 = _RAND_7[15:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_8 = {1{`RANDOM}};
  kernel_1 = _RAND_8[15:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_9 = {1{`RANDOM}};
  kernel_2 = _RAND_9[15:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_10 = {1{`RANDOM}};
  kernel_3 = _RAND_10[15:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_11 = {1{`RANDOM}};
  kernel_4 = _RAND_11[15:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_12 = {1{`RANDOM}};
  kernel_5 = _RAND_12[15:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_13 = {1{`RANDOM}};
  kernel_6 = _RAND_13[15:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_14 = {1{`RANDOM}};
  kernel_7 = _RAND_14[15:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_15 = {1{`RANDOM}};
  kernel_8 = _RAND_15[15:0];
  `endif // RANDOMIZE_REG_INIT
  end
`endif // RANDOMIZE
  always @(posedge clock) begin
    if (reset) begin
      value <= 5'h0;
    end else begin
      if (_T_28) begin
        value <= 5'h0;
      end else begin
        value <= _T_31;
      end
    end
    if (reset) begin
      value_1 <= 1'h0;
    end else begin
      if (computationStarted) begin
        if (!(_T_37)) begin
          value_1 <= _T_48;
        end
      end
    end
    if (reset) begin
      value_2 <= 6'h0;
    end else begin
      if (_T_57) begin
        value_2 <= _T_62;
      end
    end
    if (reset) begin
      value_3 <= 3'h0;
    end else begin
      if (computationStarted) begin
        if (_T_37) begin
          value_3 <= _T_42;
        end
      end
    end
    if (reset) begin
      computationStarted <= 1'h0;
    end else begin
      if (_T_28) begin
        computationStarted <= 1'h1;
      end
    end
    if (reset) begin
      processWrapped <= 1'h0;
    end else begin
      if (computationStarted) begin
        if (_T_37) begin
          if (_T_39) begin
            processWrapped <= 1'h1;
          end
        end else begin
          if (value_1) begin
            processWrapped <= 1'h0;
          end
        end
      end
    end
    if (reset) begin
      computationEnded <= 1'h0;
    end else begin
      if (_T_57) begin
        if (_T_59) begin
          computationEnded <= 1'h1;
        end
      end
    end
    if (reset) begin
      kernel_0 <= 16'sh0;
    end else begin
      kernel_0 <= $signed(_GEN_15);
    end
    if (reset) begin
      kernel_1 <= 16'sh0;
    end else begin
      kernel_1 <= $signed(_GEN_17);
    end
    if (reset) begin
      kernel_2 <= 16'sh0;
    end else begin
      kernel_2 <= $signed(_GEN_19);
    end
    if (reset) begin
      kernel_3 <= 16'sh0;
    end else begin
      kernel_3 <= $signed(_GEN_21);
    end
    if (reset) begin
      kernel_4 <= 16'sh0;
    end else begin
      kernel_4 <= $signed(_GEN_23);
    end
    if (reset) begin
      kernel_5 <= 16'sh0;
    end else begin
      kernel_5 <= $signed(_GEN_25);
    end
    if (reset) begin
      kernel_6 <= 16'sh0;
    end else begin
      kernel_6 <= $signed(_GEN_27);
    end
    if (reset) begin
      kernel_7 <= 16'sh0;
    end else begin
      kernel_7 <= $signed(_GEN_29);
    end
    if (reset) begin
      kernel_8 <= 16'sh0;
    end else begin
      kernel_8 <= $signed(_GEN_31);
    end
  end
endmodule
