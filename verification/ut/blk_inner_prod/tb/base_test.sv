`ifndef _BASE_TEST_
`define _BASE_TEST_

class base_test#(int IN_WID = 32, int OUT_WID = 16) extends uvm_test;
  `uvm_component_utils(base_test#(IN_WID, OUT_WID));
  
  common_dat_stream_env#(IN_WID, OUT_WID) env;

  function new(string name = "base_test", uvm_component parent = null);
    super.new(name, parent);
  endfunction

  extern virtual function void build_phase(uvm_phase phase);
  extern virtual function void report_phase(uvm_phase phase);
  
endclass

function void base_test::build_phase(uvm_phase phase);
  super.build_phase(phase);
  env = common_dat_stream_env#(IN_WID, OUT_WID)::type_id::create("env",this);
endfunction

function void base_test::report_phase(uvm_phase phase);
  uvm_report_server server;
  int error_num;
  super.report_phase(phase);

  server = get_report_server();
  error_num = server.get_severity_count(UVM_ERROR);

  if(error_num != 0)
    $display("TEST CASE FAILED");
  else
    $display("TEST CASE PASSED");

endfunction
`endif
