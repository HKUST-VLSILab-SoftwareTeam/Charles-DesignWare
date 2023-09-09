`ifndef _SATURATION_CASE0_
`define _SATURATION_CASE0_

class case0_sequence#(int DAT_WID = 10) extends uvm_sequence #(uvm_sequence_item);
  `uvm_object_utils(case0_sequence#(DAT_WID));

  common_dat_transaction#(DAT_WID) m_trans;

  function new(string name = "my_sequence");
    super.new(name);
  endfunction

  extern virtual task body();

endclass

task case0_sequence::body();
  if(starting_phase != null)
    starting_phase.raise_objection(this);
  `uvm_info("TC", "0 start", UVM_LOW)
  for(int i = 0;i < 1025;i++)
  begin
      `uvm_do_with(m_trans, {dat == i[DAT_WID - 1 : 0]; valid == 1;});
  end
  `uvm_info("TC", "0 done", UVM_LOW)
  #1000ns;
  if(starting_phase != null)
    starting_phase.drop_objection(this);
endtask

class round_case0 extends base_test#(10, 8);
  `uvm_component_utils(round_case0);

  function new(string name = "round_case0", uvm_component parent = null);
    super.new(name, parent);
  endfunction

  extern virtual function void build_phase(uvm_phase phase);
  
endclass

function void round_case0::build_phase(uvm_phase phase);
  super.build_phase(phase);
  uvm_config_db#(uvm_object_wrapper)::set(this,
                                          "env.i_agt.sqr.main_phase",
                                          "default_sequence",
                                          case0_sequence#(10)::type_id::get());
endfunction
`endif
