// =============================================================================
// Filename: divider_tb.v
// Author: ZHU, Jingyang
// Email: jzhuak@connect.ust.hk
// Affiliation: Hong Kong University of Science and Technology
// -----------------------------------------------------------------------------
//
// This file exports the testbench for divider module.
// It generates the adhoc input stimulus for the divider.
// =============================================================================

`timescale 1 ns / 1 ps

module divider_tb;

// ----------------------------------
// Local parameter declaration
// ----------------------------------
localparam CLK_PERIOD = 5.0;  // clock period: 5ns

// ----------------------------------
// Interface of the divider module
// ----------------------------------
reg clk, rst, start;
reg [31:0] dividend, divisor;
wire done;
wire [31:0] quotient, remainder;

// ----------------------------------
// Instantiate the divider
// ----------------------------------
divider # (
  .XLEN       (32)
) dut (
  .clk        (clk),          // system clock
  .rst_n      (rst_n),        // system reset (active high)

  .vld        (start),        // flag for starting division
  .a          (dividend),     // operand 1: dividend
  .b          (divisor),      // operand 2: divisor

  .ack        (done),         // flag for finishing division
  .quo        (quotient),     // result 1: quotient
  .rem        (remainder)     // result 2: remainder
);

// ----------------------------------
// For gate-level and post-layout 
// simulation, we should backannotate 
// the SDF file defined in SDF_FILE
// ----------------------------------

`ifdef SDF_FILE
initial begin
  $sdf_annotate(`SDF_FILE, uut);
end
`endif

// ----------------------------------
// Clock generation
// ----------------------------------

initial begin
  clk = 1'b0;
  forever #(CLK_PERIOD/2.0) clk = ~clk;
end

// ----------------------------------
// Input stimulus
// Generate the ad-hoc stimulus
// ----------------------------------
initial begin
  // Reset
  rst         = 1'b1;
  start       = 1'b0;
  dividend    = 32'd0;
  divisor     = 32'd0;
  #(2*CLK_PERIOD) rst = 1'b0;

  // Input stimulus 1: 10/7
  @(negedge clk);
  start       = 1'b1;
  dividend    = 32'd10;
  divisor     = 32'd7;
  #CLK_PERIOD;
  start       = 1'b0;

  // Input stimulus 2: 100/100
  wait(done == 1'b1); #CLK_PERIOD; @(negedge clk);
  start       = 1'b1;
  dividend    = 32'd100;
  divisor     = 32'd100;
  #CLK_PERIOD;
  start       = 1'b0;

  // Input stimulus 3: 100/7
  wait(done == 1'b1); #CLK_PERIOD; @(negedge clk);
  start       = 1'b1;
  dividend    = 32'd100;
  divisor     = 32'd7;
  #CLK_PERIOD;
  start       = 1'b0;

  // Input stimulus 4: 100/0
  wait(done == 1'b1); #CLK_PERIOD; @(negedge clk);
  start       = 1'b1;
  dividend    = 32'd100;
  divisor     = 32'd0;
  #CLK_PERIOD;
  start       = 1'b0;

  // Input stimulus 4: i70/150
  wait(done == 1'b1); #CLK_PERIOD; @(negedge clk);
  start       = 1'b1;
  dividend    = 32'd70;
  divisor     = 32'd150;
  #CLK_PERIOD;
  start       = 1'b0;

  // Finish the testbench
  wait(done == 1'b1); #(CLK_PERIOD*2);
  $finish;
end
  
// ----------------------------------
// Time Limit
// ----------------------------------
initial begin
  #1000000 
  $display("Reach time limit, force stop.");
  $finish;
end
  
// ----------------------------------
// Output monitor
// ----------------------------------
always @(posedge clk) begin
  if (done) begin
    $display("%0d / %0d: quotient = %0d, remainder = %0d", dividend, divisor,
      quotient, remainder);
  end
end

endmodule
