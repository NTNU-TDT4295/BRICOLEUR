module DummyDataGeneratorAXI( // @[:@3.2]
  input         clock, // @[:@4.4]
  input         reset, // @[:@5.4]
  input         io_tready, // @[:@6.4]
  output        io_tvalid, // @[:@6.4]
  output        io_tlast, // @[:@6.4]
  output [15:0] io_tdata, // @[:@6.4]
  output [3:0]  io_tkeep // @[:@6.4]
);
  reg [15:0] data; // @[DummyDataGeneratorAXI.scala 22:21:@12.4]
  reg [31:0] _RAND_0;
  reg [7:0] counter; // @[DummyDataGeneratorAXI.scala 23:24:@13.4]
  reg [31:0] _RAND_1;
  reg  isReady; // @[DummyDataGeneratorAXI.scala 24:24:@14.4]
  reg [31:0] _RAND_2;
  wire  _T_28; // @[DummyDataGeneratorAXI.scala 29:18:@18.6]
  wire [8:0] _T_31; // @[DummyDataGeneratorAXI.scala 31:26:@21.8]
  wire [7:0] _T_32; // @[DummyDataGeneratorAXI.scala 31:26:@22.8]
  wire [15:0] _GEN_0; // @[DummyDataGeneratorAXI.scala 29:27:@19.6]
  wire [7:0] _GEN_1; // @[DummyDataGeneratorAXI.scala 29:27:@19.6]
  wire  _T_34; // @[DummyDataGeneratorAXI.scala 33:18:@25.6]
  wire [15:0] _GEN_2; // @[DummyDataGeneratorAXI.scala 33:26:@26.6]
  wire [7:0] _GEN_3; // @[DummyDataGeneratorAXI.scala 33:26:@26.6]
  wire  _T_40; // @[DummyDataGeneratorAXI.scala 37:18:@32.6]
  wire [15:0] _GEN_4; // @[DummyDataGeneratorAXI.scala 37:26:@33.6]
  wire [7:0] _GEN_5; // @[DummyDataGeneratorAXI.scala 37:26:@33.6]
  wire [15:0] _GEN_6; // @[DummyDataGeneratorAXI.scala 28:25:@17.4]
  wire [7:0] _GEN_7; // @[DummyDataGeneratorAXI.scala 28:25:@17.4]
  wire  _GEN_8; // @[DummyDataGeneratorAXI.scala 42:18:@38.4]
  assign _T_28 = counter == 8'h1; // @[DummyDataGeneratorAXI.scala 29:18:@18.6]
  assign _T_31 = counter + 8'h1; // @[DummyDataGeneratorAXI.scala 31:26:@21.8]
  assign _T_32 = _T_31[7:0]; // @[DummyDataGeneratorAXI.scala 31:26:@22.8]
  assign _GEN_0 = _T_28 ? $signed(16'sha00) : $signed(data); // @[DummyDataGeneratorAXI.scala 29:27:@19.6]
  assign _GEN_1 = _T_28 ? _T_32 : counter; // @[DummyDataGeneratorAXI.scala 29:27:@19.6]
  assign _T_34 = counter == 8'h2; // @[DummyDataGeneratorAXI.scala 33:18:@25.6]
  assign _GEN_2 = _T_34 ? $signed(16'sh1400) : $signed(_GEN_0); // @[DummyDataGeneratorAXI.scala 33:26:@26.6]
  assign _GEN_3 = _T_34 ? _T_32 : _GEN_1; // @[DummyDataGeneratorAXI.scala 33:26:@26.6]
  assign _T_40 = counter == 8'h3; // @[DummyDataGeneratorAXI.scala 37:18:@32.6]
  assign _GEN_4 = _T_40 ? $signed(16'sh1e00) : $signed(_GEN_2); // @[DummyDataGeneratorAXI.scala 37:26:@33.6]
  assign _GEN_5 = _T_40 ? 8'h1 : _GEN_3; // @[DummyDataGeneratorAXI.scala 37:26:@33.6]
  assign _GEN_6 = isReady ? $signed(_GEN_4) : $signed(data); // @[DummyDataGeneratorAXI.scala 28:25:@17.4]
  assign _GEN_7 = isReady ? _GEN_5 : counter; // @[DummyDataGeneratorAXI.scala 28:25:@17.4]
  assign _GEN_8 = io_tready ? 1'h1 : isReady; // @[DummyDataGeneratorAXI.scala 42:18:@38.4]
  assign io_tvalid = 1'h1; // @[DummyDataGeneratorAXI.scala 18:13:@8.4]
  assign io_tlast = 1'h0; // @[DummyDataGeneratorAXI.scala 19:12:@9.4]
  assign io_tdata = data; // @[DummyDataGeneratorAXI.scala 25:12:@15.4]
  assign io_tkeep = 4'hf; // @[DummyDataGeneratorAXI.scala 20:12:@11.4]
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
  data = _RAND_0[15:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_1 = {1{`RANDOM}};
  counter = _RAND_1[7:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_2 = {1{`RANDOM}};
  isReady = _RAND_2[0:0];
  `endif // RANDOMIZE_REG_INIT
  end
`endif // RANDOMIZE
  always @(posedge clock) begin
    if (reset) begin
      data <= 16'sh0;
    end else begin
      if (isReady) begin
        if (_T_40) begin
          data <= 16'sh1e00;
        end else begin
          if (_T_34) begin
            data <= 16'sh1400;
          end else begin
            if (_T_28) begin
              data <= 16'sha00;
            end
          end
        end
      end
    end
    if (reset) begin
      counter <= 8'h1;
    end else begin
      if (isReady) begin
        if (_T_40) begin
          counter <= 8'h1;
        end else begin
          if (_T_34) begin
            counter <= _T_32;
          end else begin
            if (_T_28) begin
              counter <= _T_32;
            end
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
