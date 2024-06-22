`timescale 1ns/1ps
`include "uvm_macros.svh"
import uvm_pkg::*;

`include "common_dat_stream_int.sv"
`include "common_dat_transaction.sv"
`include "common_dat_stream_drv.sv"
`include "common_dat_stream_mon.sv"
`include "my_sequencer.sv"
`include "common_dat_stream_agent.sv"
`include "round_model.sv"
`include "common_dat_stream_scoreboard.sv"
`include "common_dat_stream_env.sv"
`include "base_test.sv"
`include "round_case0.sv"
`include "round_case1.sv"

module top_tb();

  bit clk;
  always #5 clk = !clk;

  bit rst_n;
  logic dat_ovf;
  common_dat_stream_int #(10) bus_in (.clk(clk),.rst_n(rst_n));
  common_dat_stream_int #(8) bus_out (.clk(clk),.rst_n(rst_n));

  round
  #(
    .IN_WID  ( 10),                 //input width
    .OUT_WID ( 8 )                  //output width
  )round_inst
  (
    .clk     (clk     ),   //clock
    .rst_n   (rst_n   ),   //reset
    .dat_i   (bus_in.dat),   //dat input
    .dat_i_en(bus_in.dat_en),   //dat input
    .dat_o   (bus_out.dat),   //dat output
    .dat_o_en(bus_out.dat_en)   //over signal
  );

  initial
  begin
    //run_test("my_case0");
    run_test();
  end

  string test_name;   //test name
  string wave_path;   //wave_path
  string wave_type;   //wave_type
  string wave_name;   //wave_name
  initial
  begin
    $value$plusargs("UVM_TESTNAME=%s", test_name);    
    $value$plusargs("WAVE_PATH=%s", wave_path);    
    $value$plusargs("WAVE_TYPE=%s", wave_type);    
    wave_name = $sformatf("%s//%s.%s", wave_path, test_name, wave_type);
    `uvm_info("SIM name:", test_name, UVM_LOW)
	if(wave_type == "fsdb") begin
      `uvm_info("wave name:", wave_name, UVM_LOW)
      $fsdbDumpfile(wave_name);
      $fsdbDumpvars(0);
    end
  end

  initial
  begin
	#100 rst_n = 1;
  end

  initial
  begin
    uvm_config_db#(virtual common_dat_stream_int#(10))::set(null,"uvm_test_top.env.i_agt.drv","bus",bus_in);
    uvm_config_db#(virtual common_dat_stream_int#(10))::set(null,"uvm_test_top.env.i_agt.mon","bus",bus_in);
    uvm_config_db#(virtual common_dat_stream_int#(8))::set(null,"uvm_test_top.env.o_agt.mon","bus",bus_out);
  end

endmodule
