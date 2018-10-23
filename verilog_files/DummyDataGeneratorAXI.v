module DummyDataGeneratorAXI( // @[:@3.2]
  input         clock, // @[:@4.4]
  input         reset, // @[:@5.4]
  input         io_tready, // @[:@6.4]
  output        io_tvalid, // @[:@6.4]
  output        io_tlast, // @[:@6.4]
  output [31:0] io_tdata, // @[:@6.4]
  output [3:0]  io_tkeep // @[:@6.4]
);
  reg [7:0] counter; // @[DummyDataGeneratorAXI.scala 24:24:@14.4]
  reg [31:0] _RAND_0;
  wire  _T_25; // @[DummyDataGeneratorAXI.scala 27:18:@16.6]
  wire [8:0] _T_29; // @[DummyDataGeneratorAXI.scala 32:26:@24.8]
  wire [7:0] _T_30; // @[DummyDataGeneratorAXI.scala 32:26:@25.8]
  wire [31:0] _GEN_0; // @[DummyDataGeneratorAXI.scala 27:27:@17.6]
  wire [7:0] _GEN_1; // @[DummyDataGeneratorAXI.scala 27:27:@17.6]
  wire [7:0] _GEN_3; // @[DummyDataGeneratorAXI.scala 26:19:@15.4]
  assign _T_25 = counter == 8'h1; // @[DummyDataGeneratorAXI.scala 27:18:@16.6]
  assign _T_29 = counter + 8'h1; // @[DummyDataGeneratorAXI.scala 32:26:@24.8]
  assign _T_30 = _T_29[7:0]; // @[DummyDataGeneratorAXI.scala 32:26:@25.8]
  assign _GEN_0 = _T_25 ? 32'hffffffff : 32'h0; // @[DummyDataGeneratorAXI.scala 27:27:@17.6]
  assign _GEN_1 = _T_25 ? 8'h0 : _T_30; // @[DummyDataGeneratorAXI.scala 27:27:@17.6]
  assign _GEN_3 = io_tready ? _GEN_1 : counter; // @[DummyDataGeneratorAXI.scala 26:19:@15.4]
  assign io_tvalid = 1'h1; // @[DummyDataGeneratorAXI.scala 18:13:@8.4]
  assign io_tlast = 1'h0; // @[DummyDataGeneratorAXI.scala 19:12:@9.4]
  assign io_tdata = io_tready ? _GEN_0 : 32'h0; // @[DummyDataGeneratorAXI.scala 21:12:@12.4 DummyDataGeneratorAXI.scala 28:16:@19.8 DummyDataGeneratorAXI.scala 31:16:@23.8]
  assign io_tkeep = 4'h1; // @[DummyDataGeneratorAXI.scala 20:12:@11.4]
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
  counter = _RAND_0[7:0];
  `endif // RANDOMIZE_REG_INIT
  end
`endif // RANDOMIZE
  always @(posedge clock) begin
    if (reset) begin
      counter <= 8'h0;
    end else begin
      if (io_tready) begin
        if (_T_25) begin
          counter <= 8'h0;
        end else begin
          counter <= _T_30;
        end
      end
    end
  end
endmodule
