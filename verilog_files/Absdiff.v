module Absdiff( // @[:@3.2]
  input        clock, // @[:@4.4]
  input        reset, // @[:@5.4]
  input        io_lastIn, // @[:@6.4]
  input  [7:0] io_dataIn, // @[:@6.4]
  input        io_tvalidIn, // @[:@6.4]
  output [7:0] io_tdata, // @[:@6.4]
  output       io_tvalidOut, // @[:@6.4]
  output       io_treadyOut, // @[:@6.4]
  input        io_treadyIn // @[:@6.4]
);
  reg [31:0] mem [0:304963]; // @[Absdiff.scala 43:24:@10.4]
  reg [31:0] _RAND_0;
  wire [31:0] mem__T_30_data; // @[Absdiff.scala 43:24:@10.4]
  wire [18:0] mem__T_30_addr; // @[Absdiff.scala 43:24:@10.4]
  reg [31:0] _RAND_1;
  wire [31:0] mem__T_32_data; // @[Absdiff.scala 43:24:@10.4]
  wire [18:0] mem__T_32_addr; // @[Absdiff.scala 43:24:@10.4]
  reg [31:0] _RAND_2;
  wire [31:0] mem__T_36_data; // @[Absdiff.scala 43:24:@10.4]
  wire [18:0] mem__T_36_addr; // @[Absdiff.scala 43:24:@10.4]
  reg [31:0] _RAND_3;
  wire [31:0] mem__T_50_data; // @[Absdiff.scala 43:24:@10.4]
  wire [18:0] mem__T_50_addr; // @[Absdiff.scala 43:24:@10.4]
  wire  mem__T_50_mask; // @[Absdiff.scala 43:24:@10.4]
  wire  mem__T_50_en; // @[Absdiff.scala 43:24:@10.4]
  reg [7:0] result; // @[Absdiff.scala 35:23:@8.4]
  reg [31:0] _RAND_4;
  reg  startCalculating; // @[Absdiff.scala 38:33:@9.4]
  reg [31:0] _RAND_5;
  reg [18:0] value; // @[Counter.scala 26:33:@11.4]
  reg [31:0] _RAND_6;
  wire [31:0] _GEN_47; // @[Absdiff.scala 57:33:@18.8]
  wire  _T_31; // @[Absdiff.scala 57:33:@18.8]
  wire [32:0] _T_33; // @[Absdiff.scala 58:40:@21.10]
  wire [32:0] _T_34; // @[Absdiff.scala 58:40:@22.10]
  wire [31:0] _T_35; // @[Absdiff.scala 58:40:@23.10]
  wire [32:0] _T_37; // @[Absdiff.scala 60:29:@28.10]
  wire [32:0] _T_38; // @[Absdiff.scala 60:29:@29.10]
  wire [31:0] _T_39; // @[Absdiff.scala 60:29:@30.10]
  wire [31:0] _GEN_2; // @[Absdiff.scala 57:46:@19.8]
  wire  _T_41; // @[Absdiff.scala 65:19:@33.8]
  wire [31:0] _GEN_11; // @[Absdiff.scala 56:28:@16.6]
  wire [7:0] _GEN_15; // @[Absdiff.scala 56:28:@16.6]
  wire  _T_48; // @[Absdiff.scala 77:10:@44.6]
  wire  _GEN_16; // @[Absdiff.scala 78:23:@46.8]
  wire  _GEN_17; // @[Absdiff.scala 77:29:@45.6]
  wire  _T_52; // @[Counter.scala 34:24:@52.6]
  wire [19:0] _T_54; // @[Counter.scala 35:22:@53.6]
  wire [18:0] _T_55; // @[Counter.scala 35:22:@54.6]
  wire [18:0] _GEN_18; // @[Counter.scala 37:21:@56.6]
  wire [31:0] _GEN_24; // @[Absdiff.scala 54:21:@15.4]
  wire  _GEN_29; // @[Absdiff.scala 54:21:@15.4]
  wire  _GEN_32; // @[Absdiff.scala 54:21:@15.4]
  wire [18:0] _GEN_35; // @[Absdiff.scala 54:21:@15.4]
  reg [18:0] mem__T_30_addr_pipe_0;
  reg [31:0] _RAND_7;
  reg [18:0] mem__T_32_addr_pipe_0;
  reg [31:0] _RAND_8;
  reg [18:0] mem__T_36_addr_pipe_0;
  reg [31:0] _RAND_9;
  assign mem__T_30_addr = mem__T_30_addr_pipe_0;
  `ifndef RANDOMIZE_GARBAGE_ASSIGN
  assign mem__T_30_data = mem[mem__T_30_addr]; // @[Absdiff.scala 43:24:@10.4]
  `else
  assign mem__T_30_data = mem__T_30_addr >= 19'h4a744 ? _RAND_1[31:0] : mem[mem__T_30_addr]; // @[Absdiff.scala 43:24:@10.4]
  `endif // RANDOMIZE_GARBAGE_ASSIGN
  assign mem__T_32_addr = mem__T_32_addr_pipe_0;
  `ifndef RANDOMIZE_GARBAGE_ASSIGN
  assign mem__T_32_data = mem[mem__T_32_addr]; // @[Absdiff.scala 43:24:@10.4]
  `else
  assign mem__T_32_data = mem__T_32_addr >= 19'h4a744 ? _RAND_2[31:0] : mem[mem__T_32_addr]; // @[Absdiff.scala 43:24:@10.4]
  `endif // RANDOMIZE_GARBAGE_ASSIGN
  assign mem__T_36_addr = mem__T_36_addr_pipe_0;
  `ifndef RANDOMIZE_GARBAGE_ASSIGN
  assign mem__T_36_data = mem[mem__T_36_addr]; // @[Absdiff.scala 43:24:@10.4]
  `else
  assign mem__T_36_data = mem__T_36_addr >= 19'h4a744 ? _RAND_3[31:0] : mem[mem__T_36_addr]; // @[Absdiff.scala 43:24:@10.4]
  `endif // RANDOMIZE_GARBAGE_ASSIGN
  assign mem__T_50_data = {{24'd0}, io_dataIn};
  assign mem__T_50_addr = value;
  assign mem__T_50_mask = 1'h1;
  assign mem__T_50_en = io_tvalidIn;
  assign _GEN_47 = {{24'd0}, io_dataIn}; // @[Absdiff.scala 57:33:@18.8]
  assign _T_31 = mem__T_30_data > _GEN_47; // @[Absdiff.scala 57:33:@18.8]
  assign _T_33 = mem__T_32_data - _GEN_47; // @[Absdiff.scala 58:40:@21.10]
  assign _T_34 = $unsigned(_T_33); // @[Absdiff.scala 58:40:@22.10]
  assign _T_35 = _T_34[31:0]; // @[Absdiff.scala 58:40:@23.10]
  assign _T_37 = _GEN_47 - mem__T_36_data; // @[Absdiff.scala 60:29:@28.10]
  assign _T_38 = $unsigned(_T_37); // @[Absdiff.scala 60:29:@29.10]
  assign _T_39 = _T_38[31:0]; // @[Absdiff.scala 60:29:@30.10]
  assign _GEN_2 = _T_31 ? _T_35 : _T_39; // @[Absdiff.scala 57:46:@19.8]
  assign _T_41 = 1'h0; // @[Absdiff.scala 65:19:@33.8]
  assign _GEN_11 = startCalculating ? _GEN_2 : {{24'd0}, result}; // @[Absdiff.scala 56:28:@16.6]
  assign _GEN_15 = startCalculating ? result : 8'h0; // @[Absdiff.scala 56:28:@16.6]
  assign _T_48 = startCalculating == 1'h0; // @[Absdiff.scala 77:10:@44.6]
  assign _GEN_16 = io_lastIn ? 1'h1 : startCalculating; // @[Absdiff.scala 78:23:@46.8]
  assign _GEN_17 = _T_48 ? _GEN_16 : startCalculating; // @[Absdiff.scala 77:29:@45.6]
  assign _T_52 = value == 19'h4a743; // @[Counter.scala 34:24:@52.6]
  assign _T_54 = value + 19'h1; // @[Counter.scala 35:22:@53.6]
  assign _T_55 = _T_54[18:0]; // @[Counter.scala 35:22:@54.6]
  assign _GEN_18 = _T_52 ? 19'h0 : _T_55; // @[Counter.scala 37:21:@56.6]
  assign _GEN_24 = io_tvalidIn ? _GEN_11 : {{24'd0}, result}; // @[Absdiff.scala 54:21:@15.4]
  assign _GEN_29 = io_tvalidIn ? _GEN_17 : startCalculating; // @[Absdiff.scala 54:21:@15.4]
  assign _GEN_32 = io_tvalidIn; // @[Absdiff.scala 54:21:@15.4]
  assign _GEN_35 = io_tvalidIn ? _GEN_18 : value; // @[Absdiff.scala 54:21:@15.4]
  assign io_tdata = io_tvalidIn ? _GEN_15 : 8'h0; // @[Absdiff.scala 47:12:@12.4 Absdiff.scala 74:16:@42.8]
  assign io_tvalidOut = io_tvalidIn ? startCalculating : 1'h0; // @[Absdiff.scala 48:16:@13.4 Absdiff.scala 73:20:@41.8]
  assign io_treadyOut = 1'h1; // @[Absdiff.scala 49:16:@14.4]
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
  for (initvar = 0; initvar < 304964; initvar = initvar+1)
    mem[initvar] = _RAND_0[31:0];
  `endif // RANDOMIZE_MEM_INIT
  _RAND_1 = {1{`RANDOM}};
  _RAND_2 = {1{`RANDOM}};
  _RAND_3 = {1{`RANDOM}};
  `ifdef RANDOMIZE_REG_INIT
  _RAND_4 = {1{`RANDOM}};
  result = _RAND_4[7:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_5 = {1{`RANDOM}};
  startCalculating = _RAND_5[0:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_6 = {1{`RANDOM}};
  value = _RAND_6[18:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_7 = {1{`RANDOM}};
  mem__T_30_addr_pipe_0 = _RAND_7[18:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_8 = {1{`RANDOM}};
  mem__T_32_addr_pipe_0 = _RAND_8[18:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_9 = {1{`RANDOM}};
  mem__T_36_addr_pipe_0 = _RAND_9[18:0];
  `endif // RANDOMIZE_REG_INIT
  end
`endif // RANDOMIZE
  always @(posedge clock) begin
    if(mem__T_50_en & mem__T_50_mask) begin
      mem[mem__T_50_addr] <= mem__T_50_data; // @[Absdiff.scala 43:24:@10.4]
    end
    if (reset) begin
      result <= 8'h0;
    end else begin
      result <= _GEN_24[7:0];
    end
    if (reset) begin
      startCalculating <= 1'h0;
    end else begin
      if (io_tvalidIn) begin
        if (_T_48) begin
          if (io_lastIn) begin
            startCalculating <= 1'h1;
          end
        end
      end
    end
    if (reset) begin
      value <= 19'h0;
    end else begin
      if (io_tvalidIn) begin
        if (_T_52) begin
          value <= 19'h0;
        end else begin
          value <= _T_55;
        end
      end
    end
    if (_T_41) begin
      mem__T_30_addr_pipe_0 <= value;
    end
    if (_T_41) begin
      mem__T_32_addr_pipe_0 <= value;
    end
    if (_GEN_32) begin
      mem__T_36_addr_pipe_0 <= value;
    end
  end
endmodule
