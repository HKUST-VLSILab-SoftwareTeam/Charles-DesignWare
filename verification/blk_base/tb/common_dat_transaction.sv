`ifndef _COMMON_DAT_TRANSACTION_
`define _COMMON_DAT_TRANSACTION_

class common_dat_transaction#(int DAT_WID=32) extends uvm_sequence_item;
  rand bit [DAT_WID - 1 : 0] dat;
  rand bit valid;

  function new(string name = "common_dat_transaction");
    super.new(name);
  endfunction

   `uvm_object_param_utils_begin(common_dat_transaction#(DAT_WID))
      `uvm_field_int(dat, UVM_ALL_ON)
      `uvm_field_int(valid, UVM_ALL_ON | UVM_NOCOMPARE)
   `uvm_object_utils_end

endclass

`endif

