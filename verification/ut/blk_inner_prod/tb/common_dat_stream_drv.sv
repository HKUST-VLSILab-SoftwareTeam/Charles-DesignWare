`ifndef _COMMON_DRIVER_
`define _COMMON_DRIVER_

`define BUS_DRV_OP bus
class common_dat_stream_drv#(int DAT_WID = 32) extends uvm_driver#(uvm_sequence_item);
  `uvm_component_param_utils(common_dat_stream_drv#(DAT_WID))
  
  virtual common_dat_stream_int#(DAT_WID) bus;

  function new(string name = "common_dat_stream_driver",uvm_component parent = null);
    super.new(name,parent);
  endfunction

  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    if(!uvm_config_db#(virtual common_dat_stream_int#(DAT_WID))::get(this,"","bus",bus))
      `uvm_fatal("driver","virtual interface must be configured!");
  endfunction

  extern task drive_one_pkt(uvm_sequence_item tr);
  extern virtual task main_phase(uvm_phase phase);

endclass

task common_dat_stream_drv::drive_one_pkt(uvm_sequence_item tr);
  common_dat_transaction#(DAT_WID) dst_type;
  if(!($cast(dst_type, tr)))
    `uvm_fatal("driver", "convert type error!");

  @`BUS_DRV_OP.clk;
  if(dst_type.valid)
  begin
    `BUS_DRV_OP.dat_en <= 1'b1;
    `BUS_DRV_OP.dat    <= dst_type.dat; 
  end
  else
  begin
    `BUS_DRV_OP.dat_en <= 1'b0;
  end
endtask


task common_dat_stream_drv::main_phase(uvm_phase phase);
  `BUS_DRV_OP.dat_en <= 1'b0;
  `BUS_DRV_OP.dat    <=  'b0; 
  
  while(!bus.rst_n)
    @`BUS_DRV_OP.clk;
  while(1)
  begin
    seq_item_port.get_next_item(req);
    drive_one_pkt(req);
    seq_item_port.item_done(); 
  end
endtask
`endif
