`ifndef __MY_SEQUENCER__
`define __MY_SEQUENCER__

class my_sequencer extends uvm_sequencer #(uvm_sequence_item);
  `uvm_component_utils(my_sequencer);

  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction
endclass

`endif
