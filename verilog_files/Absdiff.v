module Absdiff( // @[:@3.2]
  input        clock, // @[:@4.4]
  input        reset, // @[:@5.4]
  input        io_lastIn, // @[:@6.4]
  input  [7:0] io_dataIn, // @[:@6.4]
  input        io_tvalidIn, // @[:@6.4]
  output [7:0] io_tdata, // @[:@6.4]
  output       io_tvalidOut, // @[:@6.4]
  output       io_treadyOut // @[:@6.4]
);
  reg [31:0] memory [0:75683]; // @[Absdiff.scala 43:19:@12.4]
  reg [31:0] _RAND_0;
  wire [31:0] memory__T_27_data; // @[Absdiff.scala 43:19:@12.4]
  wire [16:0] memory__T_27_addr; // @[Absdiff.scala 43:19:@12.4]
  reg [31:0] _RAND_1;
  wire [31:0] memory__T_26_data; // @[Absdiff.scala 43:19:@12.4]
  wire [16:0] memory__T_26_addr; // @[Absdiff.scala 43:19:@12.4]
  wire  memory__T_26_mask; // @[Absdiff.scala 43:19:@12.4]
  wire  memory__T_26_en; // @[Absdiff.scala 43:19:@12.4]
  reg [7:0] result; // @[Absdiff.scala 33:23:@8.4]
  reg [31:0] _RAND_2;
  reg  startCalculating; // @[Absdiff.scala 37:33:@10.4]
  reg [31:0] _RAND_3;
  reg [16:0] value; // @[Counter.scala 26:33:@11.4]
  reg [31:0] _RAND_4;
  wire [31:0] dataOut; // @[Absdiff.scala 34:21:@9.4 Absdiff.scala 45:11:@16.4]
  wire [31:0] _GEN_20; // @[Absdiff.scala 57:20:@22.8]
  wire  _T_31; // @[Absdiff.scala 57:20:@22.8]
  wire [32:0] _T_32; // @[Absdiff.scala 58:27:@24.10]
  wire [32:0] _T_33; // @[Absdiff.scala 58:27:@25.10]
  wire [31:0] _T_34; // @[Absdiff.scala 58:27:@26.10]
  wire [32:0] _T_35; // @[Absdiff.scala 60:29:@30.10]
  wire [32:0] _T_36; // @[Absdiff.scala 60:29:@31.10]
  wire [31:0] _T_37; // @[Absdiff.scala 60:29:@32.10]
  wire [31:0] _GEN_0; // @[Absdiff.scala 57:33:@23.8]
  wire [31:0] _GEN_3; // @[Absdiff.scala 56:28:@21.6]
  wire [7:0] _GEN_5; // @[Absdiff.scala 56:28:@21.6]
  wire  _T_46; // @[Absdiff.scala 77:10:@46.6]
  wire  _GEN_6; // @[Absdiff.scala 78:23:@48.8]
  wire  _GEN_7; // @[Absdiff.scala 77:29:@47.6]
  wire  _T_49; // @[Counter.scala 34:24:@52.6]
  wire [17:0] _T_51; // @[Counter.scala 35:22:@53.6]
  wire [16:0] _T_52; // @[Counter.scala 35:22:@54.6]
  wire [16:0] _GEN_8; // @[Counter.scala 37:21:@56.6]
  wire [31:0] _GEN_9; // @[Absdiff.scala 54:21:@20.4]
  wire  _GEN_12; // @[Absdiff.scala 54:21:@20.4]
  wire [16:0] _GEN_13; // @[Absdiff.scala 54:21:@20.4]
  assign memory__T_27_addr = value;
  `ifndef RANDOMIZE_GARBAGE_ASSIGN
  assign memory__T_27_data = memory[memory__T_27_addr]; // @[Absdiff.scala 43:19:@12.4]
  `else
  assign memory__T_27_data = memory__T_27_addr >= 17'h127a4 ? _RAND_1[31:0] : memory[memory__T_27_addr]; // @[Absdiff.scala 43:19:@12.4]
  `endif // RANDOMIZE_GARBAGE_ASSIGN
  assign memory__T_26_data = {{24'd0}, io_dataIn};
  assign memory__T_26_addr = value;
  assign memory__T_26_mask = 1'h1;
  assign memory__T_26_en = 1'h1;
  assign dataOut = memory__T_27_data; // @[Absdiff.scala 34:21:@9.4 Absdiff.scala 45:11:@16.4]
  assign _GEN_20 = {{24'd0}, io_dataIn}; // @[Absdiff.scala 57:20:@22.8]
  assign _T_31 = dataOut > _GEN_20; // @[Absdiff.scala 57:20:@22.8]
  assign _T_32 = dataOut - _GEN_20; // @[Absdiff.scala 58:27:@24.10]
  assign _T_33 = $unsigned(_T_32); // @[Absdiff.scala 58:27:@25.10]
  assign _T_34 = _T_33[31:0]; // @[Absdiff.scala 58:27:@26.10]
  assign _T_35 = _GEN_20 - dataOut; // @[Absdiff.scala 60:29:@30.10]
  assign _T_36 = $unsigned(_T_35); // @[Absdiff.scala 60:29:@31.10]
  assign _T_37 = _T_36[31:0]; // @[Absdiff.scala 60:29:@32.10]
  assign _GEN_0 = _T_31 ? _T_34 : _T_37; // @[Absdiff.scala 57:33:@23.8]
  assign _GEN_3 = startCalculating ? _GEN_0 : {{24'd0}, result}; // @[Absdiff.scala 56:28:@21.6]
  assign _GEN_5 = startCalculating ? result : 8'h0; // @[Absdiff.scala 56:28:@21.6]
  assign _T_46 = startCalculating == 1'h0; // @[Absdiff.scala 77:10:@46.6]
  assign _GEN_6 = io_lastIn ? 1'h1 : startCalculating; // @[Absdiff.scala 78:23:@48.8]
  assign _GEN_7 = _T_46 ? _GEN_6 : startCalculating; // @[Absdiff.scala 77:29:@47.6]
  assign _T_49 = value == 17'h127a3; // @[Counter.scala 34:24:@52.6]
  assign _T_51 = value + 17'h1; // @[Counter.scala 35:22:@53.6]
  assign _T_52 = _T_51[16:0]; // @[Counter.scala 35:22:@54.6]
  assign _GEN_8 = _T_49 ? 17'h0 : _T_52; // @[Counter.scala 37:21:@56.6]
  assign _GEN_9 = io_tvalidIn ? _GEN_3 : {{24'd0}, result}; // @[Absdiff.scala 54:21:@20.4]
  assign _GEN_12 = io_tvalidIn ? _GEN_7 : startCalculating; // @[Absdiff.scala 54:21:@20.4]
  assign _GEN_13 = io_tvalidIn ? _GEN_8 : value; // @[Absdiff.scala 54:21:@20.4]
  assign io_tdata = io_tvalidIn ? _GEN_5 : 8'h0; // @[Absdiff.scala 48:12:@17.4 Absdiff.scala 74:16:@44.8]
  assign io_tvalidOut = io_tvalidIn ? startCalculating : 1'h0; // @[Absdiff.scala 49:16:@18.4 Absdiff.scala 73:20:@43.8]
  assign io_treadyOut = 1'h1; // @[Absdiff.scala 50:16:@19.4]
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
  _RAND_0 = {1{`RANDOM}};
  `ifdef RANDOMIZE_MEM_INIT
  for (initvar = 0; initvar < 75684; initvar = initvar+1)
    memory[initvar] = _RAND_0[31:0];
  `endif // RANDOMIZE_MEM_INIT
  _RAND_1 = {1{`RANDOM}};
  `ifdef RANDOMIZE_REG_INIT
  _RAND_2 = {1{`RANDOM}};
  result = _RAND_2[7:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_3 = {1{`RANDOM}};
  startCalculating = _RAND_3[0:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_4 = {1{`RANDOM}};
  value = _RAND_4[16:0];
  `endif // RANDOMIZE_REG_INIT
  end
`endif // RANDOMIZE
  always @(posedge clock) begin
    if(memory__T_26_en & memory__T_26_mask) begin
      memory[memory__T_26_addr] <= memory__T_26_data; // @[Absdiff.scala 43:19:@12.4]
    end
    if (reset) begin
      result <= 8'h0;
    end else begin
      result <= _GEN_9[7:0];
    end
    if (reset) begin
      startCalculating <= 1'h0;
    end else begin
      if (io_tvalidIn) begin
        if (_T_46) begin
          if (io_lastIn) begin
            startCalculating <= 1'h1;
          end
        end
      end
    end
    if (reset) begin
      value <= 17'h0;
    end else begin
      if (io_tvalidIn) begin
        if (_T_49) begin
          value <= 17'h0;
        end else begin
          value <= _T_52;
        end
      end
    end
  end
endmodule
