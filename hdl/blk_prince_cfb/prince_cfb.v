`timescale 1ns / 1ps
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Company: HKUST
// Engineer: jjiagnan@connect.ust.hk
// 
// Create Date: 09/03/2020 05:10:05 PM
// Design Name: 
// Module Name: prince_cfb
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// This file implement a CFB mode prince_core which works on 16bit plain text and 128bit key. The orignial 64-bit 
// version prince_core designed by [1] is divided into 4 groups, ecah group is a 16-bit sub prince_core taking 16-bit
// sub plain text and 32-bit sub key as the input. 
// 
// To cipher a 16-bit text, the sub prince_core with different configurations will be called 4 times in an outter loop 
// fsm sequentially. Each sub prince_core has 17 inner loops, which is the same as [1]. Thus, ideally the whole 
// prince_core consumes 17*4 = 68 cycles to cipher one 16-bit text. 
// 
// You could also fully or partially pipeline + unroll the inner and outer loop to perform cipher in less cycles. But 
// this also increase the power and area. The best throughput you can achieve is 1 cycle with the cost of 68 times are
// and power increase.
//
// [1] PRINCE - A low-latency block cipher fore pervasive computing applications, Julia Borghoff, 2012
// 
// Dependencies: 
// No external memory/IP is used.
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


module prince_cfb(
    input  wire                 clk,
    input  wire                 rst_n,

    // control signal
    input  wire                 block_start,        // assert it for one cycle high if you want to start the cipher. 
                                                    // It will be ignored if the block is busy.
    output reg                  block_done,         // one cycle high indicating the previous request has been done.
    output wire                 block_busy_n,       // low when processing, indicating the block is busy.

    // data signal
    input  wire                 encrypt,            // choose if you want to decode or encode
    input  wire     [15:0]      plain_text,         
    input  wire     [15:0]      chip_id,            // input chip ID as the key
    output reg      [15:0]      cipher_text
    );

    //-----------------------------------------------------------------------------------------------------------------
    // Local constant and parameter definitions.
    //-----------------------------------------------------------------------------------------------------------------
    // FSM state for the outer loop (CFB loop), execute sequentially
    localparam OUTER_LOOP_IDLE        = 4'd0;
    localparam OUTER_LOOP_ROUND1      = 4'd1;      // Handle plain_text (encrypt ? [15:0]   : [63:48])
    localparam OUTER_LOOP_ROUND2      = 4'd2;      // Handle plain_text (encrypt ? [31:16]  : [47:32])
    localparam OUTER_LOOP_ROUND3      = 4'd3;      // Handle plain_text (encrypt ? [47:32]  : [31:16])
    localparam OUTER_LOOP_ROUND4      = 4'd4;      // Handle plain_text (encrypt ? [63:48]  : [15:0])

    //-----------------------------------------------------------------------------------------------------------------
    // Simple hash function generating a 128b key from a 16b chip id
    // Since Prince has already garanteed to whitenning the key, we don't need to use a complex hash function
    //-----------------------------------------------------------------------------------------------------------------
    wire     [63:0]      k0 = {48'd0, chip_id};
    wire     [63:0]      k1 = {48'd0, chip_id};

    //-----------------------------------------------------------------------------------------------------------------
    // FSM
    //-----------------------------------------------------------------------------------------------------------------
    // state machine
    wire            inner_block_done;
    reg     [3:0]   state;
    always @(posedge clk) begin
        if(!rst_n) begin
            state           <=  OUTER_LOOP_IDLE;
        end else begin
            case (state)
            OUTER_LOOP_IDLE: begin
                if(block_start) begin
                    state   <=  OUTER_LOOP_ROUND1;                    
                end
            end

            OUTER_LOOP_ROUND1: begin
                if(inner_block_done) begin
                    state   <=  OUTER_LOOP_ROUND2;
                end
            end

            OUTER_LOOP_ROUND2: begin
                if(inner_block_done) begin
                    state   <=  OUTER_LOOP_ROUND3;
                end
            end

            OUTER_LOOP_ROUND3: begin
                if(inner_block_done) begin
                    state   <=  OUTER_LOOP_ROUND4;
                end
            end
            
            OUTER_LOOP_ROUND4: begin
                if(inner_block_done) begin
                    state   <=  OUTER_LOOP_IDLE;
                end
            end

            default: begin
                state       <=  OUTER_LOOP_IDLE;
            end

            endcase
        end
    end

    // change outer index
    reg     [1:0]   outer_idx;
    always@(*) begin
        case (state)
        OUTER_LOOP_ROUND1: begin
            outer_idx       = encrypt ? 2'd0 : 2'd3;
        end

        OUTER_LOOP_ROUND2: begin
            outer_idx       = encrypt ? 2'd1 : 2'd2;
        end

        OUTER_LOOP_ROUND3: begin
            outer_idx       = encrypt ? 2'd2 : 2'd1;
        end

        OUTER_LOOP_ROUND4: begin
            outer_idx       = encrypt ? 2'd3 : 2'd0;
        end

        default: begin
            outer_idx       = encrypt ? 2'd0 : 2'd3;
        end

        endcase
    end

    // delay inner_block_done 1 clk as innter_block_start during the outer loop
    reg             inner_block_done_r;
    always @(posedge clk) begin
        inner_block_done_r  <= inner_block_done;
    end

    // change inner_block_start
    reg             inner_block_start;
    always@(*) begin
        case (state)
        OUTER_LOOP_ROUND1, OUTER_LOOP_ROUND2, OUTER_LOOP_ROUND3, OUTER_LOOP_ROUND4: begin
            inner_block_start = inner_block_done_r;
        end

        default: begin
            inner_block_start = block_start;
        end

        endcase
    end

    // execute machine - change output_done
    always @(posedge clk) begin
        block_done           <= (state == OUTER_LOOP_ROUND4) && inner_block_done;
    end

    // execute machine - block busy sign
    assign block_busy_n = (state == OUTER_LOOP_IDLE);

    // execute machine - register and output cipher text to prevent from inner variable value leaking 
    wire    [15:0]  cipher_text_inner;
    always @(posedge clk) begin
        if((state == OUTER_LOOP_ROUND4) && inner_block_done) begin
            cipher_text     <= cipher_text_inner;
        end
    end

    // execute machine - plain text_w
    wire    [15:0]   plain_text_w;
    assign plain_text_w = (state==OUTER_LOOP_IDLE)? plain_text : cipher_text_inner;

    //-----------------------------------------------------------------------------------------------------------------
    // Instantiation
    //-----------------------------------------------------------------------------------------------------------------
    prince_core  prince_core_inst (
        .clk                     (clk),
        .rst_n                   (rst_n),

        .block_start             (inner_block_start),
        .outer_idx               (outer_idx),
        .encrypt                 (encrypt),
        .k0                      (k0),
        .k1                      (k1),
        .plain_text              (plain_text_w),

        .block_done              (inner_block_done),
        .cipher_text             (cipher_text_inner)
    );

endmodule
