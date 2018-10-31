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
  input         io_clock, // @[:@102.4]
  output [15:0] io_tdata, // @[:@102.4]
  output        io_tvalid, // @[:@102.4]
  input         io_tready, // @[:@102.4]
  output        io_tlast, // @[:@102.4]
  output [3:0]  io_tkeep // @[:@102.4]
);
  wire  fifo1_0_clock; // @[GaussianBlur.scala 88:25:@166.4]
  wire  fifo1_0_reset; // @[GaussianBlur.scala 88:25:@166.4]
  wire [15:0] fifo1_0_io_dataIn; // @[GaussianBlur.scala 88:25:@166.4]
  wire [15:0] fifo1_0_io_dataOut; // @[GaussianBlur.scala 88:25:@166.4]
  wire  fifo2_1_clock; // @[GaussianBlur.scala 89:25:@169.4]
  wire  fifo2_1_reset; // @[GaussianBlur.scala 89:25:@169.4]
  wire [15:0] fifo2_1_io_dataIn; // @[GaussianBlur.scala 89:25:@169.4]
  wire [15:0] fifo2_1_io_dataOut; // @[GaussianBlur.scala 89:25:@169.4]
  wire  fifo3_2_clock; // @[GaussianBlur.scala 90:25:@172.4]
  wire  fifo3_2_reset; // @[GaussianBlur.scala 90:25:@172.4]
  wire [15:0] fifo3_2_io_dataIn; // @[GaussianBlur.scala 90:25:@172.4]
  wire [15:0] fifo3_2_io_dataOut; // @[GaussianBlur.scala 90:25:@172.4]
  wire  fifo4_3_clock; // @[GaussianBlur.scala 91:25:@175.4]
  wire  fifo4_3_reset; // @[GaussianBlur.scala 91:25:@175.4]
  wire [15:0] fifo4_3_io_dataIn; // @[GaussianBlur.scala 91:25:@175.4]
  wire [15:0] fifo4_3_io_dataOut; // @[GaussianBlur.scala 91:25:@175.4]
  wire  fifo5_4_clock; // @[GaussianBlur.scala 92:25:@178.4]
  wire  fifo5_4_reset; // @[GaussianBlur.scala 92:25:@178.4]
  wire [15:0] fifo5_4_io_dataIn; // @[GaussianBlur.scala 92:25:@178.4]
  wire [15:0] fifo5_4_io_dataOut; // @[GaussianBlur.scala 92:25:@178.4]
  wire  fifo6_5_clock; // @[GaussianBlur.scala 93:25:@181.4]
  wire  fifo6_5_reset; // @[GaussianBlur.scala 93:25:@181.4]
  wire [15:0] fifo6_5_io_dataIn; // @[GaussianBlur.scala 93:25:@181.4]
  wire [15:0] fifo6_5_io_dataOut; // @[GaussianBlur.scala 93:25:@181.4]
  wire  fifo7_6_clock; // @[GaussianBlur.scala 94:25:@184.4]
  wire  fifo7_6_reset; // @[GaussianBlur.scala 94:25:@184.4]
  wire [15:0] fifo7_6_io_dataIn; // @[GaussianBlur.scala 94:25:@184.4]
  wire [15:0] fifo7_6_io_dataOut; // @[GaussianBlur.scala 94:25:@184.4]
  wire  fifo8_7_clock; // @[GaussianBlur.scala 95:25:@187.4]
  wire  fifo8_7_reset; // @[GaussianBlur.scala 95:25:@187.4]
  wire [15:0] fifo8_7_io_dataIn; // @[GaussianBlur.scala 95:25:@187.4]
  wire [15:0] fifo8_7_io_dataOut; // @[GaussianBlur.scala 95:25:@187.4]
  reg [4:0] value; // @[Counter.scala 26:33:@109.4]
  reg [31:0] _RAND_0;
  reg  value_1; // @[Counter.scala 26:33:@110.4]
  reg [31:0] _RAND_1;
  reg [5:0] value_2; // @[Counter.scala 26:33:@111.4]
  reg [31:0] _RAND_2;
  reg [2:0] value_3; // @[Counter.scala 26:33:@112.4]
  reg [31:0] _RAND_3;
  reg  computationStarted; // @[GaussianBlur.scala 46:35:@113.4]
  reg [31:0] _RAND_4;
  reg  processWrapped; // @[GaussianBlur.scala 47:31:@114.4]
  reg [31:0] _RAND_5;
  reg  computationEnded; // @[GaussianBlur.scala 48:33:@115.4]
  reg [31:0] _RAND_6;
  wire  _T_39; // @[Counter.scala 34:24:@116.4]
  wire [5:0] _T_41; // @[Counter.scala 35:22:@117.4]
  wire [4:0] _T_42; // @[Counter.scala 35:22:@118.4]
  wire [4:0] _GEN_0; // @[Counter.scala 37:21:@120.4]
  wire  _GEN_1; // @[GaussianBlur.scala 50:27:@123.4]
  wire  _T_48; // @[GaussianBlur.scala 56:26:@128.6]
  wire  _T_50; // @[Counter.scala 34:24:@130.8]
  wire [3:0] _T_52; // @[Counter.scala 35:22:@131.8]
  wire [2:0] _T_53; // @[Counter.scala 35:22:@132.8]
  wire  _GEN_2; // @[GaussianBlur.scala 57:33:@134.8]
  wire [1:0] _T_58; // @[Counter.scala 35:22:@140.8]
  wire  _T_59; // @[Counter.scala 35:22:@141.8]
  wire  _GEN_3; // @[GaussianBlur.scala 61:32:@143.8]
  wire [2:0] _GEN_4; // @[GaussianBlur.scala 56:34:@129.6]
  wire  _GEN_5; // @[GaussianBlur.scala 56:34:@129.6]
  wire  _GEN_6; // @[GaussianBlur.scala 56:34:@129.6]
  wire [2:0] _GEN_7; // @[GaussianBlur.scala 54:35:@127.4]
  wire  _GEN_8; // @[GaussianBlur.scala 54:35:@127.4]
  wire  _GEN_9; // @[GaussianBlur.scala 54:35:@127.4]
  wire  _T_65; // @[GaussianBlur.scala 66:31:@150.4]
  wire  _T_67; // @[GaussianBlur.scala 66:81:@151.4]
  wire  _T_68; // @[GaussianBlur.scala 66:61:@152.4]
  wire  _T_70; // @[Counter.scala 34:24:@154.6]
  wire [6:0] _T_72; // @[Counter.scala 35:22:@155.6]
  wire [5:0] _T_73; // @[Counter.scala 35:22:@156.6]
  wire  _GEN_10; // @[GaussianBlur.scala 67:28:@158.6]
  wire [5:0] _GEN_11; // @[GaussianBlur.scala 66:89:@153.4]
  wire  _GEN_12; // @[GaussianBlur.scala 66:89:@153.4]
  reg [15:0] kernel_0; // @[GaussianBlur.scala 110:27:@198.4]
  reg [31:0] _RAND_7;
  reg [15:0] kernel_1; // @[GaussianBlur.scala 111:27:@199.4]
  reg [31:0] _RAND_8;
  reg [15:0] kernel_2; // @[GaussianBlur.scala 112:27:@200.4]
  reg [31:0] _RAND_9;
  reg [15:0] kernel_3; // @[GaussianBlur.scala 113:27:@201.4]
  reg [31:0] _RAND_10;
  reg [15:0] kernel_4; // @[GaussianBlur.scala 114:27:@202.4]
  reg [31:0] _RAND_11;
  reg [15:0] kernel_5; // @[GaussianBlur.scala 115:27:@203.4]
  reg [31:0] _RAND_12;
  reg [15:0] kernel_6; // @[GaussianBlur.scala 116:27:@204.4]
  reg [31:0] _RAND_13;
  reg [15:0] kernel_7; // @[GaussianBlur.scala 117:27:@205.4]
  reg [31:0] _RAND_14;
  reg [15:0] kernel_8; // @[GaussianBlur.scala 118:27:@206.4]
  reg [31:0] _RAND_15;
  wire [31:0] _T_95; // @[GaussianBlur.scala 140:27:@207.4]
  wire [31:0] _T_96; // @[GaussianBlur.scala 141:35:@209.4]
  wire [31:0] _T_97; // @[GaussianBlur.scala 142:35:@211.4]
  wire [31:0] _T_98; // @[GaussianBlur.scala 143:35:@213.4]
  wire [31:0] _T_99; // @[GaussianBlur.scala 144:35:@215.4]
  wire [31:0] _T_100; // @[GaussianBlur.scala 145:35:@217.4]
  wire [31:0] _T_101; // @[GaussianBlur.scala 146:35:@219.4]
  wire [31:0] _T_102; // @[GaussianBlur.scala 147:35:@221.4]
  wire [31:0] _T_103; // @[GaussianBlur.scala 148:35:@223.4]
  wire [16:0] _T_104; // @[GaussianBlur.scala 153:18:@226.6]
  wire [15:0] _T_105; // @[GaussianBlur.scala 153:18:@227.6]
  wire [15:0] _T_106; // @[GaussianBlur.scala 153:18:@228.6]
  wire [16:0] _T_107; // @[GaussianBlur.scala 154:20:@229.6]
  wire [15:0] _T_108; // @[GaussianBlur.scala 154:20:@230.6]
  wire [15:0] _T_109; // @[GaussianBlur.scala 154:20:@231.6]
  wire [16:0] _T_110; // @[GaussianBlur.scala 155:20:@232.6]
  wire [15:0] _T_111; // @[GaussianBlur.scala 155:20:@233.6]
  wire [15:0] _T_112; // @[GaussianBlur.scala 155:20:@234.6]
  wire [16:0] _T_113; // @[GaussianBlur.scala 156:20:@235.6]
  wire [15:0] _T_114; // @[GaussianBlur.scala 156:20:@236.6]
  wire [15:0] _T_115; // @[GaussianBlur.scala 156:20:@237.6]
  wire [16:0] _T_116; // @[GaussianBlur.scala 157:20:@238.6]
  wire [15:0] _T_117; // @[GaussianBlur.scala 157:20:@239.6]
  wire [15:0] _T_118; // @[GaussianBlur.scala 157:20:@240.6]
  wire [16:0] _T_119; // @[GaussianBlur.scala 158:20:@241.6]
  wire [15:0] _T_120; // @[GaussianBlur.scala 158:20:@242.6]
  wire [15:0] _T_121; // @[GaussianBlur.scala 158:20:@243.6]
  wire [16:0] _T_122; // @[GaussianBlur.scala 159:20:@244.6]
  wire [15:0] _T_123; // @[GaussianBlur.scala 159:20:@245.6]
  wire [15:0] _T_124; // @[GaussianBlur.scala 159:20:@246.6]
  wire [16:0] _T_125; // @[GaussianBlur.scala 160:20:@247.6]
  wire [15:0] _T_126; // @[GaussianBlur.scala 160:20:@248.6]
  wire [15:0] _T_127; // @[GaussianBlur.scala 160:20:@249.6]
  wire [15:0] _T_128; // @[GaussianBlur.scala 161:22:@250.6]
  wire [23:0] _GEN_15; // @[GaussianBlur.scala 148:14:@224.4]
  wire [15:0] _GEN_16; // @[GaussianBlur.scala 148:14:@224.4]
  wire [23:0] _GEN_17; // @[GaussianBlur.scala 147:14:@222.4]
  wire [15:0] _GEN_18; // @[GaussianBlur.scala 147:14:@222.4]
  wire [23:0] _GEN_19; // @[GaussianBlur.scala 146:14:@220.4]
  wire [15:0] _GEN_20; // @[GaussianBlur.scala 146:14:@220.4]
  wire [23:0] _GEN_21; // @[GaussianBlur.scala 145:14:@218.4]
  wire [15:0] _GEN_22; // @[GaussianBlur.scala 145:14:@218.4]
  wire [23:0] _GEN_23; // @[GaussianBlur.scala 144:14:@216.4]
  wire [15:0] _GEN_24; // @[GaussianBlur.scala 144:14:@216.4]
  wire [23:0] _GEN_25; // @[GaussianBlur.scala 143:14:@214.4]
  wire [15:0] _GEN_26; // @[GaussianBlur.scala 143:14:@214.4]
  wire [23:0] _GEN_27; // @[GaussianBlur.scala 142:14:@212.4]
  wire [15:0] _GEN_28; // @[GaussianBlur.scala 142:14:@212.4]
  wire [23:0] _GEN_29; // @[GaussianBlur.scala 141:14:@210.4]
  wire [15:0] _GEN_30; // @[GaussianBlur.scala 141:14:@210.4]
  wire [23:0] _GEN_31; // @[GaussianBlur.scala 140:14:@208.4]
  wire [15:0] _GEN_32; // @[GaussianBlur.scala 140:14:@208.4]
  FIFO fifo1_0 ( // @[GaussianBlur.scala 88:25:@166.4]
    .clock(fifo1_0_clock),
    .reset(fifo1_0_reset),
    .io_dataIn(fifo1_0_io_dataIn),
    .io_dataOut(fifo1_0_io_dataOut)
  );
  FIFO fifo2_1 ( // @[GaussianBlur.scala 89:25:@169.4]
    .clock(fifo2_1_clock),
    .reset(fifo2_1_reset),
    .io_dataIn(fifo2_1_io_dataIn),
    .io_dataOut(fifo2_1_io_dataOut)
  );
  FIFO_2 fifo3_2 ( // @[GaussianBlur.scala 90:25:@172.4]
    .clock(fifo3_2_clock),
    .reset(fifo3_2_reset),
    .io_dataIn(fifo3_2_io_dataIn),
    .io_dataOut(fifo3_2_io_dataOut)
  );
  FIFO fifo4_3 ( // @[GaussianBlur.scala 91:25:@175.4]
    .clock(fifo4_3_clock),
    .reset(fifo4_3_reset),
    .io_dataIn(fifo4_3_io_dataIn),
    .io_dataOut(fifo4_3_io_dataOut)
  );
  FIFO fifo5_4 ( // @[GaussianBlur.scala 92:25:@178.4]
    .clock(fifo5_4_clock),
    .reset(fifo5_4_reset),
    .io_dataIn(fifo5_4_io_dataIn),
    .io_dataOut(fifo5_4_io_dataOut)
  );
  FIFO_2 fifo6_5 ( // @[GaussianBlur.scala 93:25:@181.4]
    .clock(fifo6_5_clock),
    .reset(fifo6_5_reset),
    .io_dataIn(fifo6_5_io_dataIn),
    .io_dataOut(fifo6_5_io_dataOut)
  );
  FIFO fifo7_6 ( // @[GaussianBlur.scala 94:25:@184.4]
    .clock(fifo7_6_clock),
    .reset(fifo7_6_reset),
    .io_dataIn(fifo7_6_io_dataIn),
    .io_dataOut(fifo7_6_io_dataOut)
  );
  FIFO fifo8_7 ( // @[GaussianBlur.scala 95:25:@187.4]
    .clock(fifo8_7_clock),
    .reset(fifo8_7_reset),
    .io_dataIn(fifo8_7_io_dataIn),
    .io_dataOut(fifo8_7_io_dataOut)
  );
  assign _T_39 = value == 5'h15; // @[Counter.scala 34:24:@116.4]
  assign _T_41 = value + 5'h1; // @[Counter.scala 35:22:@117.4]
  assign _T_42 = _T_41[4:0]; // @[Counter.scala 35:22:@118.4]
  assign _GEN_0 = _T_39 ? 5'h0 : _T_42; // @[Counter.scala 37:21:@120.4]
  assign _GEN_1 = _T_39 ? 1'h1 : computationStarted; // @[GaussianBlur.scala 50:27:@123.4]
  assign _T_48 = processWrapped == 1'h0; // @[GaussianBlur.scala 56:26:@128.6]
  assign _T_50 = value_3 == 3'h7; // @[Counter.scala 34:24:@130.8]
  assign _T_52 = value_3 + 3'h1; // @[Counter.scala 35:22:@131.8]
  assign _T_53 = _T_52[2:0]; // @[Counter.scala 35:22:@132.8]
  assign _GEN_2 = _T_50 ? 1'h1 : processWrapped; // @[GaussianBlur.scala 57:33:@134.8]
  assign _T_58 = value_1 + 1'h1; // @[Counter.scala 35:22:@140.8]
  assign _T_59 = _T_58[0:0]; // @[Counter.scala 35:22:@141.8]
  assign _GEN_3 = value_1 ? 1'h0 : processWrapped; // @[GaussianBlur.scala 61:32:@143.8]
  assign _GEN_4 = _T_48 ? _T_53 : value_3; // @[GaussianBlur.scala 56:34:@129.6]
  assign _GEN_5 = _T_48 ? _GEN_2 : _GEN_3; // @[GaussianBlur.scala 56:34:@129.6]
  assign _GEN_6 = _T_48 ? value_1 : _T_59; // @[GaussianBlur.scala 56:34:@129.6]
  assign _GEN_7 = computationStarted ? _GEN_4 : value_3; // @[GaussianBlur.scala 54:35:@127.4]
  assign _GEN_8 = computationStarted ? _GEN_5 : processWrapped; // @[GaussianBlur.scala 54:35:@127.4]
  assign _GEN_9 = computationStarted ? _GEN_6 : value_1; // @[GaussianBlur.scala 54:35:@127.4]
  assign _T_65 = _T_48 & computationStarted; // @[GaussianBlur.scala 66:31:@150.4]
  assign _T_67 = computationEnded == 1'h0; // @[GaussianBlur.scala 66:81:@151.4]
  assign _T_68 = _T_65 & _T_67; // @[GaussianBlur.scala 66:61:@152.4]
  assign _T_70 = value_2 == 6'h3f; // @[Counter.scala 34:24:@154.6]
  assign _T_72 = value_2 + 6'h1; // @[Counter.scala 35:22:@155.6]
  assign _T_73 = _T_72[5:0]; // @[Counter.scala 35:22:@156.6]
  assign _GEN_10 = _T_70 ? 1'h1 : computationEnded; // @[GaussianBlur.scala 67:28:@158.6]
  assign _GEN_11 = _T_68 ? _T_73 : value_2; // @[GaussianBlur.scala 66:89:@153.4]
  assign _GEN_12 = _T_68 ? _GEN_10 : computationEnded; // @[GaussianBlur.scala 66:89:@153.4]
  assign _T_95 = $signed(io_dataIn) * $signed(16'sh14); // @[GaussianBlur.scala 140:27:@207.4]
  assign _T_96 = $signed(fifo8_7_io_dataOut) * $signed(16'sh20); // @[GaussianBlur.scala 141:35:@209.4]
  assign _T_97 = $signed(fifo7_6_io_dataOut) * $signed(16'sh14); // @[GaussianBlur.scala 142:35:@211.4]
  assign _T_98 = $signed(fifo6_5_io_dataOut) * $signed(16'sh20); // @[GaussianBlur.scala 143:35:@213.4]
  assign _T_99 = $signed(fifo5_4_io_dataOut) * $signed(16'sh32); // @[GaussianBlur.scala 144:35:@215.4]
  assign _T_100 = $signed(fifo4_3_io_dataOut) * $signed(16'sh20); // @[GaussianBlur.scala 145:35:@217.4]
  assign _T_101 = $signed(fifo3_2_io_dataOut) * $signed(16'sh14); // @[GaussianBlur.scala 146:35:@219.4]
  assign _T_102 = $signed(fifo2_1_io_dataOut) * $signed(16'sh20); // @[GaussianBlur.scala 147:35:@221.4]
  assign _T_103 = $signed(fifo1_0_io_dataOut) * $signed(16'sh14); // @[GaussianBlur.scala 148:35:@223.4]
  assign _T_104 = $signed(kernel_0) + $signed(kernel_1); // @[GaussianBlur.scala 153:18:@226.6]
  assign _T_105 = _T_104[15:0]; // @[GaussianBlur.scala 153:18:@227.6]
  assign _T_106 = $signed(_T_105); // @[GaussianBlur.scala 153:18:@228.6]
  assign _T_107 = $signed(_T_106) + $signed(kernel_2); // @[GaussianBlur.scala 154:20:@229.6]
  assign _T_108 = _T_107[15:0]; // @[GaussianBlur.scala 154:20:@230.6]
  assign _T_109 = $signed(_T_108); // @[GaussianBlur.scala 154:20:@231.6]
  assign _T_110 = $signed(_T_109) + $signed(kernel_3); // @[GaussianBlur.scala 155:20:@232.6]
  assign _T_111 = _T_110[15:0]; // @[GaussianBlur.scala 155:20:@233.6]
  assign _T_112 = $signed(_T_111); // @[GaussianBlur.scala 155:20:@234.6]
  assign _T_113 = $signed(_T_112) + $signed(kernel_4); // @[GaussianBlur.scala 156:20:@235.6]
  assign _T_114 = _T_113[15:0]; // @[GaussianBlur.scala 156:20:@236.6]
  assign _T_115 = $signed(_T_114); // @[GaussianBlur.scala 156:20:@237.6]
  assign _T_116 = $signed(_T_115) + $signed(kernel_5); // @[GaussianBlur.scala 157:20:@238.6]
  assign _T_117 = _T_116[15:0]; // @[GaussianBlur.scala 157:20:@239.6]
  assign _T_118 = $signed(_T_117); // @[GaussianBlur.scala 157:20:@240.6]
  assign _T_119 = $signed(_T_118) + $signed(kernel_6); // @[GaussianBlur.scala 158:20:@241.6]
  assign _T_120 = _T_119[15:0]; // @[GaussianBlur.scala 158:20:@242.6]
  assign _T_121 = $signed(_T_120); // @[GaussianBlur.scala 158:20:@243.6]
  assign _T_122 = $signed(_T_121) + $signed(kernel_7); // @[GaussianBlur.scala 159:20:@244.6]
  assign _T_123 = _T_122[15:0]; // @[GaussianBlur.scala 159:20:@245.6]
  assign _T_124 = $signed(_T_123); // @[GaussianBlur.scala 159:20:@246.6]
  assign _T_125 = $signed(_T_124) + $signed(kernel_8); // @[GaussianBlur.scala 160:20:@247.6]
  assign _T_126 = _T_125[15:0]; // @[GaussianBlur.scala 160:20:@248.6]
  assign _T_127 = $signed(_T_126); // @[GaussianBlur.scala 160:20:@249.6]
  assign _T_128 = $unsigned(_T_127); // @[GaussianBlur.scala 161:22:@250.6]
  assign io_tdata = io_tready ? _T_128 : 16'h0; // @[GaussianBlur.scala 29:12:@104.4 GaussianBlur.scala 152:16:@251.6]
  assign io_tvalid = _T_65 & _T_67; // @[GaussianBlur.scala 32:13:@108.4 GaussianBlur.scala 70:15:@161.6 GaussianBlur.scala 72:17:@164.6]
  assign io_tlast = 1'h0; // @[GaussianBlur.scala 30:12:@105.4]
  assign io_tkeep = 4'h1; // @[GaussianBlur.scala 31:12:@107.4]
  assign fifo1_0_clock = clock; // @[:@167.4]
  assign fifo1_0_reset = reset; // @[:@168.4]
  assign fifo1_0_io_dataIn = fifo2_1_io_dataOut; // @[GaussianBlur.scala 106:23:@197.4]
  assign fifo2_1_clock = clock; // @[:@170.4]
  assign fifo2_1_reset = reset; // @[:@171.4]
  assign fifo2_1_io_dataIn = fifo3_2_io_dataOut; // @[GaussianBlur.scala 105:23:@196.4]
  assign fifo3_2_clock = clock; // @[:@173.4]
  assign fifo3_2_reset = reset; // @[:@174.4]
  assign fifo3_2_io_dataIn = fifo4_3_io_dataOut; // @[GaussianBlur.scala 104:23:@195.4]
  assign fifo4_3_clock = clock; // @[:@176.4]
  assign fifo4_3_reset = reset; // @[:@177.4]
  assign fifo4_3_io_dataIn = fifo5_4_io_dataOut; // @[GaussianBlur.scala 103:23:@194.4]
  assign fifo5_4_clock = clock; // @[:@179.4]
  assign fifo5_4_reset = reset; // @[:@180.4]
  assign fifo5_4_io_dataIn = fifo6_5_io_dataOut; // @[GaussianBlur.scala 102:23:@193.4]
  assign fifo6_5_clock = clock; // @[:@182.4]
  assign fifo6_5_reset = reset; // @[:@183.4]
  assign fifo6_5_io_dataIn = fifo7_6_io_dataOut; // @[GaussianBlur.scala 101:23:@192.4]
  assign fifo7_6_clock = clock; // @[:@185.4]
  assign fifo7_6_reset = reset; // @[:@186.4]
  assign fifo7_6_io_dataIn = fifo8_7_io_dataOut; // @[GaussianBlur.scala 100:23:@191.4]
  assign fifo8_7_clock = clock; // @[:@188.4]
  assign fifo8_7_reset = reset; // @[:@189.4]
  assign fifo8_7_io_dataIn = io_dataIn; // @[GaussianBlur.scala 99:23:@190.4]
  assign _GEN_15 = _T_103[31:8]; // @[GaussianBlur.scala 148:14:@224.4]
  assign _GEN_16 = _GEN_15[15:0]; // @[GaussianBlur.scala 148:14:@224.4]
  assign _GEN_17 = _T_102[31:8]; // @[GaussianBlur.scala 147:14:@222.4]
  assign _GEN_18 = _GEN_17[15:0]; // @[GaussianBlur.scala 147:14:@222.4]
  assign _GEN_19 = _T_101[31:8]; // @[GaussianBlur.scala 146:14:@220.4]
  assign _GEN_20 = _GEN_19[15:0]; // @[GaussianBlur.scala 146:14:@220.4]
  assign _GEN_21 = _T_100[31:8]; // @[GaussianBlur.scala 145:14:@218.4]
  assign _GEN_22 = _GEN_21[15:0]; // @[GaussianBlur.scala 145:14:@218.4]
  assign _GEN_23 = _T_99[31:8]; // @[GaussianBlur.scala 144:14:@216.4]
  assign _GEN_24 = _GEN_23[15:0]; // @[GaussianBlur.scala 144:14:@216.4]
  assign _GEN_25 = _T_98[31:8]; // @[GaussianBlur.scala 143:14:@214.4]
  assign _GEN_26 = _GEN_25[15:0]; // @[GaussianBlur.scala 143:14:@214.4]
  assign _GEN_27 = _T_97[31:8]; // @[GaussianBlur.scala 142:14:@212.4]
  assign _GEN_28 = _GEN_27[15:0]; // @[GaussianBlur.scala 142:14:@212.4]
  assign _GEN_29 = _T_96[31:8]; // @[GaussianBlur.scala 141:14:@210.4]
  assign _GEN_30 = _GEN_29[15:0]; // @[GaussianBlur.scala 141:14:@210.4]
  assign _GEN_31 = _T_95[31:8]; // @[GaussianBlur.scala 140:14:@208.4]
  assign _GEN_32 = _GEN_31[15:0]; // @[GaussianBlur.scala 140:14:@208.4]
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
      if (_T_39) begin
        value <= 5'h0;
      end else begin
        value <= _T_42;
      end
    end
    if (reset) begin
      value_1 <= 1'h0;
    end else begin
      if (computationStarted) begin
        if (!(_T_48)) begin
          value_1 <= _T_59;
        end
      end
    end
    if (reset) begin
      value_2 <= 6'h0;
    end else begin
      if (_T_68) begin
        value_2 <= _T_73;
      end
    end
    if (reset) begin
      value_3 <= 3'h0;
    end else begin
      if (computationStarted) begin
        if (_T_48) begin
          value_3 <= _T_53;
        end
      end
    end
    if (reset) begin
      computationStarted <= 1'h0;
    end else begin
      if (_T_39) begin
        computationStarted <= 1'h1;
      end
    end
    if (reset) begin
      processWrapped <= 1'h0;
    end else begin
      if (computationStarted) begin
        if (_T_48) begin
          if (_T_50) begin
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
      if (_T_68) begin
        if (_T_70) begin
          computationEnded <= 1'h1;
        end
      end
    end
    if (reset) begin
      kernel_0 <= 16'sh0;
    end else begin
      kernel_0 <= $signed(_GEN_16);
    end
    if (reset) begin
      kernel_1 <= 16'sh0;
    end else begin
      kernel_1 <= $signed(_GEN_18);
    end
    if (reset) begin
      kernel_2 <= 16'sh0;
    end else begin
      kernel_2 <= $signed(_GEN_20);
    end
    if (reset) begin
      kernel_3 <= 16'sh0;
    end else begin
      kernel_3 <= $signed(_GEN_22);
    end
    if (reset) begin
      kernel_4 <= 16'sh0;
    end else begin
      kernel_4 <= $signed(_GEN_24);
    end
    if (reset) begin
      kernel_5 <= 16'sh0;
    end else begin
      kernel_5 <= $signed(_GEN_26);
    end
    if (reset) begin
      kernel_6 <= 16'sh0;
    end else begin
      kernel_6 <= $signed(_GEN_28);
    end
    if (reset) begin
      kernel_7 <= 16'sh0;
    end else begin
      kernel_7 <= $signed(_GEN_30);
    end
    if (reset) begin
      kernel_8 <= 16'sh0;
    end else begin
      kernel_8 <= $signed(_GEN_32);
    end
  end
endmodule
