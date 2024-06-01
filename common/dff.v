/*
Explanation:

The module is named dff and has two parameters:
WIDTH: Specifies the width of the d and q ports. It defaults to 1 if not explicitly set when instantiating the module.
RESET_VALUE: Specifies the reset value for the q output. It defaults to 0 if not explicitly set.
The module has three ports:
clk: The clock input.
d: The input port with a width of WIDTH bits.
q: The output port with a width of WIDTH bits, declared as a reg.
The always block is triggered on the positive edge of the clock (posedge clk). It assigns the value of d to q on each clock cycle.
The initial block sets the initial value of q to the RESET_VALUE parameter when the module is instantiated.

You can instantiate this DFF module with custom widths and reset values. For example:

DFF #(
    .WIDTH(4),
    .RESET_VALUE(4'b1010)
) U_DFF (
    .clk(clk),
    .d(d_input),
    .q(q_output)
);

*/
module DFF #(
    parameter WIDTH = 1,
    parameter RESET_VALUE = {WIDTH{1'b0}}
) (
    input clk,
    input [WIDTH-1:0] d,
    output reg [WIDTH-1:0] q
);

    always @(posedge clk) begin
        q <= d;
    end

    initial begin
        q = RESET_VALUE;
    end

endmodule