`ifndef _ROUND_MODEL_
`define _ROUND_MODEL_

class round_model#(int IN_WID = 32, int OUT_WID = 16) extends uvm_component;
  `uvm_component_utils(round_model#(IN_WID, OUT_WID));
  uvm_blocking_get_port #(uvm_sequence_item) port;
  uvm_analysis_port  #(uvm_sequence_item) ap;
  
  extern function new( string name, uvm_component parent );
  extern function void build_phase( uvm_phase phase );
  extern virtual task main_phase( uvm_phase phase );

endclass

function round_model::new( string name, uvm_component parent );
  super.new( name, parent );
endfunction

function void round_model::build_phase(uvm_phase phase);
  super.build_phase(phase);
  port = new("port", this);
  ap   = new("ap", this);
endfunction

task round_model::main_phase(uvm_phase phase);
  uvm_sequence_item tmp_get_tr; 
  common_dat_transaction#(IN_WID) get_tr, tr;
  common_dat_transaction#(OUT_WID) new_tr;
  longint origin_dat;
  longint convert_dat;
  int RND_BITS = IN_WID - OUT_WID;
  super.main_phase(phase);

  while(1)
  begin
    port.get(tmp_get_tr);
    if(!($cast(get_tr, tmp_get_tr)))
      `uvm_fatal("model", "convert type error!");

    tr = new();
	tr.copy(get_tr);

    origin_dat = tr.dat;

    origin_dat = origin_dat * 1.0 / (2 ** RND_BITS);
    if(origin_dat >= (2 ** OUT_WID))
      convert_dat = (2 ** OUT_WID) - 1;
    else
      convert_dat = origin_dat;

    new_tr = new("new_tr"); 
    new_tr.dat = convert_dat[OUT_WID - 1 : 0];
    new_tr.valid = 1;
//    new_tr.print();
    ap.write(new_tr);
  end
endtask

`endif
