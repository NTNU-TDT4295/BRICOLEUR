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
module GaussianBlur( // @[:@99.2]
  input         clock, // @[:@100.4]
  input         reset, // @[:@101.4]
  input  [15:0] io_dataIn, // @[:@102.4]
  output [15:0] io_dataOut, // @[:@102.4]
  input         io_clock, // @[:@102.4]
  output        io_valid // @[:@102.4]
);
  wire  fifo1_0_clock; // @[GaussianBlur.scala 78:25:@161.4]
  wire  fifo1_0_reset; // @[GaussianBlur.scala 78:25:@161.4]
  wire [15:0] fifo1_0_io_dataIn; // @[GaussianBlur.scala 78:25:@161.4]
  wire [15:0] fifo1_0_io_dataOut; // @[GaussianBlur.scala 78:25:@161.4]
  wire  fifo2_1_clock; // @[GaussianBlur.scala 79:25:@164.4]
  wire  fifo2_1_reset; // @[GaussianBlur.scala 79:25:@164.4]
  wire [15:0] fifo2_1_io_dataIn; // @[GaussianBlur.scala 79:25:@164.4]
  wire [15:0] fifo2_1_io_dataOut; // @[GaussianBlur.scala 79:25:@164.4]
  wire  fifo3_2_clock; // @[GaussianBlur.scala 80:25:@167.4]
  wire  fifo3_2_reset; // @[GaussianBlur.scala 80:25:@167.4]
  wire [15:0] fifo3_2_io_dataIn; // @[GaussianBlur.scala 80:25:@167.4]
  wire [15:0] fifo3_2_io_dataOut; // @[GaussianBlur.scala 80:25:@167.4]
  wire  fifo4_3_clock; // @[GaussianBlur.scala 81:25:@170.4]
  wire  fifo4_3_reset; // @[GaussianBlur.scala 81:25:@170.4]
  wire [15:0] fifo4_3_io_dataIn; // @[GaussianBlur.scala 81:25:@170.4]
  wire [15:0] fifo4_3_io_dataOut; // @[GaussianBlur.scala 81:25:@170.4]
  wire  fifo5_4_clock; // @[GaussianBlur.scala 82:25:@173.4]
  wire  fifo5_4_reset; // @[GaussianBlur.scala 82:25:@173.4]
  wire [15:0] fifo5_4_io_dataIn; // @[GaussianBlur.scala 82:25:@173.4]
  wire [15:0] fifo5_4_io_dataOut; // @[GaussianBlur.scala 82:25:@173.4]
  wire  fifo6_5_clock; // @[GaussianBlur.scala 83:25:@176.4]
  wire  fifo6_5_reset; // @[GaussianBlur.scala 83:25:@176.4]
  wire [15:0] fifo6_5_io_dataIn; // @[GaussianBlur.scala 83:25:@176.4]
  wire [15:0] fifo6_5_io_dataOut; // @[GaussianBlur.scala 83:25:@176.4]
  wire  fifo7_6_clock; // @[GaussianBlur.scala 84:25:@179.4]
  wire  fifo7_6_reset; // @[GaussianBlur.scala 84:25:@179.4]
  wire [15:0] fifo7_6_io_dataIn; // @[GaussianBlur.scala 84:25:@179.4]
  wire [15:0] fifo7_6_io_dataOut; // @[GaussianBlur.scala 84:25:@179.4]
  wire  fifo8_7_clock; // @[GaussianBlur.scala 85:25:@182.4]
  wire  fifo8_7_reset; // @[GaussianBlur.scala 85:25:@182.4]
  wire [15:0] fifo8_7_io_dataIn; // @[GaussianBlur.scala 85:25:@182.4]
  wire [15:0] fifo8_7_io_dataOut; // @[GaussianBlur.scala 85:25:@182.4]
  reg [4:0] value; // @[Counter.scala 26:33:@104.4]
  reg [31:0] _RAND_0;
  reg  value_1; // @[Counter.scala 26:33:@105.4]
  reg [31:0] _RAND_1;
  reg [5:0] value_2; // @[Counter.scala 26:33:@106.4]
  reg [31:0] _RAND_2;
  reg [2:0] value_3; // @[Counter.scala 26:33:@107.4]
  reg [31:0] _RAND_3;
  reg  computationStarted; // @[GaussianBlur.scala 36:35:@108.4]
  reg [31:0] _RAND_4;
  reg  processWrapped; // @[GaussianBlur.scala 37:31:@109.4]
  reg [31:0] _RAND_5;
  reg  computationEnded; // @[GaussianBlur.scala 38:33:@110.4]
  reg [31:0] _RAND_6;
  wire  _T_28; // @[Counter.scala 34:24:@111.4]
  wire [5:0] _T_30; // @[Counter.scala 35:22:@112.4]
  wire [4:0] _T_31; // @[Counter.scala 35:22:@113.4]
  wire [4:0] _GEN_0; // @[Counter.scala 37:21:@115.4]
  wire  _GEN_1; // @[GaussianBlur.scala 40:27:@118.4]
  wire  _T_37; // @[GaussianBlur.scala 46:26:@123.6]
  wire  _T_39; // @[Counter.scala 34:24:@125.8]
  wire [3:0] _T_41; // @[Counter.scala 35:22:@126.8]
  wire [2:0] _T_42; // @[Counter.scala 35:22:@127.8]
  wire  _GEN_2; // @[GaussianBlur.scala 47:33:@129.8]
  wire [1:0] _T_47; // @[Counter.scala 35:22:@135.8]
  wire  _T_48; // @[Counter.scala 35:22:@136.8]
  wire  _GEN_3; // @[GaussianBlur.scala 51:32:@138.8]
  wire [2:0] _GEN_4; // @[GaussianBlur.scala 46:34:@124.6]
  wire  _GEN_5; // @[GaussianBlur.scala 46:34:@124.6]
  wire  _GEN_6; // @[GaussianBlur.scala 46:34:@124.6]
  wire [2:0] _GEN_7; // @[GaussianBlur.scala 44:35:@122.4]
  wire  _GEN_8; // @[GaussianBlur.scala 44:35:@122.4]
  wire  _GEN_9; // @[GaussianBlur.scala 44:35:@122.4]
  wire  _T_54; // @[GaussianBlur.scala 56:31:@145.4]
  wire  _T_56; // @[GaussianBlur.scala 56:81:@146.4]
  wire  _T_57; // @[GaussianBlur.scala 56:61:@147.4]
  wire  _T_59; // @[Counter.scala 34:24:@149.6]
  wire [6:0] _T_61; // @[Counter.scala 35:22:@150.6]
  wire [5:0] _T_62; // @[Counter.scala 35:22:@151.6]
  wire  _GEN_10; // @[GaussianBlur.scala 57:28:@153.6]
  wire [5:0] _GEN_11; // @[GaussianBlur.scala 56:89:@148.4]
  wire  _GEN_12; // @[GaussianBlur.scala 56:89:@148.4]
  reg [15:0] kernel_0; // @[GaussianBlur.scala 100:27:@193.4]
  reg [31:0] _RAND_7;
  reg [15:0] kernel_1; // @[GaussianBlur.scala 101:27:@194.4]
  reg [31:0] _RAND_8;
  reg [15:0] kernel_2; // @[GaussianBlur.scala 102:27:@195.4]
  reg [31:0] _RAND_9;
  reg [15:0] kernel_3; // @[GaussianBlur.scala 103:27:@196.4]
  reg [31:0] _RAND_10;
  reg [15:0] kernel_4; // @[GaussianBlur.scala 104:27:@197.4]
  reg [31:0] _RAND_11;
  reg [15:0] kernel_5; // @[GaussianBlur.scala 105:27:@198.4]
  reg [31:0] _RAND_12;
  reg [15:0] kernel_6; // @[GaussianBlur.scala 106:27:@199.4]
  reg [31:0] _RAND_13;
  reg [15:0] kernel_7; // @[GaussianBlur.scala 107:27:@200.4]
  reg [31:0] _RAND_14;
  reg [15:0] kernel_8; // @[GaussianBlur.scala 108:27:@201.4]
  reg [31:0] _RAND_15;
  wire [31:0] _T_84; // @[GaussianBlur.scala 130:27:@202.4]
  wire [31:0] _T_85; // @[GaussianBlur.scala 131:35:@204.4]
  wire [31:0] _T_86; // @[GaussianBlur.scala 132:35:@206.4]
  wire [31:0] _T_87; // @[GaussianBlur.scala 133:35:@208.4]
  wire [31:0] _T_88; // @[GaussianBlur.scala 134:35:@210.4]
  wire [31:0] _T_89; // @[GaussianBlur.scala 135:35:@212.4]
  wire [31:0] _T_90; // @[GaussianBlur.scala 136:35:@214.4]
  wire [31:0] _T_91; // @[GaussianBlur.scala 137:35:@216.4]
  wire [31:0] _T_92; // @[GaussianBlur.scala 138:35:@218.4]
  wire [16:0] _T_93; // @[GaussianBlur.scala 142:16:@220.4]
  wire [15:0] _T_94; // @[GaussianBlur.scala 142:16:@221.4]
  wire [15:0] _T_95; // @[GaussianBlur.scala 142:16:@222.4]
  wire [16:0] _T_96; // @[GaussianBlur.scala 143:16:@223.4]
  wire [15:0] _T_97; // @[GaussianBlur.scala 143:16:@224.4]
  wire [15:0] _T_98; // @[GaussianBlur.scala 143:16:@225.4]
  wire [16:0] _T_99; // @[GaussianBlur.scala 144:16:@226.4]
  wire [15:0] _T_100; // @[GaussianBlur.scala 144:16:@227.4]
  wire [15:0] _T_101; // @[GaussianBlur.scala 144:16:@228.4]
  wire [16:0] _T_102; // @[GaussianBlur.scala 145:16:@229.4]
  wire [15:0] _T_103; // @[GaussianBlur.scala 145:16:@230.4]
  wire [15:0] _T_104; // @[GaussianBlur.scala 145:16:@231.4]
  wire [16:0] _T_105; // @[GaussianBlur.scala 146:16:@232.4]
  wire [15:0] _T_106; // @[GaussianBlur.scala 146:16:@233.4]
  wire [15:0] _T_107; // @[GaussianBlur.scala 146:16:@234.4]
  wire [16:0] _T_108; // @[GaussianBlur.scala 147:16:@235.4]
  wire [15:0] _T_109; // @[GaussianBlur.scala 147:16:@236.4]
  wire [15:0] _T_110; // @[GaussianBlur.scala 147:16:@237.4]
  wire [16:0] _T_111; // @[GaussianBlur.scala 148:16:@238.4]
  wire [15:0] _T_112; // @[GaussianBlur.scala 148:16:@239.4]
  wire [15:0] _T_113; // @[GaussianBlur.scala 148:16:@240.4]
  wire [16:0] _T_114; // @[GaussianBlur.scala 149:16:@241.4]
  wire [15:0] _T_115; // @[GaussianBlur.scala 149:16:@242.4]
  wire [15:0] _T_116; // @[GaussianBlur.scala 149:16:@243.4]
  wire [23:0] _GEN_14; // @[GaussianBlur.scala 138:14:@219.4]
  wire [15:0] _GEN_15; // @[GaussianBlur.scala 138:14:@219.4]
  wire [23:0] _GEN_16; // @[GaussianBlur.scala 137:14:@217.4]
  wire [15:0] _GEN_17; // @[GaussianBlur.scala 137:14:@217.4]
  wire [23:0] _GEN_18; // @[GaussianBlur.scala 136:14:@215.4]
  wire [15:0] _GEN_19; // @[GaussianBlur.scala 136:14:@215.4]
  wire [23:0] _GEN_20; // @[GaussianBlur.scala 135:14:@213.4]
  wire [15:0] _GEN_21; // @[GaussianBlur.scala 135:14:@213.4]
  wire [23:0] _GEN_22; // @[GaussianBlur.scala 134:14:@211.4]
  wire [15:0] _GEN_23; // @[GaussianBlur.scala 134:14:@211.4]
  wire [23:0] _GEN_24; // @[GaussianBlur.scala 133:14:@209.4]
  wire [15:0] _GEN_25; // @[GaussianBlur.scala 133:14:@209.4]
  wire [23:0] _GEN_26; // @[GaussianBlur.scala 132:14:@207.4]
  wire [15:0] _GEN_27; // @[GaussianBlur.scala 132:14:@207.4]
  wire [23:0] _GEN_28; // @[GaussianBlur.scala 131:14:@205.4]
  wire [15:0] _GEN_29; // @[GaussianBlur.scala 131:14:@205.4]
  wire [23:0] _GEN_30; // @[GaussianBlur.scala 130:14:@203.4]
  wire [15:0] _GEN_31; // @[GaussianBlur.scala 130:14:@203.4]
  FIFO fifo1_0 ( // @[GaussianBlur.scala 78:25:@161.4]
    .clock(fifo1_0_clock),
    .reset(fifo1_0_reset),
    .io_dataIn(fifo1_0_io_dataIn),
    .io_dataOut(fifo1_0_io_dataOut)
  );
  FIFO fifo2_1 ( // @[GaussianBlur.scala 79:25:@164.4]
    .clock(fifo2_1_clock),
    .reset(fifo2_1_reset),
    .io_dataIn(fifo2_1_io_dataIn),
    .io_dataOut(fifo2_1_io_dataOut)
  );
  FIFO_2 fifo3_2 ( // @[GaussianBlur.scala 80:25:@167.4]
    .clock(fifo3_2_clock),
    .reset(fifo3_2_reset),
    .io_dataIn(fifo3_2_io_dataIn),
    .io_dataOut(fifo3_2_io_dataOut)
  );
  FIFO fifo4_3 ( // @[GaussianBlur.scala 81:25:@170.4]
    .clock(fifo4_3_clock),
    .reset(fifo4_3_reset),
    .io_dataIn(fifo4_3_io_dataIn),
    .io_dataOut(fifo4_3_io_dataOut)
  );
  FIFO fifo5_4 ( // @[GaussianBlur.scala 82:25:@173.4]
    .clock(fifo5_4_clock),
    .reset(fifo5_4_reset),
    .io_dataIn(fifo5_4_io_dataIn),
    .io_dataOut(fifo5_4_io_dataOut)
  );
  FIFO_2 fifo6_5 ( // @[GaussianBlur.scala 83:25:@176.4]
    .clock(fifo6_5_clock),
    .reset(fifo6_5_reset),
    .io_dataIn(fifo6_5_io_dataIn),
    .io_dataOut(fifo6_5_io_dataOut)
  );
  FIFO fifo7_6 ( // @[GaussianBlur.scala 84:25:@179.4]
    .clock(fifo7_6_clock),
    .reset(fifo7_6_reset),
    .io_dataIn(fifo7_6_io_dataIn),
    .io_dataOut(fifo7_6_io_dataOut)
  );
  FIFO fifo8_7 ( // @[GaussianBlur.scala 85:25:@182.4]
    .clock(fifo8_7_clock),
    .reset(fifo8_7_reset),
    .io_dataIn(fifo8_7_io_dataIn),
    .io_dataOut(fifo8_7_io_dataOut)
  );
  assign _T_28 = value == 5'h15; // @[Counter.scala 34:24:@111.4]
  assign _T_30 = value + 5'h1; // @[Counter.scala 35:22:@112.4]
  assign _T_31 = _T_30[4:0]; // @[Counter.scala 35:22:@113.4]
  assign _GEN_0 = _T_28 ? 5'h0 : _T_31; // @[Counter.scala 37:21:@115.4]
  assign _GEN_1 = _T_28 ? 1'h1 : computationStarted; // @[GaussianBlur.scala 40:27:@118.4]
  assign _T_37 = processWrapped == 1'h0; // @[GaussianBlur.scala 46:26:@123.6]
  assign _T_39 = value_3 == 3'h7; // @[Counter.scala 34:24:@125.8]
  assign _T_41 = value_3 + 3'h1; // @[Counter.scala 35:22:@126.8]
  assign _T_42 = _T_41[2:0]; // @[Counter.scala 35:22:@127.8]
  assign _GEN_2 = _T_39 ? 1'h1 : processWrapped; // @[GaussianBlur.scala 47:33:@129.8]
  assign _T_47 = value_1 + 1'h1; // @[Counter.scala 35:22:@135.8]
  assign _T_48 = _T_47[0:0]; // @[Counter.scala 35:22:@136.8]
  assign _GEN_3 = value_1 ? 1'h0 : processWrapped; // @[GaussianBlur.scala 51:32:@138.8]
  assign _GEN_4 = _T_37 ? _T_42 : value_3; // @[GaussianBlur.scala 46:34:@124.6]
  assign _GEN_5 = _T_37 ? _GEN_2 : _GEN_3; // @[GaussianBlur.scala 46:34:@124.6]
  assign _GEN_6 = _T_37 ? value_1 : _T_48; // @[GaussianBlur.scala 46:34:@124.6]
  assign _GEN_7 = computationStarted ? _GEN_4 : value_3; // @[GaussianBlur.scala 44:35:@122.4]
  assign _GEN_8 = computationStarted ? _GEN_5 : processWrapped; // @[GaussianBlur.scala 44:35:@122.4]
  assign _GEN_9 = computationStarted ? _GEN_6 : value_1; // @[GaussianBlur.scala 44:35:@122.4]
  assign _T_54 = _T_37 & computationStarted; // @[GaussianBlur.scala 56:31:@145.4]
  assign _T_56 = computationEnded == 1'h0; // @[GaussianBlur.scala 56:81:@146.4]
  assign _T_57 = _T_54 & _T_56; // @[GaussianBlur.scala 56:61:@147.4]
  assign _T_59 = value_2 == 6'h3f; // @[Counter.scala 34:24:@149.6]
  assign _T_61 = value_2 + 6'h1; // @[Counter.scala 35:22:@150.6]
  assign _T_62 = _T_61[5:0]; // @[Counter.scala 35:22:@151.6]
  assign _GEN_10 = _T_59 ? 1'h1 : computationEnded; // @[GaussianBlur.scala 57:28:@153.6]
  assign _GEN_11 = _T_57 ? _T_62 : value_2; // @[GaussianBlur.scala 56:89:@148.4]
  assign _GEN_12 = _T_57 ? _GEN_10 : computationEnded; // @[GaussianBlur.scala 56:89:@148.4]
  assign _T_84 = $signed(io_dataIn) * $signed(16'sh14); // @[GaussianBlur.scala 130:27:@202.4]
  assign _T_85 = $signed(fifo8_7_io_dataOut) * $signed(16'sh20); // @[GaussianBlur.scala 131:35:@204.4]
  assign _T_86 = $signed(fifo7_6_io_dataOut) * $signed(16'sh14); // @[GaussianBlur.scala 132:35:@206.4]
  assign _T_87 = $signed(fifo6_5_io_dataOut) * $signed(16'sh20); // @[GaussianBlur.scala 133:35:@208.4]
  assign _T_88 = $signed(fifo5_4_io_dataOut) * $signed(16'sh32); // @[GaussianBlur.scala 134:35:@210.4]
  assign _T_89 = $signed(fifo4_3_io_dataOut) * $signed(16'sh20); // @[GaussianBlur.scala 135:35:@212.4]
  assign _T_90 = $signed(fifo3_2_io_dataOut) * $signed(16'sh14); // @[GaussianBlur.scala 136:35:@214.4]
  assign _T_91 = $signed(fifo2_1_io_dataOut) * $signed(16'sh20); // @[GaussianBlur.scala 137:35:@216.4]
  assign _T_92 = $signed(fifo1_0_io_dataOut) * $signed(16'sh14); // @[GaussianBlur.scala 138:35:@218.4]
  assign _T_93 = $signed(kernel_0) + $signed(kernel_1); // @[GaussianBlur.scala 142:16:@220.4]
  assign _T_94 = _T_93[15:0]; // @[GaussianBlur.scala 142:16:@221.4]
  assign _T_95 = $signed(_T_94); // @[GaussianBlur.scala 142:16:@222.4]
  assign _T_96 = $signed(_T_95) + $signed(kernel_2); // @[GaussianBlur.scala 143:16:@223.4]
  assign _T_97 = _T_96[15:0]; // @[GaussianBlur.scala 143:16:@224.4]
  assign _T_98 = $signed(_T_97); // @[GaussianBlur.scala 143:16:@225.4]
  assign _T_99 = $signed(_T_98) + $signed(kernel_3); // @[GaussianBlur.scala 144:16:@226.4]
  assign _T_100 = _T_99[15:0]; // @[GaussianBlur.scala 144:16:@227.4]
  assign _T_101 = $signed(_T_100); // @[GaussianBlur.scala 144:16:@228.4]
  assign _T_102 = $signed(_T_101) + $signed(kernel_4); // @[GaussianBlur.scala 145:16:@229.4]
  assign _T_103 = _T_102[15:0]; // @[GaussianBlur.scala 145:16:@230.4]
  assign _T_104 = $signed(_T_103); // @[GaussianBlur.scala 145:16:@231.4]
  assign _T_105 = $signed(_T_104) + $signed(kernel_5); // @[GaussianBlur.scala 146:16:@232.4]
  assign _T_106 = _T_105[15:0]; // @[GaussianBlur.scala 146:16:@233.4]
  assign _T_107 = $signed(_T_106); // @[GaussianBlur.scala 146:16:@234.4]
  assign _T_108 = $signed(_T_107) + $signed(kernel_6); // @[GaussianBlur.scala 147:16:@235.4]
  assign _T_109 = _T_108[15:0]; // @[GaussianBlur.scala 147:16:@236.4]
  assign _T_110 = $signed(_T_109); // @[GaussianBlur.scala 147:16:@237.4]
  assign _T_111 = $signed(_T_110) + $signed(kernel_7); // @[GaussianBlur.scala 148:16:@238.4]
  assign _T_112 = _T_111[15:0]; // @[GaussianBlur.scala 148:16:@239.4]
  assign _T_113 = $signed(_T_112); // @[GaussianBlur.scala 148:16:@240.4]
  assign _T_114 = $signed(_T_113) + $signed(kernel_8); // @[GaussianBlur.scala 149:16:@241.4]
  assign _T_115 = _T_114[15:0]; // @[GaussianBlur.scala 149:16:@242.4]
  assign _T_116 = $signed(_T_115); // @[GaussianBlur.scala 149:16:@243.4]
  assign io_dataOut = $unsigned(_T_116); // @[GaussianBlur.scala 141:16:@245.4]
  assign io_valid = _T_54 & _T_56; // @[GaussianBlur.scala 60:14:@156.6 GaussianBlur.scala 62:16:@159.6]
  assign fifo1_0_clock = clock; // @[:@162.4]
  assign fifo1_0_reset = reset; // @[:@163.4]
  assign fifo1_0_io_dataIn = fifo2_1_io_dataOut; // @[GaussianBlur.scala 96:23:@192.4]
  assign fifo2_1_clock = clock; // @[:@165.4]
  assign fifo2_1_reset = reset; // @[:@166.4]
  assign fifo2_1_io_dataIn = fifo3_2_io_dataOut; // @[GaussianBlur.scala 95:23:@191.4]
  assign fifo3_2_clock = clock; // @[:@168.4]
  assign fifo3_2_reset = reset; // @[:@169.4]
  assign fifo3_2_io_dataIn = fifo4_3_io_dataOut; // @[GaussianBlur.scala 94:23:@190.4]
  assign fifo4_3_clock = clock; // @[:@171.4]
  assign fifo4_3_reset = reset; // @[:@172.4]
  assign fifo4_3_io_dataIn = fifo5_4_io_dataOut; // @[GaussianBlur.scala 93:23:@189.4]
  assign fifo5_4_clock = clock; // @[:@174.4]
  assign fifo5_4_reset = reset; // @[:@175.4]
  assign fifo5_4_io_dataIn = fifo6_5_io_dataOut; // @[GaussianBlur.scala 92:23:@188.4]
  assign fifo6_5_clock = clock; // @[:@177.4]
  assign fifo6_5_reset = reset; // @[:@178.4]
  assign fifo6_5_io_dataIn = fifo7_6_io_dataOut; // @[GaussianBlur.scala 91:23:@187.4]
  assign fifo7_6_clock = clock; // @[:@180.4]
  assign fifo7_6_reset = reset; // @[:@181.4]
  assign fifo7_6_io_dataIn = fifo8_7_io_dataOut; // @[GaussianBlur.scala 90:23:@186.4]
  assign fifo8_7_clock = clock; // @[:@183.4]
  assign fifo8_7_reset = reset; // @[:@184.4]
  assign fifo8_7_io_dataIn = io_dataIn; // @[GaussianBlur.scala 89:23:@185.4]
  assign _GEN_14 = _T_92[31:8]; // @[GaussianBlur.scala 138:14:@219.4]
  assign _GEN_15 = _GEN_14[15:0]; // @[GaussianBlur.scala 138:14:@219.4]
  assign _GEN_16 = _T_91[31:8]; // @[GaussianBlur.scala 137:14:@217.4]
  assign _GEN_17 = _GEN_16[15:0]; // @[GaussianBlur.scala 137:14:@217.4]
  assign _GEN_18 = _T_90[31:8]; // @[GaussianBlur.scala 136:14:@215.4]
  assign _GEN_19 = _GEN_18[15:0]; // @[GaussianBlur.scala 136:14:@215.4]
  assign _GEN_20 = _T_89[31:8]; // @[GaussianBlur.scala 135:14:@213.4]
  assign _GEN_21 = _GEN_20[15:0]; // @[GaussianBlur.scala 135:14:@213.4]
  assign _GEN_22 = _T_88[31:8]; // @[GaussianBlur.scala 134:14:@211.4]
  assign _GEN_23 = _GEN_22[15:0]; // @[GaussianBlur.scala 134:14:@211.4]
  assign _GEN_24 = _T_87[31:8]; // @[GaussianBlur.scala 133:14:@209.4]
  assign _GEN_25 = _GEN_24[15:0]; // @[GaussianBlur.scala 133:14:@209.4]
  assign _GEN_26 = _T_86[31:8]; // @[GaussianBlur.scala 132:14:@207.4]
  assign _GEN_27 = _GEN_26[15:0]; // @[GaussianBlur.scala 132:14:@207.4]
  assign _GEN_28 = _T_85[31:8]; // @[GaussianBlur.scala 131:14:@205.4]
  assign _GEN_29 = _GEN_28[15:0]; // @[GaussianBlur.scala 131:14:@205.4]
  assign _GEN_30 = _T_84[31:8]; // @[GaussianBlur.scala 130:14:@203.4]
  assign _GEN_31 = _GEN_30[15:0]; // @[GaussianBlur.scala 130:14:@203.4]
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
