/*
Explanation:

The module is named dff_with_en and has one parameter:
WIDTH: Specifies the width of the d and q ports. It defaults to 1 if not explicitly set when instantiating the module.
The module has four ports:
clk: The clock input.
en: The enable input. When en is high (1), the DFF captures the value of d on the positive edge of the clock. When en is low (0), the DFF holds its previous value.
d: The input port with a width of WIDTH bits.
q: The output port with a width of WIDTH bits, declared as a reg.
The always block is triggered on the positive edge of the clock (posedge clk).
Inside the always block, there is an if statement that checks the value of the en signal.
If en is high (1), the value of d is assigned to q on the positive edge of the clock.
If en is low (0), the DFF holds its previous value, and q remains unchanged.

You can instantiate this DFF with enable module with custom widths. For example:

DFFE #(
    .WIDTH(8)
) U_DFFE (
    .clk(clk),
    .en(enable),
    .d(d_input),
    .q(q_output)
);
*/

module DFFE #(
    parameter WIDTH = 1
) (
    input clk,
    input en,
    input [WIDTH-1:0] d,
    output reg [WIDTH-1:0] q
);

    always @(posedge clk) begin
        if (en) begin
            q <= d;
        end
    end

endmodule