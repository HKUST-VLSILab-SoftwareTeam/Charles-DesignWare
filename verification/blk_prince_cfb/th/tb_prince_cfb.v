`timescale  1ns / 1ps

module tb_prince_cfb;

// prince_core_outer Parameters
parameter PERIOD  = 10;


// prince_core_outer Inputs
reg   clk                                  = 1 ;
reg   rst_n                                = 0 ;
reg   block_start                          = 0 ;
reg   encrypt                              = 1 ;
reg   [15:0]  chip_id                      = 16'h2020;
reg   [15:0]  plain_text                   = 16'h7b0d;

// prince_core_outer Outputs
wire  block_done                           ;
wire  block_busy_n                         ;
wire  [15:0]  cipher_text                  ;


initial
begin
    forever #(PERIOD/2)  clk=~clk;
end

initial
begin
    #(PERIOD*2) rst_n  =  1;
end

prince_cfb  u_prince_cfb (
    .clk                     ( clk                 ),
    .rst_n                   ( rst_n               ),
    .block_start             ( block_start         ),
    .encrypt                 ( encrypt             ),
    .chip_id                 ( chip_id             ),
    .plain_text              ( plain_text   [15:0] ),

    .block_done              ( block_done          ),
    .block_busy_n            ( block_busy_n        ),
    .cipher_text             ( cipher_text  [15:0] )
);

initial
begin
    // encryption
    #(PERIOD*10) block_start = 1;
    #(PERIOD) block_start = 0;
    #(PERIOD*80);

    // decryption
    encrypt = 0;
    plain_text = 16'habd9;
    #(PERIOD*10) block_start = 1;
    #(PERIOD) block_start = 0;
    #(PERIOD*80); 
    
    $finish;
end

endmodule