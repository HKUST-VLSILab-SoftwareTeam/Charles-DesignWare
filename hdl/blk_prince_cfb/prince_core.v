`timescale 1ns / 1ps
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/04/2020 11:09:01 AM
// Design Name: 
// Module Name: prince_core
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

module prince_core(
    input  wire                 clk,
    input  wire                 rst_n,

    // control signal
    input  wire                 encrypt,            // choose if you want to decode or encode
    input  wire                 block_start,        // assert it for one cycle high to start the inner loop
    output reg                  block_done,         // one cycle high if result is done

    // data signal
    input  wire     [1:0]       outer_idx,          // 0-3 indicates which round of cipher is this inner loop executing
    input  wire     [63:0]      k0,
    input  wire     [63:0]      k1,
    input  wire     [15:0]      plain_text,         // plain text is only registered during (block_start==1)
    output reg      [15:0]      cipher_text         // cipher text value only valid during (block_done==1)
    );  

    //-----------------------------------------------------------------------------------------------------------------
    // Local constant and parameter definitions.
    //-----------------------------------------------------------------------------------------------------------------
    // FSM state for the inner loop (cipher core pipeline loop), execute sequentially
    // These FSM values are specially designed to be used as RC's address, don't change it unless you know it.
    localparam INNER_LOOP_IDLE        = 4'h0;      // hold cipher_text value, register plain_text value
    localparam INNER_LOOP_INPUT       = 4'hd;      // perform input whitenning (k0, k1)
    localparam INNER_LOOP_RC_1        = 4'h1;      
    localparam INNER_LOOP_RC_2        = 4'h2;     
    localparam INNER_LOOP_RC_3        = 4'h3;     
    localparam INNER_LOOP_RC_4        = 4'h4;     
    localparam INNER_LOOP_RC_5        = 4'h5;     
    localparam INNER_LOOP_MID         = 4'hb;
    localparam INNER_LOOP_RC_6        = 4'h6;     
    localparam INNER_LOOP_RC_7        = 4'h7;     
    localparam INNER_LOOP_RC_8        = 4'h8;     
    localparam INNER_LOOP_RC_9        = 4'h9;     
    localparam INNER_LOOP_RC_10       = 4'ha;     
    localparam INNER_LOOP_DONE        = 4'hc;       // perform output whitenning (k0, k1)

    // Alpha for decipher
    localparam ALPHA_K0 = 64'h0000000000000000;
    localparam ALPHA_K1 = 64'hc0ac29b7c97c50dd;

    // RC
    wire     [63:0]      RC      [11:0];
    assign RC[0]     = 64'h0000000000000000;
    assign RC[1]     = 64'h13198a2e03707344;
    assign RC[2]     = 64'ha4093822299f31d0;
    assign RC[3]     = 64'h082efa98ec4e6c89;
    assign RC[4]     = 64'h452821e638d01377;
    assign RC[5]     = 64'hbe5466cf34e90c6c;
    assign RC[6]     = 64'h7ef84f78fd955cb1;
    assign RC[7]     = 64'h85840851f1ac43aa;
    assign RC[8]     = 64'hc882d32f25323c54;
    assign RC[9]     = 64'h64a51195e0e3610d;
    assign RC[10]    = 64'hd3b5a399ca0c2399;
    assign RC[11]    = 64'hc0ac29b7c97c50dd;

    //-----------------------------------------------------------------------------------------------------------------
    // Pre-processing keys
    //-----------------------------------------------------------------------------------------------------------------
    wire    [63:0]  k0_alphaed          = encrypt ? k0 : k0 ^ ALPHA_K0;
    wire    [63:0]  k1_alphaed          = encrypt ? k1 : k1 ^ ALPHA_K1;
    wire    [63:0]  k0_alphaed_prime    = {k0_alphaed[0], k0_alphaed[63:1]} ^ {63'd0, k0_alphaed[63]};

    //-----------------------------------------------------------------------------------------------------------------
    // Define S-box functions
    //-----------------------------------------------------------------------------------------------------------------
    // LUT: S-box 4-bit version
    function [3:0] s_4b(input [3:0] x);
    begin
        case(x)
        4'h0: s_4b = 4'hb;
        4'h1: s_4b = 4'hf;
        4'h2: s_4b = 4'h3;
        4'h3: s_4b = 4'h2;
        4'h4: s_4b = 4'ha;
        4'h5: s_4b = 4'hc;
        4'h6: s_4b = 4'h9;
        4'h7: s_4b = 4'h1;
        4'h8: s_4b = 4'h6;
        4'h9: s_4b = 4'h7;
        4'ha: s_4b = 4'h8;
        4'hb: s_4b = 4'h0;
        4'hc: s_4b = 4'he;
        4'hd: s_4b = 4'h5;
        4'he: s_4b = 4'hd;
        4'hf: s_4b = 4'h4;
        endcase
    end
    endfunction

    // LUT: S-box inversion 4-bit version
    function [3:0] s_4b_inv(input [3:0] x); 
    begin
        case(x)
        4'h0: s_4b_inv = 4'hb;
        4'h1: s_4b_inv = 4'h7;
        4'h2: s_4b_inv = 4'h3;
        4'h3: s_4b_inv = 4'h2;
        4'h4: s_4b_inv = 4'hf;
        4'h5: s_4b_inv = 4'hd;
        4'h6: s_4b_inv = 4'h8;
        4'h7: s_4b_inv = 4'h9;
        4'h8: s_4b_inv = 4'ha;
        4'h9: s_4b_inv = 4'h6;
        4'ha: s_4b_inv = 4'h4;
        4'hb: s_4b_inv = 4'h0;
        4'hc: s_4b_inv = 4'h5;
        4'hd: s_4b_inv = 4'he;
        4'he: s_4b_inv = 4'hc;
        4'hf: s_4b_inv = 4'h1;
        endcase
    end 
    endfunction

    // LUT: S-box 16-bit version
    function [15:0] s(input [15:0] x);
    begin
        s[3:0]      = s_4b(x[3:0]);
        s[7:4]      = s_4b(x[7:4]);
        s[11:8]     = s_4b(x[11:8]);
        s[15:12]    = s_4b(x[15:12]);
    end
    endfunction

    // LUT: S-box inversion 16-bit version
    function [15:0] s_inv(input [15:0] x);
    begin
        s_inv[3:0]      = s_4b_inv(x[3:0]);
        s_inv[7:4]      = s_4b_inv(x[7:4]);
        s_inv[11:8]     = s_4b_inv(x[11:8]);
        s_inv[15:12]    = s_4b_inv(x[15:12]);
    end
    endfunction

    //-----------------------------------------------------------------------------------------------------------------
    // Define m (linear or P-box) functions
    //-----------------------------------------------------------------------------------------------------------------
    // m0 function
    function [15:0] m0(input [15:0] x);
    begin
        m0[0]    = x[0] ^ x[4]  ^ x[8];
        m0[1]    = x[5] ^ x[9]  ^ x[13];
        m0[2]    = x[2] ^ x[10] ^ x[14];
        m0[3]    = x[3] ^ x[7]  ^ x[15];
        m0[4]    = x[0] ^ x[4]  ^ x[12];
        m0[5]    = x[1] ^ x[5]  ^ x[9];
        m0[6]    = x[6] ^ x[10] ^ x[14];
        m0[7]    = x[3] ^ x[11] ^ x[15];
        m0[8]    = x[0] ^ x[8]  ^ x[12];
        m0[9]    = x[1] ^ x[5]  ^ x[13];
        m0[10]   = x[2] ^ x[6]  ^ x[10];
        m0[11]   = x[7] ^ x[11] ^ x[15];
        m0[12]   = x[4] ^ x[8]  ^ x[12];
        m0[13]   = x[1] ^ x[9]  ^ x[13];
        m0[14]   = x[2] ^ x[6]  ^ x[14];
        m0[15]   = x[3] ^ x[7]  ^ x[11];
    end
    endfunction

    // m1 function
    function [15:0] m1(input [15:0] x);
    begin
        m1[0]    = x[4] ^ x[8]  ^ x[12];
        m1[1]    = x[1] ^ x[9]  ^ x[13];
        m1[2]    = x[2] ^ x[6]  ^ x[14];
        m1[3]    = x[3] ^ x[7]  ^ x[11];
        m1[4]    = x[0] ^ x[4]  ^ x[8];
        m1[5]    = x[5] ^ x[9]  ^ x[13];
        m1[6]    = x[2] ^ x[10] ^ x[14];
        m1[7]    = x[3] ^ x[7]  ^ x[15];
        m1[8]    = x[0] ^ x[4]  ^ x[12];
        m1[9]    = x[1] ^ x[5]  ^ x[9];
        m1[10]   = x[6] ^ x[10] ^ x[14];
        m1[11]   = x[3] ^ x[11] ^ x[15];
        m1[12]   = x[0] ^ x[8]  ^ x[12];
        m1[13]   = x[1] ^ x[5]  ^ x[13];
        m1[14]   = x[2] ^ x[6]  ^ x[10];
        m1[15]   = x[7] ^ x[11] ^ x[15];
    end
    endfunction

    // m prime function
    function [15:0] mprime(input [15:0] x, input [1:0] outer_idx);
    begin
        case(outer_idx)
        2'b00, 2'b11:   mprime = m0(x);
        2'b01, 2'b10:   mprime = m1(x);
        endcase
    end

    endfunction
    
    //-----------------------------------------------------------------------------------------------------------------
    // Define sr
    //-----------------------------------------------------------------------------------------------------------------
    // sr function
    function [15:0] sr(input [15:0] x);
    begin
        sr[0]    = x[0];
        sr[1]    = x[5];
        sr[2]    = x[10];
        sr[3]    = x[15];
        sr[4]    = x[4];
        sr[5]    = x[9];
        sr[6]    = x[14];
        sr[7]    = x[3];
        sr[8]    = x[8];
        sr[9]    = x[13];
        sr[10]   = x[2];
        sr[11]   = x[7];
        sr[12]   = x[12];
        sr[13]   = x[1];
        sr[14]   = x[6];
        sr[15]   = x[11];
    end
    endfunction

    // sr inversion function
    function [15:0] sr_inv(input [15:0] x);
    begin
        sr_inv[0]    = x[0];
        sr_inv[5]    = x[1];
        sr_inv[10]   = x[2];
        sr_inv[15]   = x[3];
        sr_inv[4]    = x[4];
        sr_inv[9]    = x[5];
        sr_inv[14]   = x[6];
        sr_inv[3]    = x[7];
        sr_inv[8]    = x[8];
        sr_inv[13]   = x[9];
        sr_inv[2]    = x[10];
        sr_inv[7]    = x[11];
        sr_inv[12]   = x[12];
        sr_inv[1]    = x[13];
        sr_inv[6]    = x[14];
        sr_inv[11]   = x[15];
    end
    endfunction

    //-----------------------------------------------------------------------------------------------------------------
    // Define final R box and R' box.
    // @param x: the 16bit sub input data.
    // @param key: the 16bit sub-key.
    // @param outer_idx: the index of outer loop.
    // @param rc_idx: which RC value should be used for this R block.
    // @param flag: each bit is an independent flag used to reconfigure the r_box.
    //-----------------------------------------------------------------------------------------------------------------
    function [15:0] r_box(input [15:0] x, input [3:0] rc_idx, input [3:0] flag);
    begin: r_block_func
        // local nets
        reg    [15:0]      net_0;
        reg    [15:0]      net_1;
        reg    [15:0]      net_2;
        reg    [15:0]      net_3;
        reg    [15:0]      rc_local;

        // fetch rc and xor with k1
        case (outer_idx)
        2'd0: rc_local     = RC[rc_idx][15:0]  ^ k1_alphaed[15:0];
        2'd1: rc_local     = RC[rc_idx][31:16] ^ k1_alphaed[31:16];
        2'd2: rc_local     = RC[rc_idx][47:32] ^ k1_alphaed[47:32];
        2'd3: rc_local     = RC[rc_idx][63:48] ^ k1_alphaed[63:48];
        endcase

        // processing: inv_flag ? R'() : R()
        net_0               = flag[0] ?    x ^ rc_local    : x;
        net_1               = flag[1] ?    sr_inv(net_0)   : s(net_0);
        net_2               = mprime(net_1, outer_idx);
        net_3               = flag[2] ?    s_inv(net_2)    : sr(net_2);
        r_box               = flag[3] ?    net_3           : net_3 ^ rc_local; 
    end
    endfunction

    //-----------------------------------------------------------------------------------------------------------------
    // Input and ouput whitening block
    //-----------------------------------------------------------------------------------------------------------------
    // Input whitening block
    function [15:0] cipher_k1_input(input [15:0] x);
    begin
        case (outer_idx)
        2'd0:  cipher_k1_input = x ^ k1_alphaed[15:0]  ^ RC[0][15:0];
        2'd1:  cipher_k1_input = x ^ k1_alphaed[31:16] ^ RC[0][31:16];
        2'd2:  cipher_k1_input = x ^ k1_alphaed[47:32] ^ RC[0][47:32];
        2'd3:  cipher_k1_input = x ^ k1_alphaed[63:48] ^ RC[0][63:48];
        endcase
    end
    endfunction

    // Output whitening block
    function [15:0] cipher_k1_output(input [15:0] x);
    begin
        case (outer_idx)
        2'd0:  cipher_k1_output = x ^ k1_alphaed[15:0]  ^ RC[11][15:0];
        2'd1:  cipher_k1_output = x ^ k1_alphaed[31:16] ^ RC[11][31:16];
        2'd2:  cipher_k1_output = x ^ k1_alphaed[47:32] ^ RC[11][47:32];
        2'd3:  cipher_k1_output = x ^ k1_alphaed[63:48] ^ RC[11][63:48];
        endcase
    end
    endfunction

    //-----------------------------------------------------------------------------------------------------------------
    // Input and output cipher with k0
    //-----------------------------------------------------------------------------------------------------------------
    function [15:0] cipher_k0_input(input [15:0] x); 
    begin: cipher_k0_input_func
        reg     [15:0]      k0_local;

        case (outer_idx)
        2'd0: k0_local = encrypt ? k0_alphaed[15:0]  : k0_alphaed_prime[15:0];
        2'd1: k0_local = encrypt ? k0_alphaed[31:16] : k0_alphaed_prime[31:16];
        2'd2: k0_local = encrypt ? k0_alphaed[47:32] : k0_alphaed_prime[47:32];
        2'd3: k0_local = encrypt ? k0_alphaed[63:48] : k0_alphaed_prime[63:48];
        endcase

        cipher_k0_input = x ^ k0_local;
    end
    endfunction

    function [15:0] cipher_k0_output(input [15:0] x); 
    begin: cipher_k0_output_func
        reg     [15:0]      k0_local;

        case (outer_idx)
        2'd0: k0_local = encrypt ? k0_alphaed_prime[15:0]  : k0_alphaed[15:0];
        2'd1: k0_local = encrypt ? k0_alphaed_prime[31:16] : k0_alphaed[31:16];
        2'd2: k0_local = encrypt ? k0_alphaed_prime[47:32] : k0_alphaed[47:32];
        2'd3: k0_local = encrypt ? k0_alphaed_prime[63:48] : k0_alphaed[63:48];
        endcase

        cipher_k0_output = x ^ k0_local;
    end
    endfunction

    //-----------------------------------------------------------------------------------------------------------------
    // Prince core CFB process
    //-----------------------------------------------------------------------------------------------------------------
    // perform prince core major block: FSM states
    reg     [3:0]       state;
    always @(posedge clk) begin
        if(!rst_n) begin
            state           <= INNER_LOOP_IDLE;
        end else begin
            case (state)
            INNER_LOOP_IDLE: begin
                if(block_start) begin
                    state   <= INNER_LOOP_INPUT;
                end
            end

            INNER_LOOP_INPUT: begin
                state       <= INNER_LOOP_RC_1;
            end

            INNER_LOOP_RC_1: begin
                state       <= INNER_LOOP_RC_2;
            end

            INNER_LOOP_RC_2: begin
                state       <= INNER_LOOP_RC_3;
            end

            INNER_LOOP_RC_3: begin
                state       <= INNER_LOOP_RC_4;
            end

            INNER_LOOP_RC_3: begin
                state       <= INNER_LOOP_RC_4;
            end

            INNER_LOOP_RC_4: begin
                state       <= INNER_LOOP_RC_5;
            end

            INNER_LOOP_RC_5: begin
                state       <= INNER_LOOP_MID;
            end

            INNER_LOOP_MID: begin
                state       <= INNER_LOOP_RC_6;
            end

            INNER_LOOP_RC_6: begin
                state       <= INNER_LOOP_RC_7;
            end

            INNER_LOOP_RC_7: begin
                state       <= INNER_LOOP_RC_8;
            end

            INNER_LOOP_RC_8: begin
                state       <= INNER_LOOP_RC_9;
            end

            INNER_LOOP_RC_9: begin
                state       <= INNER_LOOP_RC_10;
            end

            INNER_LOOP_RC_10: begin
                state       <= INNER_LOOP_DONE;
            end
            
            INNER_LOOP_DONE: begin
                state       <= INNER_LOOP_IDLE;
            end
                
            endcase
        end
    end

    // done signal
    always @(posedge clk) begin
        block_done        <= (state == INNER_LOOP_DONE);
    end

    // perform prince core major block: Change the structure flag which reconfigures the prince core
    reg     [3:0]       struc_flag;
    always @(*) begin
        case (state)
        INNER_LOOP_RC_1, INNER_LOOP_RC_2, INNER_LOOP_RC_3, INNER_LOOP_RC_4, INNER_LOOP_RC_5: begin
            struc_flag    = {1'b0, 1'b0, 1'b0, 1'b0};
        end

        INNER_LOOP_MID: begin
            struc_flag    = {1'b1, 1'b1, 1'b0, 1'b0};
        end

        INNER_LOOP_RC_6, INNER_LOOP_RC_7, INNER_LOOP_RC_8, INNER_LOOP_RC_9, INNER_LOOP_RC_10: begin
            struc_flag    = {1'b1, 1'b1, 1'b1, 1'b1};
        end

        default: begin
            struc_flag    = {1'b1, 1'b0, 1'b0, 1'b1};
        end
        endcase
    end

    // register plain_text value to prevent I/O setup timing violation
    reg     [15:0]      plain_text_r;

    // perform prince core major block: FSM execution
    always @(posedge clk) begin
        case (state)
        INNER_LOOP_IDLE: begin
            plain_text_r    <= plain_text;
        end

        INNER_LOOP_INPUT: begin
            cipher_text     <= cipher_k1_input(cipher_k0_input(plain_text_r));
        end

        INNER_LOOP_RC_1, INNER_LOOP_RC_2, INNER_LOOP_RC_3, INNER_LOOP_RC_4, INNER_LOOP_RC_5, INNER_LOOP_MID, 
        INNER_LOOP_RC_6, INNER_LOOP_RC_7, INNER_LOOP_RC_8, INNER_LOOP_RC_9, INNER_LOOP_RC_10: begin
            cipher_text     <= r_box(cipher_text, state, struc_flag);
        end
        
        INNER_LOOP_DONE: begin
            cipher_text     <= cipher_k0_output(cipher_k1_output(cipher_text));
        end
            
        endcase
    end

endmodule
