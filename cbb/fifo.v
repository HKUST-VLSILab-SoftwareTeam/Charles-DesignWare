`timescale 1ns / 1ps

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