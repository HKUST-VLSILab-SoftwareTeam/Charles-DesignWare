`ifndef _COMMON_DAT_AGENT_
`define _COMMON_DAT_AGENT_
class common_dat_stream_agent#(int DAT_WID = 32) extends uvm_agent;
  `uvm_component_param_utils(common_dat_stream_agent#(DAT_WID))
  uvm_analysis_port #(uvm_sequence_item) ap;

  my_sequencer sqr;
  common_dat_stream_drv#(DAT_WID) drv;
  common_dat_stream_mon#(DAT_WID) mon;

  function new(string name = "common_dat_stream_agent", uvm_component parent = null);
    super.new(name,parent);
  endfunction

  extern virtual function void build_phase(uvm_phase phase);
  extern virtual function void connect_phase(uvm_phase phase);
endclass

function void common_dat_stream_agent::build_phase(uvm_phase phase);
  super.build_phase(phase);
  if(is_active == UVM_ACTIVE)
  begin
    sqr = my_sequencer::type_id::create("sqr",this);
    drv = common_dat_stream_drv#(DAT_WID)::type_id::create("drv", this);
  end
  mon = common_dat_stream_mon#(DAT_WID)::type_id::create("mon", this);
endfunction

function void common_dat_stream_agent::connect_phase(uvm_phase phase);
  super.connect_phase(phase);
  if(is_active == UVM_ACTIVE)
    drv.seq_item_port.connect(sqr.seq_item_export);
  ap = mon.ap;
endfunction
`endif

