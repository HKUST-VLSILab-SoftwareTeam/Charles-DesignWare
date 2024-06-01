/*
This Verilog module has the following features:

Parameters:
WIDTH: Specifies the width of the input d and output q ports. The default value is 1, making it a single-bit DFF by default.
RESET_VALUE: Specifies the value that the DFF will be reset to when rst_n is asserted low. The default value is 0.
Ports:
clk: The clock input.
en: The enable input. When en is high, the DFF captures the value of d on the rising edge of clk.
rst_n: The asynchronous active-low reset input. When rst_n is asserted low, the DFF is reset to the RESET_VALUE.
d: The input data port with a width of WIDTH bits.
q: The output data port with a width of WIDTH bits.
Functionality:
The DFF is triggered on the rising edge of clk.
When rst_n is asserted low, the DFF is asynchronously reset to the RESET_VALUE, regardless of the clock edge.
When en is high and rst_n is not asserted, the DFF captures the value of d on the rising edge of clk.
If en is low, the DFF holds its previous value, regardless of the clock edge.

You can instantiate this DFF module in your design and specify the desired width and reset value using the WIDTH and RESET_VALUE parameters, respectively. For example:

DFFRE #(
    .WIDTH(8),
    .RESET_VALUE(8'h00)
) U_DFFRE (
    .clk(clk),
    .en(en),
    .rst_n(rst_n),
    .d(data_in),
    .q(data_out)
);
*/

module DFFRE #(
    parameter WIDTH = 1,
    parameter RESET_VALUE = {WIDTH{1'b0}}
)(
    input clk,
    input en,
    input rst_n,
    input [WIDTH-1:0] d,
    output reg [WIDTH-1:0] q
);

always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        q <= RESET_VALUE;
    end else if (en) begin
        q <= d;
    end
end

endmodule
