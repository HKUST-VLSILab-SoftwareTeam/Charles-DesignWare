`ifndef _SATURATION_CASE1_
`define _SATURATION_CASE1_

class case1_sequence#(int DAT_WID = 32) extends uvm_sequence #(uvm_sequence_item);
  `uvm_object_utils(case1_sequence#(DAT_WID));

  common_dat_transaction#(DAT_WID) m_trans;

  function new(string name = "my_sequence");
    super.new(name);
  endfunction

  extern virtual task body();

endclass

task case1_sequence::body();
  if(starting_phase != null)
    starting_phase.raise_objection(this);
  `uvm_info("TC", "0", UVM_LOW)
  for(int i = 0;i < 1500;i++)
  begin
    `uvm_do(m_trans);
  end
  #1000;
  if(starting_phase != null)
    starting_phase.drop_objection(this);
endtask

class round_case1 extends base_test#(10, 8);
  `uvm_component_utils(round_case1);

  function new(string name = "round_case1", uvm_component parent = null);
    super.new(name, parent);
  endfunction

  extern virtual function void build_phase(uvm_phase phase);
  
endclass

function void round_case1::build_phase(uvm_phase phase);
  super.build_phase(phase);
  uvm_config_db#(uvm_object_wrapper)::set(this,
                                          "env.i_agt.sqr.main_phase",
                                          "default_sequence",
                                          case1_sequence#(10)::type_id::get());
endfunction
`endif
