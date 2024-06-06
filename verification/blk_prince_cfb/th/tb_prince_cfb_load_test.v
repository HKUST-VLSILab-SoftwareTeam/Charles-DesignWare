`timescale  1ns / 1ps

module tb_prince_cfb_load_test;

// prince_core_outer Parameters
parameter PERIOD  = 10;


// prince_core_outer Inputs
reg   clk                                  = 1 ;
reg   rst_n                                = 0 ;
reg   block_start                          = 0 ;
reg   encrypt                              = 1 ;
reg   [15:0]  chip_id                          ;
reg   [15:0]  plain_text                   = 0 ;
reg   [15:0]  plain_text_gold                  ;

// prince_core_outer Outputs
wire  block_done                           ;
wire  block_busy_n                         ;
wire  [15:0]  cipher_text                  ;

integer i;
reg   [31:0]  test_max_round;
reg   [31:0]  check_point;

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

// one round of load test including encrpyt and then decrpt
task load_test_round();
begin
    // delay as safe valve
    #(2*PERIOD);
    
    // use 32-bit $random to generate random key and text
    chip_id         = $random;
    plain_text_gold = $random;
    plain_text      = plain_text_gold;

    // start to encrypt
    encrypt                 = 1;
    block_start             = 1;
    #(PERIOD) block_start   = 0;
    wait(block_done); #(PERIOD);

    // start to decrypt
    plain_text              = cipher_text;
    encrypt                 = 0;
    block_start             = 1;
    #(PERIOD) block_start   = 0;
    wait(block_done); #(PERIOD);

    // compare the result
    if(cipher_text != plain_text_gold) begin
        $display("ERROR: Decrypted text does not match with the plain text");
        $display("plain_text_gold: %h", plain_text_gold);
        $display("cipher_text: %h", cipher_text);
        $display("chip_id: %h", chip_id);
    end
    
    // delay as safe valve
    #(2*PERIOD);
end
endtask

initial
begin
    wait(rst_n);

    test_max_round = 10000;
    check_point = test_max_round / 20;
    
    for(i = 0; i < test_max_round; i = i + 1) begin: test_loop
        // perform one encrypt than decrpyt with random key and plain text
        load_test_round();

        // print the check point
        if(i % check_point == 0) begin
            $display("Finishes %d percent of load test.", 100*i/test_max_round);
        end
    end

    $display("Finishes %d round of load test. If no error is shown then the test is passed.", i);
    $finish;
end

endmodule