`timescale  1ns / 1ps

module tb_prince_core;

// prince_core_inner Parameters
parameter PERIOD  = 10;


// prince_core_inner Inputs
reg   clk                                  = 1 ;
reg   rst_n                                = 0 ;
reg   encrypt                              = 0 ;
reg   block_start                          = 0 ;
reg   [1:0]  outer_idx                     = 2'd3 ;
reg   [63:0]  k0                           = 64'hFFFFFFFFFFFFFFFF ;
reg   [63:0]  k1                           = 0 ;
reg   [15:0]  plain_text                   = 16'hf270 ;

// prince_core_inner Outputs
wire  block_done                           ;
wire  [15:0]  cipher_text                  ;


initial
begin
    forever #(PERIOD/2)  clk=~clk;
end

initial
begin
    #(PERIOD*2) rst_n  =  1;
end

prince_core  u_prince_core (
    .clk                     ( clk                 ),
    .rst_n                   ( rst_n               ),
    .encrypt                 ( encrypt             ),
    .block_start             ( block_start         ),
    .outer_idx               ( outer_idx    [1:0]  ),
    .k0                      ( k0           [63:0] ),
    .k1                      ( k1           [63:0] ),
    .plain_text              ( plain_text   [15:0] ),

    .block_done              ( block_done          ),
    .cipher_text             ( cipher_text  [15:0] )
);

initial
begin
    #(PERIOD*5)
    #(PERIOD) block_start = 1;
    #(PERIOD) block_start = 0;

    wait(block_done);
    #(PERIOD*5)
    plain_text = 16'h4465;
    outer_idx = 2'd2;
    #(PERIOD) block_start = 1;
    #(PERIOD) block_start = 0;

    wait(block_done);
    #(PERIOD*5)
    plain_text = 16'h460b;
    outer_idx = 2'd1;
    #(PERIOD) block_start = 1;
    #(PERIOD) block_start = 0;
   
    wait(block_done);
    #(PERIOD*5)
    plain_text = 16'hd5b2;
    outer_idx = 2'd0;
    #(PERIOD) block_start = 1;
    #(PERIOD) block_start = 0;
    
    wait(block_done);
    #(PERIOD*5)
    $finish;
end

endmodule
