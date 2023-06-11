`timescale 1ns/1ps

module tb_register_slice();

    reg clk;
    reg rst_n;

    // FORWARD instance signals
    reg forward_i_valid;
    wire forward_o_valid;
    reg forward_i_ready;
    wire forward_o_ready;
    reg [31:0] forward_i_data;
    wire [31:0] forward_o_data;

    // BACKWARD instance signals
    reg backward_i_valid;
    wire backward_o_valid;
    reg backward_i_ready;
    wire backward_o_ready;
    reg [31:0] backward_i_data;
    wire [31:0] backward_o_data;

    // BIDIRECTION instance signals
    reg bidirection_i_valid;
    wire bidirection_o_valid;
    reg bidirection_i_ready;
    wire bidirection_o_ready;
    reg [31:0] bidirection_i_data;
    wire [31:0] bidirection_o_data;

    // Clock generation
    always begin
        #5 clk = ~clk;
    end

    // Instantiate Register Slice modules
    register_slice #(
        .FORWARD(1'b1),
        .BACKWARD(1'b0),
        .BIDIRECTION(1'b0)
    ) forward_rs (
        .clk(clk),
        .rst_n(rst_n),
        .i_valid(forward_i_valid),
        .o_valid(forward_o_valid),
        .i_ready(forward_i_ready),
        .o_ready(forward_o_ready),
        .i_data(forward_i_data),
        .o_data(forward_o_data)
    );

    register_slice #(
        .FORWARD(1'b0),
        .BACKWARD(1'b1),
        .BIDIRECTION(1'b0)
    ) backward_rs (
        .clk(clk),
        .rst_n(rst_n),
        .i_valid(backward_i_valid),
        .o_valid(backward_o_valid),
        .i_ready(backward_i_ready),
        .o_ready(backward_o_ready),
        .i_data(backward_i_data),
        .o_data(backward_o_data)
    );

    register_slice #(
        .FORWARD(1'b0),
        .BACKWARD(1'b0),
        .BIDIRECTION(1'b1)
    ) bidirection_rs (
        .clk(clk),
        .rst_n(rst_n),
        .i_valid(bidirection_i_valid),
        .o_valid(bidirection_o_valid),
        .i_ready(bidirection_i_ready),
        .o_ready(bidirection_o_ready),
        .i_data(bidirection_i_data),
        .o_data(bidirection_o_data)
    );

    // Testbench
    initial begin
        // Initialize signals
        clk = 0;
        rst_n = 0;

        // Setup VCD generation
        $dumpfile("dump.vcd");
        $dumpvars;

        // Apply reset
        #10 rst_n = 1;
        #10 rst_n = 0;
        #10 rst_n = 1;

        // Test FORWARD functionality
        forward_i_valid = 1;
        forward_i_data = 32'hDEADBEEF;
        #20;
        forward_i_ready = 1;
        #10;
        assert(forward_o_data == forward_i_data) else $error("FORWARD mode failed!");

        // Test BACKWARD functionality
        backward_i_valid = 1;
        backward_i_data = 32'hCAFEBABE;
        #20;
        backward_i_ready = 1;
        #10;
        assert(backward_o_data == backward_i_data) else $error("BACKWARD mode failed!");

        // Test BIDIRECTION functionality
        bidirection_i_valid = 1;
        bidirection_i_data = 32'hFACEFEED;
        #20;
        bidirection_i_ready = 1;
        #10;
        assert(bidirection_o_data == bidirection_i_data) else $error("BIDIRECTION mode failed!");

        $finish;
    end
endmodule