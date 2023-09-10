`ifndef _COMMON_DAT_SCB_
`define _COMMON_DAT_SCB_
class common_dat_stream_scoreboard#(int DAT_WID = 32) extends uvm_scoreboard;
  `uvm_component_utils(common_dat_stream_scoreboard#(DAT_WID))
  uvm_sequence_item expect_queue[$];
  uvm_blocking_get_port #(uvm_sequence_item)  exp_port;
  uvm_blocking_get_port #(uvm_sequence_item)  act_port;

  extern function new(string name, uvm_component parent = null);
  extern virtual function void build_phase(uvm_phase phase);
  extern virtual task main_phase(uvm_phase phase);
endclass 

function common_dat_stream_scoreboard::new(string name, uvm_component parent = null);
  super.new(name, parent);
endfunction 

function void common_dat_stream_scoreboard::build_phase(uvm_phase phase);
  super.build_phase(phase);
  exp_port = new("exp_port", this);
  act_port = new("act_port", this);
endfunction 

task common_dat_stream_scoreboard::main_phase(uvm_phase phase);
  uvm_sequence_item get_expect_pre, get_actual_pre, tmp_tran_pre;
  common_dat_transaction#(DAT_WID) get_actual, tmp_tran;
  bit result;
 
  super.main_phase(phase);
  fork 
    while(1)
    begin
      exp_port.get(get_expect_pre);
      expect_queue.push_back(get_expect_pre);
    end
    while(1)
    begin
      act_port.get(get_actual_pre);
      if(expect_queue.size() > 0) begin
        tmp_tran_pre = expect_queue.pop_front();
        
        if(!($cast(tmp_tran, tmp_tran_pre)))
          `uvm_fatal("scorebroad", "convert type error!");
        if(!($cast(get_actual, get_actual_pre)))
          `uvm_fatal("scorebroad", "convert type error!");

        result = get_actual.compare(tmp_tran);
        if(result)
        begin 
          `uvm_info("common_dat_stream_scoreboard", "Compare SUCCESSFULLY", UVM_LOW);
        end
        else 
        begin
          `uvm_error("common_dat_stream_scoreboard", "Compare FAILED");
          $display("the expect pkt is");
          tmp_tran.print();
          $display("the actual pkt is");
          get_actual.print();
        end
      end
      else
      begin
        `uvm_error("common_dat_stream_scoreboard", "Received from DUT, while Expect Queue is empty");
        $display("the unexpected pkt is");
        get_actual.print();
      end 
    end
  join
endtask
`endif
