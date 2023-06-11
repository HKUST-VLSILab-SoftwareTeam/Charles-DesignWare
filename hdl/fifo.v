`timescale 1ns / 1ps
/*
This module has the following interface:
- clk:          Clock input
- rst:          Asynchronous reset input (active high)
- wr_en:        Write enable input
- rd_en:        Read enable input
- wr_data:      Write data input
- rd_data:      Read data output
- empty:        Empty flag output (high when the FIFO is empty)
- full:         Full flag output (high when the FIFO is full)
- almost_full:  Indicates when the FIFO is one write away from being full.
- almost_empty: Indicates when the FIFO is one read away from being empty.

Explanation of the module:
The module uses two pointers (wr_ptr and rd_ptr) to track the write and read positions in the memory array mem. 
The empty and full flags are derived from the pointer positions, 
and the module updates the pointers and memory contents based on the control inputs wr_en and rd_en.
*/

module fifo #(
    parameter WIDTH = 8,
    parameter DEPTH = 16
) (
    input   wire                clk,
    input   wire                rst_n,
    input   wire                wr_en,
    input   wire                rd_en,
    input   wire [WIDTH-1:0]    wr_data,
    output  wire [WIDTH-1:0]    rd_data,

    output  wire                empty,
    output  wire                full,
    
    output  wire                almost_full,
    output  wire                almost_empty
);

localparam ADDR_WIDTH = $clog2(DEPTH);

reg [ADDR_WIDTH-1:0]    wr_ptr, rd_ptr;
reg [WIDTH-1:0]         mem [DEPTH-1:0];
reg [WIDTH-1:0]         rd_data_reg;

assign rd_data      = rd_data_reg;
assign empty        = (wr_ptr == rd_ptr);
assign full         = (((wr_ptr + 1) & (DEPTH - 1)) == rd_ptr);
assign almost_full  = (((wr_ptr + 2) & (DEPTH - 1)) == rd_ptr);
assign almost_empty = (((rd_ptr + 1) & (DEPTH - 1)) == wr_ptr);

always @(posedge clk or posedge rst_n) begin
    if (!rst_n) begin
        wr_ptr              <= 0;
        rd_ptr              <= 0;
    end else begin
        if (wr_en && !full) begin
            mem[wr_ptr]     <= wr_data;
            wr_ptr          <= (wr_ptr + 1) & (DEPTH - 1);
        end
        if (rd_en && !empty) begin
            rd_data_reg     <= mem[rd_ptr];
            rd_ptr          <= (rd_ptr + 1) & (DEPTH - 1);
        end
    end
end

endmodule