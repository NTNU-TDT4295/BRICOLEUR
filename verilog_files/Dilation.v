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
  output [15:0] io_tdata, // @[:@102.4]
  output        io_tvalid, // @[:@102.4]
  input         io_tready, // @[:@102.4]
  output        io_tlast, // @[:@102.4]
  output [3:0]  io_tkeep // @[:@102.4]
);
  wire  fifo1_0_clock; // @[Dilation.scala 88:23:@166.4]
  wire  fifo1_0_reset; // @[Dilation.scala 88:23:@166.4]
  wire [15:0] fifo1_0_io_dataIn; // @[Dilation.scala 88:23:@166.4]
  wire [15:0] fifo1_0_io_dataOut; // @[Dilation.scala 88:23:@166.4]
  wire  fifo2_1_clock; // @[Dilation.scala 89:23:@169.4]
  wire  fifo2_1_reset; // @[Dilation.scala 89:23:@169.4]
  wire [15:0] fifo2_1_io_dataIn; // @[Dilation.scala 89:23:@169.4]
  wire [15:0] fifo2_1_io_dataOut; // @[Dilation.scala 89:23:@169.4]
  wire  fifo3_2_clock; // @[Dilation.scala 90:23:@172.4]
  wire  fifo3_2_reset; // @[Dilation.scala 90:23:@172.4]
  wire [15:0] fifo3_2_io_dataIn; // @[Dilation.scala 90:23:@172.4]
  wire [15:0] fifo3_2_io_dataOut; // @[Dilation.scala 90:23:@172.4]
  wire  fifo4_3_clock; // @[Dilation.scala 91:23:@175.4]
  wire  fifo4_3_reset; // @[Dilation.scala 91:23:@175.4]
  wire [15:0] fifo4_3_io_dataIn; // @[Dilation.scala 91:23:@175.4]
  wire [15:0] fifo4_3_io_dataOut; // @[Dilation.scala 91:23:@175.4]
  wire  fifo5_4_clock; // @[Dilation.scala 92:23:@178.4]
  wire  fifo5_4_reset; // @[Dilation.scala 92:23:@178.4]
  wire [15:0] fifo5_4_io_dataIn; // @[Dilation.scala 92:23:@178.4]
  wire [15:0] fifo5_4_io_dataOut; // @[Dilation.scala 92:23:@178.4]
  wire  fifo6_5_clock; // @[Dilation.scala 93:23:@181.4]
  wire  fifo6_5_reset; // @[Dilation.scala 93:23:@181.4]
  wire [15:0] fifo6_5_io_dataIn; // @[Dilation.scala 93:23:@181.4]
  wire [15:0] fifo6_5_io_dataOut; // @[Dilation.scala 93:23:@181.4]
  wire  fifo7_6_clock; // @[Dilation.scala 94:23:@184.4]
  wire  fifo7_6_reset; // @[Dilation.scala 94:23:@184.4]
  wire [15:0] fifo7_6_io_dataIn; // @[Dilation.scala 94:23:@184.4]
  wire [15:0] fifo7_6_io_dataOut; // @[Dilation.scala 94:23:@184.4]
  wire  fifo8_7_clock; // @[Dilation.scala 95:23:@187.4]
  wire  fifo8_7_reset; // @[Dilation.scala 95:23:@187.4]
  wire [15:0] fifo8_7_io_dataIn; // @[Dilation.scala 95:23:@187.4]
  wire [15:0] fifo8_7_io_dataOut; // @[Dilation.scala 95:23:@187.4]
  reg [4:0] value; // @[Counter.scala 26:33:@109.4]
  reg [31:0] _RAND_0;
  reg  value_1; // @[Counter.scala 26:33:@110.4]
  reg [31:0] _RAND_1;
  reg [5:0] value_2; // @[Counter.scala 26:33:@111.4]
  reg [31:0] _RAND_2;
  reg [2:0] value_3; // @[Counter.scala 26:33:@112.4]
  reg [31:0] _RAND_3;
  reg  computationStarted; // @[Dilation.scala 46:35:@113.4]
  reg [31:0] _RAND_4;
  reg  processWrapped; // @[Dilation.scala 47:31:@114.4]
  reg [31:0] _RAND_5;
  reg  computationEnded; // @[Dilation.scala 48:33:@115.4]
  reg [31:0] _RAND_6;
  wire  _T_37; // @[Counter.scala 34:24:@116.4]
  wire [5:0] _T_39; // @[Counter.scala 35:22:@117.4]
  wire [4:0] _T_40; // @[Counter.scala 35:22:@118.4]
  wire [4:0] _GEN_0; // @[Counter.scala 37:21:@120.4]
  wire  _GEN_1; // @[Dilation.scala 50:28:@123.4]
  wire  _T_46; // @[Dilation.scala 56:25:@128.6]
  wire  _T_48; // @[Counter.scala 34:24:@130.8]
  wire [3:0] _T_50; // @[Counter.scala 35:22:@131.8]
  wire [2:0] _T_51; // @[Counter.scala 35:22:@132.8]
  wire  _GEN_2; // @[Dilation.scala 57:34:@134.8]
  wire [1:0] _T_56; // @[Counter.scala 35:22:@140.8]
  wire  _T_57; // @[Counter.scala 35:22:@141.8]
  wire  _GEN_3; // @[Dilation.scala 61:31:@143.8]
  wire [2:0] _GEN_4; // @[Dilation.scala 56:34:@129.6]
  wire  _GEN_5; // @[Dilation.scala 56:34:@129.6]
  wire  _GEN_6; // @[Dilation.scala 56:34:@129.6]
  wire [2:0] _GEN_7; // @[Dilation.scala 54:36:@127.4]
  wire  _GEN_8; // @[Dilation.scala 54:36:@127.4]
  wire  _GEN_9; // @[Dilation.scala 54:36:@127.4]
  wire  _T_63; // @[Dilation.scala 66:31:@150.4]
  wire  _T_65; // @[Dilation.scala 66:81:@151.4]
  wire  _T_66; // @[Dilation.scala 66:61:@152.4]
  wire  _T_68; // @[Counter.scala 34:24:@154.6]
  wire [6:0] _T_70; // @[Counter.scala 35:22:@155.6]
  wire [5:0] _T_71; // @[Counter.scala 35:22:@156.6]
  wire  _GEN_10; // @[Dilation.scala 67:29:@158.6]
  wire [5:0] _GEN_11; // @[Dilation.scala 66:90:@153.4]
  wire  _GEN_12; // @[Dilation.scala 66:90:@153.4]
  reg [15:0] kernel_0; // @[Dilation.scala 110:25:@198.4]
  reg [31:0] _RAND_7;
  reg [15:0] kernel_1; // @[Dilation.scala 111:25:@199.4]
  reg [31:0] _RAND_8;
  reg [15:0] kernel_2; // @[Dilation.scala 112:25:@200.4]
  reg [31:0] _RAND_9;
  reg [15:0] kernel_3; // @[Dilation.scala 113:25:@201.4]
  reg [31:0] _RAND_10;
  reg [15:0] kernel_4; // @[Dilation.scala 114:25:@202.4]
  reg [31:0] _RAND_11;
  reg [15:0] kernel_5; // @[Dilation.scala 115:25:@203.4]
  reg [31:0] _RAND_12;
  reg [15:0] kernel_6; // @[Dilation.scala 116:25:@204.4]
  reg [31:0] _RAND_13;
  reg [15:0] kernel_7; // @[Dilation.scala 117:25:@205.4]
  reg [31:0] _RAND_14;
  reg [15:0] kernel_8; // @[Dilation.scala 118:25:@206.4]
  reg [31:0] _RAND_15;
  wire [31:0] _T_93; // @[Dilation.scala 136:25:@207.4]
  wire [31:0] _T_94; // @[Dilation.scala 137:34:@209.4]
  wire [31:0] _T_95; // @[Dilation.scala 138:34:@211.4]
  wire [31:0] _T_96; // @[Dilation.scala 139:34:@213.4]
  wire [31:0] _T_97; // @[Dilation.scala 140:34:@215.4]
  wire [31:0] _T_98; // @[Dilation.scala 141:34:@217.4]
  wire [31:0] _T_99; // @[Dilation.scala 142:34:@219.4]
  wire [31:0] _T_100; // @[Dilation.scala 143:34:@221.4]
  wire [31:0] _T_101; // @[Dilation.scala 144:34:@223.4]
  wire [16:0] _T_102; // @[Dilation.scala 149:16:@226.6]
  wire [15:0] _T_103; // @[Dilation.scala 149:16:@227.6]
  wire [15:0] _T_104; // @[Dilation.scala 149:16:@228.6]
  wire [16:0] _T_105; // @[Dilation.scala 150:18:@229.6]
  wire [15:0] _T_106; // @[Dilation.scala 150:18:@230.6]
  wire [15:0] _T_107; // @[Dilation.scala 150:18:@231.6]
  wire [16:0] _T_108; // @[Dilation.scala 151:18:@232.6]
  wire [15:0] _T_109; // @[Dilation.scala 151:18:@233.6]
  wire [15:0] _T_110; // @[Dilation.scala 151:18:@234.6]
  wire [16:0] _T_111; // @[Dilation.scala 152:18:@235.6]
  wire [15:0] _T_112; // @[Dilation.scala 152:18:@236.6]
  wire [15:0] _T_113; // @[Dilation.scala 152:18:@237.6]
  wire [16:0] _T_114; // @[Dilation.scala 153:18:@238.6]
  wire [15:0] _T_115; // @[Dilation.scala 153:18:@239.6]
  wire [15:0] _T_116; // @[Dilation.scala 153:18:@240.6]
  wire [16:0] _T_117; // @[Dilation.scala 154:18:@241.6]
  wire [15:0] _T_118; // @[Dilation.scala 154:18:@242.6]
  wire [15:0] _T_119; // @[Dilation.scala 154:18:@243.6]
  wire [16:0] _T_120; // @[Dilation.scala 155:18:@244.6]
  wire [15:0] _T_121; // @[Dilation.scala 155:18:@245.6]
  wire [15:0] _T_122; // @[Dilation.scala 155:18:@246.6]
  wire [16:0] _T_123; // @[Dilation.scala 156:18:@247.6]
  wire [15:0] _T_124; // @[Dilation.scala 156:18:@248.6]
  wire [15:0] _T_125; // @[Dilation.scala 156:18:@249.6]
  wire [15:0] _T_126; // @[Dilation.scala 157:25:@250.6]
  wire [23:0] _GEN_15; // @[Dilation.scala 144:12:@224.4]
  wire [15:0] _GEN_16; // @[Dilation.scala 144:12:@224.4]
  wire [23:0] _GEN_17; // @[Dilation.scala 143:12:@222.4]
  wire [15:0] _GEN_18; // @[Dilation.scala 143:12:@222.4]
  wire [23:0] _GEN_19; // @[Dilation.scala 142:12:@220.4]
  wire [15:0] _GEN_20; // @[Dilation.scala 142:12:@220.4]
  wire [23:0] _GEN_21; // @[Dilation.scala 141:12:@218.4]
  wire [15:0] _GEN_22; // @[Dilation.scala 141:12:@218.4]
  wire [23:0] _GEN_23; // @[Dilation.scala 140:12:@216.4]
  wire [15:0] _GEN_24; // @[Dilation.scala 140:12:@216.4]
  wire [23:0] _GEN_25; // @[Dilation.scala 139:12:@214.4]
  wire [15:0] _GEN_26; // @[Dilation.scala 139:12:@214.4]
  wire [23:0] _GEN_27; // @[Dilation.scala 138:12:@212.4]
  wire [15:0] _GEN_28; // @[Dilation.scala 138:12:@212.4]
  wire [23:0] _GEN_29; // @[Dilation.scala 137:12:@210.4]
  wire [15:0] _GEN_30; // @[Dilation.scala 137:12:@210.4]
  wire [23:0] _GEN_31; // @[Dilation.scala 136:12:@208.4]
  wire [15:0] _GEN_32; // @[Dilation.scala 136:12:@208.4]
  FIFO fifo1_0 ( // @[Dilation.scala 88:23:@166.4]
    .clock(fifo1_0_clock),
    .reset(fifo1_0_reset),
    .io_dataIn(fifo1_0_io_dataIn),
    .io_dataOut(fifo1_0_io_dataOut)
  );
  FIFO fifo2_1 ( // @[Dilation.scala 89:23:@169.4]
    .clock(fifo2_1_clock),
    .reset(fifo2_1_reset),
    .io_dataIn(fifo2_1_io_dataIn),
    .io_dataOut(fifo2_1_io_dataOut)
  );
  FIFO_2 fifo3_2 ( // @[Dilation.scala 90:23:@172.4]
    .clock(fifo3_2_clock),
    .reset(fifo3_2_reset),
    .io_dataIn(fifo3_2_io_dataIn),
    .io_dataOut(fifo3_2_io_dataOut)
  );
  FIFO fifo4_3 ( // @[Dilation.scala 91:23:@175.4]
    .clock(fifo4_3_clock),
    .reset(fifo4_3_reset),
    .io_dataIn(fifo4_3_io_dataIn),
    .io_dataOut(fifo4_3_io_dataOut)
  );
  FIFO fifo5_4 ( // @[Dilation.scala 92:23:@178.4]
    .clock(fifo5_4_clock),
    .reset(fifo5_4_reset),
    .io_dataIn(fifo5_4_io_dataIn),
    .io_dataOut(fifo5_4_io_dataOut)
  );
  FIFO_2 fifo6_5 ( // @[Dilation.scala 93:23:@181.4]
    .clock(fifo6_5_clock),
    .reset(fifo6_5_reset),
    .io_dataIn(fifo6_5_io_dataIn),
    .io_dataOut(fifo6_5_io_dataOut)
  );
  FIFO fifo7_6 ( // @[Dilation.scala 94:23:@184.4]
    .clock(fifo7_6_clock),
    .reset(fifo7_6_reset),
    .io_dataIn(fifo7_6_io_dataIn),
    .io_dataOut(fifo7_6_io_dataOut)
  );
  FIFO fifo8_7 ( // @[Dilation.scala 95:23:@187.4]
    .clock(fifo8_7_clock),
    .reset(fifo8_7_reset),
    .io_dataIn(fifo8_7_io_dataIn),
    .io_dataOut(fifo8_7_io_dataOut)
  );
  assign _T_37 = value == 5'h15; // @[Counter.scala 34:24:@116.4]
  assign _T_39 = value + 5'h1; // @[Counter.scala 35:22:@117.4]
  assign _T_40 = _T_39[4:0]; // @[Counter.scala 35:22:@118.4]
  assign _GEN_0 = _T_37 ? 5'h0 : _T_40; // @[Counter.scala 37:21:@120.4]
  assign _GEN_1 = _T_37 ? 1'h1 : computationStarted; // @[Dilation.scala 50:28:@123.4]
  assign _T_46 = processWrapped == 1'h0; // @[Dilation.scala 56:25:@128.6]
  assign _T_48 = value_3 == 3'h7; // @[Counter.scala 34:24:@130.8]
  assign _T_50 = value_3 + 3'h1; // @[Counter.scala 35:22:@131.8]
  assign _T_51 = _T_50[2:0]; // @[Counter.scala 35:22:@132.8]
  assign _GEN_2 = _T_48 ? 1'h1 : processWrapped; // @[Dilation.scala 57:34:@134.8]
  assign _T_56 = value_1 + 1'h1; // @[Counter.scala 35:22:@140.8]
  assign _T_57 = _T_56[0:0]; // @[Counter.scala 35:22:@141.8]
  assign _GEN_3 = value_1 ? 1'h0 : processWrapped; // @[Dilation.scala 61:31:@143.8]
  assign _GEN_4 = _T_46 ? _T_51 : value_3; // @[Dilation.scala 56:34:@129.6]
  assign _GEN_5 = _T_46 ? _GEN_2 : _GEN_3; // @[Dilation.scala 56:34:@129.6]
  assign _GEN_6 = _T_46 ? value_1 : _T_57; // @[Dilation.scala 56:34:@129.6]
  assign _GEN_7 = computationStarted ? _GEN_4 : value_3; // @[Dilation.scala 54:36:@127.4]
  assign _GEN_8 = computationStarted ? _GEN_5 : processWrapped; // @[Dilation.scala 54:36:@127.4]
  assign _GEN_9 = computationStarted ? _GEN_6 : value_1; // @[Dilation.scala 54:36:@127.4]
  assign _T_63 = _T_46 & computationStarted; // @[Dilation.scala 66:31:@150.4]
  assign _T_65 = computationEnded == 1'h0; // @[Dilation.scala 66:81:@151.4]
  assign _T_66 = _T_63 & _T_65; // @[Dilation.scala 66:61:@152.4]
  assign _T_68 = value_2 == 6'h3f; // @[Counter.scala 34:24:@154.6]
  assign _T_70 = value_2 + 6'h1; // @[Counter.scala 35:22:@155.6]
  assign _T_71 = _T_70[5:0]; // @[Counter.scala 35:22:@156.6]
  assign _GEN_10 = _T_68 ? 1'h1 : computationEnded; // @[Dilation.scala 67:29:@158.6]
  assign _GEN_11 = _T_66 ? _T_71 : value_2; // @[Dilation.scala 66:90:@153.4]
  assign _GEN_12 = _T_66 ? _GEN_10 : computationEnded; // @[Dilation.scala 66:90:@153.4]
  assign _T_93 = $signed(io_dataIn) * $signed(16'sh0); // @[Dilation.scala 136:25:@207.4]
  assign _T_94 = $signed(fifo8_7_io_dataOut) * $signed(16'sh100); // @[Dilation.scala 137:34:@209.4]
  assign _T_95 = $signed(fifo7_6_io_dataOut) * $signed(16'sh0); // @[Dilation.scala 138:34:@211.4]
  assign _T_96 = $signed(fifo6_5_io_dataOut) * $signed(16'sh100); // @[Dilation.scala 139:34:@213.4]
  assign _T_97 = $signed(fifo5_4_io_dataOut) * $signed(16'sh100); // @[Dilation.scala 140:34:@215.4]
  assign _T_98 = $signed(fifo4_3_io_dataOut) * $signed(16'sh100); // @[Dilation.scala 141:34:@217.4]
  assign _T_99 = $signed(fifo3_2_io_dataOut) * $signed(16'sh0); // @[Dilation.scala 142:34:@219.4]
  assign _T_100 = $signed(fifo2_1_io_dataOut) * $signed(16'sh100); // @[Dilation.scala 143:34:@221.4]
  assign _T_101 = $signed(fifo1_0_io_dataOut) * $signed(16'sh0); // @[Dilation.scala 144:34:@223.4]
  assign _T_102 = $signed(kernel_0) + $signed(kernel_1); // @[Dilation.scala 149:16:@226.6]
  assign _T_103 = _T_102[15:0]; // @[Dilation.scala 149:16:@227.6]
  assign _T_104 = $signed(_T_103); // @[Dilation.scala 149:16:@228.6]
  assign _T_105 = $signed(_T_104) + $signed(kernel_2); // @[Dilation.scala 150:18:@229.6]
  assign _T_106 = _T_105[15:0]; // @[Dilation.scala 150:18:@230.6]
  assign _T_107 = $signed(_T_106); // @[Dilation.scala 150:18:@231.6]
  assign _T_108 = $signed(_T_107) + $signed(kernel_3); // @[Dilation.scala 151:18:@232.6]
  assign _T_109 = _T_108[15:0]; // @[Dilation.scala 151:18:@233.6]
  assign _T_110 = $signed(_T_109); // @[Dilation.scala 151:18:@234.6]
  assign _T_111 = $signed(_T_110) + $signed(kernel_4); // @[Dilation.scala 152:18:@235.6]
  assign _T_112 = _T_111[15:0]; // @[Dilation.scala 152:18:@236.6]
  assign _T_113 = $signed(_T_112); // @[Dilation.scala 152:18:@237.6]
  assign _T_114 = $signed(_T_113) + $signed(kernel_5); // @[Dilation.scala 153:18:@238.6]
  assign _T_115 = _T_114[15:0]; // @[Dilation.scala 153:18:@239.6]
  assign _T_116 = $signed(_T_115); // @[Dilation.scala 153:18:@240.6]
  assign _T_117 = $signed(_T_116) + $signed(kernel_6); // @[Dilation.scala 154:18:@241.6]
  assign _T_118 = _T_117[15:0]; // @[Dilation.scala 154:18:@242.6]
  assign _T_119 = $signed(_T_118); // @[Dilation.scala 154:18:@243.6]
  assign _T_120 = $signed(_T_119) + $signed(kernel_7); // @[Dilation.scala 155:18:@244.6]
  assign _T_121 = _T_120[15:0]; // @[Dilation.scala 155:18:@245.6]
  assign _T_122 = $signed(_T_121); // @[Dilation.scala 155:18:@246.6]
  assign _T_123 = $signed(_T_122) + $signed(kernel_8); // @[Dilation.scala 156:18:@247.6]
  assign _T_124 = _T_123[15:0]; // @[Dilation.scala 156:18:@248.6]
  assign _T_125 = $signed(_T_124); // @[Dilation.scala 156:18:@249.6]
  assign _T_126 = $unsigned(_T_125); // @[Dilation.scala 157:25:@250.6]
  assign io_tdata = io_tready ? _T_126 : 16'h0; // @[Dilation.scala 31:12:@107.4 Dilation.scala 148:14:@251.6]
  assign io_tvalid = _T_63 & _T_65; // @[Dilation.scala 32:13:@108.4 Dilation.scala 70:15:@161.6 Dilation.scala 72:15:@164.6]
  assign io_tlast = 1'h0; // @[Dilation.scala 30:12:@106.4]
  assign io_tkeep = 4'h1; // @[Dilation.scala 29:12:@105.4]
  assign fifo1_0_clock = clock; // @[:@167.4]
  assign fifo1_0_reset = reset; // @[:@168.4]
  assign fifo1_0_io_dataIn = fifo2_1_io_dataOut; // @[Dilation.scala 106:21:@197.4]
  assign fifo2_1_clock = clock; // @[:@170.4]
  assign fifo2_1_reset = reset; // @[:@171.4]
  assign fifo2_1_io_dataIn = fifo3_2_io_dataOut; // @[Dilation.scala 105:21:@196.4]
  assign fifo3_2_clock = clock; // @[:@173.4]
  assign fifo3_2_reset = reset; // @[:@174.4]
  assign fifo3_2_io_dataIn = fifo4_3_io_dataOut; // @[Dilation.scala 104:21:@195.4]
  assign fifo4_3_clock = clock; // @[:@176.4]
  assign fifo4_3_reset = reset; // @[:@177.4]
  assign fifo4_3_io_dataIn = fifo5_4_io_dataOut; // @[Dilation.scala 103:21:@194.4]
  assign fifo5_4_clock = clock; // @[:@179.4]
  assign fifo5_4_reset = reset; // @[:@180.4]
  assign fifo5_4_io_dataIn = fifo6_5_io_dataOut; // @[Dilation.scala 102:21:@193.4]
  assign fifo6_5_clock = clock; // @[:@182.4]
  assign fifo6_5_reset = reset; // @[:@183.4]
  assign fifo6_5_io_dataIn = fifo7_6_io_dataOut; // @[Dilation.scala 101:21:@192.4]
  assign fifo7_6_clock = clock; // @[:@185.4]
  assign fifo7_6_reset = reset; // @[:@186.4]
  assign fifo7_6_io_dataIn = fifo8_7_io_dataOut; // @[Dilation.scala 100:21:@191.4]
  assign fifo8_7_clock = clock; // @[:@188.4]
  assign fifo8_7_reset = reset; // @[:@189.4]
  assign fifo8_7_io_dataIn = io_dataIn; // @[Dilation.scala 99:21:@190.4]
  assign _GEN_15 = _T_101[31:8]; // @[Dilation.scala 144:12:@224.4]
  assign _GEN_16 = _GEN_15[15:0]; // @[Dilation.scala 144:12:@224.4]
  assign _GEN_17 = _T_100[31:8]; // @[Dilation.scala 143:12:@222.4]
  assign _GEN_18 = _GEN_17[15:0]; // @[Dilation.scala 143:12:@222.4]
  assign _GEN_19 = _T_99[31:8]; // @[Dilation.scala 142:12:@220.4]
  assign _GEN_20 = _GEN_19[15:0]; // @[Dilation.scala 142:12:@220.4]
  assign _GEN_21 = _T_98[31:8]; // @[Dilation.scala 141:12:@218.4]
  assign _GEN_22 = _GEN_21[15:0]; // @[Dilation.scala 141:12:@218.4]
  assign _GEN_23 = _T_97[31:8]; // @[Dilation.scala 140:12:@216.4]
  assign _GEN_24 = _GEN_23[15:0]; // @[Dilation.scala 140:12:@216.4]
  assign _GEN_25 = _T_96[31:8]; // @[Dilation.scala 139:12:@214.4]
  assign _GEN_26 = _GEN_25[15:0]; // @[Dilation.scala 139:12:@214.4]
  assign _GEN_27 = _T_95[31:8]; // @[Dilation.scala 138:12:@212.4]
  assign _GEN_28 = _GEN_27[15:0]; // @[Dilation.scala 138:12:@212.4]
  assign _GEN_29 = _T_94[31:8]; // @[Dilation.scala 137:12:@210.4]
  assign _GEN_30 = _GEN_29[15:0]; // @[Dilation.scala 137:12:@210.4]
  assign _GEN_31 = _T_93[31:8]; // @[Dilation.scala 136:12:@208.4]
  assign _GEN_32 = _GEN_31[15:0]; // @[Dilation.scala 136:12:@208.4]
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
      if (_T_37) begin
        value <= 5'h0;
      end else begin
        value <= _T_40;
      end
    end
    if (reset) begin
      value_1 <= 1'h0;
    end else begin
      if (computationStarted) begin
        if (!(_T_46)) begin
          value_1 <= _T_57;
        end
      end
    end
    if (reset) begin
      value_2 <= 6'h0;
    end else begin
      if (_T_66) begin
        value_2 <= _T_71;
      end
    end
    if (reset) begin
      value_3 <= 3'h0;
    end else begin
      if (computationStarted) begin
        if (_T_46) begin
          value_3 <= _T_51;
        end
      end
    end
    if (reset) begin
      computationStarted <= 1'h0;
    end else begin
      if (_T_37) begin
        computationStarted <= 1'h1;
      end
    end
    if (reset) begin
      processWrapped <= 1'h0;
    end else begin
      if (computationStarted) begin
        if (_T_46) begin
          if (_T_48) begin
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
      if (_T_66) begin
        if (_T_68) begin
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
