`ifndef _COMMON_DAT_STREAM_
`define _COMMON_DAT_STREAM_

interface common_dat_stream_int
#(
  int DAT_WID = 32
)
(input clk,input rst_n);

  bit [DAT_WID - 1 : 0] dat    ;
  bit                   dat_en ;

endinterface
`endif
