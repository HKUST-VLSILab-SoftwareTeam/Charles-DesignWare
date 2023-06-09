`timescale 1ns / 1ps

module tb_fifo();
    localparam WIDTH = 8;
    localparam DEPTH = 16;

    reg clk = 0;
    reg rst_n = 0;
    reg wr_en = 0;
    reg rd_en = 0;
    reg [WIDTH-1:0] wr_data;
    wire [WIDTH-1:0] rd_data;
    wire empty;
    wire full;
    wire almost_full;
    wire almost_empty;

    // Instantiate the fifo module
    fifo #(
        .WIDTH(WIDTH),
        .DEPTH(DEPTH)
    ) u_fifo (
        .clk(clk),
        .rst_n(rst_n),
        .wr_en(wr_en),
        .rd_en(rd_en),
        .wr_data(wr_data),
        .rd_data(rd_data),
        .empty(empty),
        .full(full),
        .almost_full(almost_full),
        .almost_empty(almost_empty)
    );

    // Clock generation
    always #5 clk = ~clk;

    // VCD generation
    initial begin
        $dumpfile("fifo_waveform.vcd");
        $dumpvars(0, tb_fifo);
    end

    // Test stimulus
    initial begin
        // Reset
        rst_n <= 0;
        #10;
        rst_n <= 1;
        #10;

        // Test Case 1: Consecutively write DEPTH+1 data into the FIFO
        repeat(DEPTH+1) begin
            wr_data <= $urandom_range(0, 2**WIDTH-1);
            wr_en <= 1;
            #10;
            wr_en <= 0;
            #10;
        end

        // Test Case 2: Consecutively read DEPTH+1 data from the FIFO
        repeat(DEPTH+1) begin
            rd_en <= 1;
            #10;
            rd_en <= 0;
            #10;
        end

        // Finish simulation
        $finish;
    end
endmodule