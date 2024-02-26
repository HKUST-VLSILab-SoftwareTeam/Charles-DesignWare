module STD_DFFRE #(
    parameter WIDTH = 16  // Parameter for bit width, defaults to 16
)(
    input wire clk,        // Clock input
    input wire rst_n,      // Active-low reset
    input wire en,         // Enable input
    input wire [WIDTH-1:0] d, // Data input with parameterized width
    output reg [WIDTH-1:0] q  // Data output (registered) with parameterized width
);

    // On every rising edge of the clock or falling edge of reset...
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            // Asynchronously reset the output to 0 on active-low reset
            q <= {WIDTH{1'b0}};
        end else if (en) begin
            // If enable is high, capture the input data
            q <= d;
        end
        // If enable is low, retain the current state (no else clause needed)
    end

endmodule