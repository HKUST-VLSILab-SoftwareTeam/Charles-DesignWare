`ifndef _COMMON_MONITOR_
`define _COMMON_MONITOR_

`define BUS_MON_OP bus
class common_dat_stream_mon#(int DAT_WID = 32) extends uvm_monitor;
  `uvm_component_param_utils(common_dat_stream_mon#(DAT_WID))

  uvm_analysis_port #(uvm_sequence_item) ap;
  virtual common_dat_stream_int#(DAT_WID) bus;
  function new(string name = "common_dat_stream_mon", uvm_component parent = null);
    super.new(name,parent);
//    `uvm_info("USER_TEST_TYPE", get_type_name(),UVM_LOW)
  endfunction

  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    if( !uvm_config_db#(virtual common_dat_stream_int#(DAT_WID))::get(this, "", "bus", bus))
      `uvm_fatal("monitor", "virtual interface must be configured!");
    ap = new("ap", this);
  endfunction

  extern task main_phase(uvm_phase phase);
  extern task collect_one_pkt(uvm_sequence_item tr);
endclass

task common_dat_stream_mon::main_phase(uvm_phase phase);
   common_dat_transaction#(DAT_WID) tr;
   while(1) 
   begin
      tr = new("tr");
      collect_one_pkt(tr);
      ap.write(tr);
   end
endtask

task common_dat_stream_mon::collect_one_pkt(uvm_sequence_item tr);
  common_dat_transaction#(DAT_WID) dst_type;
  bit [DAT_WID - 1 : 0] dat_rd;
  if(!($cast(dst_type, tr)))
    `uvm_fatal("monitor", "convert type error!");

  while(1)
  begin
    @`BUS_MON_OP.clk;
    if(`BUS_MON_OP.dat_en)
      break;
  end
  
  dst_type.dat = `BUS_MON_OP.dat;
  dst_type.valid = 1;
//  `uvm_info("Mon", $sformatf("send dat is %0d", dst_type.dat), UVM_LOW)
endtask

`endif

