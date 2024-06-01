/*
Explanation:

The module is named dff and has two parameters:
WIDTH: Specifies the width of the input d and output q ports. The default value is 1.
RESET_VALUE: Specifies the reset value for the flip-flop. The default value is all zeros with a width of WIDTH.
The module has four ports:
clk: The clock input.
rst_n: The active-low reset input. When rst_n is low, the flip-flop is reset to the RESET_VALUE.
d: The input data port with a width of WIDTH.
q: The output data port with a width of WIDTH.
The always block is triggered on the positive edge of clk or the negative edge of rst_n.
If rst_n is low (active), the flip-flop is reset to the RESET_VALUE.
If rst_n is high (inactive), the input data d is assigned to the output q on the positive edge of clk.

You can instantiate this DFF module in your design and customize the WIDTH and RESET_VALUE parameters according to your requirements. For example:

DFFR #(
    .WIDTH(8),
    .RESET_VALUE(8'h55)
) U_DFFR (
    .clk(clk),
    .rst_n(rst_n),
    .d(data_in),
    .q(data_out)
);
*/
module DFFR #(
    parameter WIDTH = 1,
    parameter RESET_VALUE = {WIDTH{1'b0}}
) (
    input                       clk,
    input                       rst_n,
    input      [WIDTH-1:0]      d,
    output reg [WIDTH-1:0]      q
);

always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        q <= RESET_VALUE;
    end else begin
        q <= d;
    end
end

endmodule