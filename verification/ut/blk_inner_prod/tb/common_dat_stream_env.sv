`ifndef _COMMON_DAT_ENV_ 
`define _COMMON_DAT_ENV_

class common_dat_stream_env#(int IN_WID = 32, int OUT_WID = 16) extends uvm_env;
  `uvm_component_utils(common_dat_stream_env#(IN_WID, OUT_WID));

  uvm_tlm_analysis_fifo #(uvm_sequence_item) agt_mdl_fifo;
  uvm_tlm_analysis_fifo #(uvm_sequence_item) agt_scb_fifo;
  uvm_tlm_analysis_fifo #(uvm_sequence_item) mdl_scb_fifo;

  common_dat_stream_agent#(IN_WID) i_agt;
  common_dat_stream_agent#(OUT_WID) o_agt;
  round_model#(IN_WID, OUT_WID) mdl;
  common_dat_stream_scoreboard#(OUT_WID) scb;


  function new(string name = "common_dat_stream_env", uvm_component parent);
    super.new(name, parent);
  endfunction

  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    agt_mdl_fifo = new("agt_mdl_fifo", this);
    agt_scb_fifo = new("agt_scb_fifo", this);
    mdl_scb_fifo = new("mdl_scb_fifo", this);
    i_agt = common_dat_stream_agent#(IN_WID)::type_id::create("i_agt", this);
    o_agt = common_dat_stream_agent#(OUT_WID)::type_id::create("o_agt", this);
    i_agt.is_active = UVM_ACTIVE;
    o_agt.is_active = UVM_PASSIVE;
    mdl = round_model#(IN_WID, OUT_WID)::type_id::create("mdl", this);
    scb = common_dat_stream_scoreboard#(OUT_WID)::type_id::create("scb", this);

  endfunction

  function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);

    i_agt.ap.connect(agt_mdl_fifo.analysis_export);
    mdl.port.connect(agt_mdl_fifo.blocking_get_export);

    o_agt.ap.connect(agt_scb_fifo.analysis_export);
    scb.act_port.connect(agt_scb_fifo.blocking_get_export);

    mdl.ap.connect(mdl_scb_fifo.analysis_export);
    scb.exp_port.connect(mdl_scb_fifo.blocking_get_export);
    
  endfunction

endclass

`endif
