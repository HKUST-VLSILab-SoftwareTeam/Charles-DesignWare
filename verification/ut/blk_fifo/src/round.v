
module round
#(
  parameter IN_WID  = 16,                 //input width
  parameter OUT_WID = 10                  //output width
)
(
  input                        clk     ,   //clock
  input                        rst_n   ,   //reset
  input      [IN_WID - 1 : 0]  dat_i   ,   //dat input
  input                        dat_i_en,   //dat input enable
  output reg [OUT_WID - 1 : 0] dat_o   ,   //dat output
  output                       dat_o_en    //dat output enable
);

localparam TRUNC_BITS = IN_WID - OUT_WID; //reduce bits

wire [IN_WID - 1 : 0] addend;             //add value
reg  [IN_WID - 1 : 0] out_tmp;            //output tmp
reg  [1:0]            dly_tmp;            //delay 

wire [OUT_WID - 1 : 0] msxb;          //direct right shift value

assign msxb = dat_i >> TRUNC_BITS;    //获取高位结果

if(TRUNC_BITS == 1)
begin
  assign addend = {{{OUT_WID}{1'b0}}, 1'b1};    //待输出数据的下一位加1
end
else
begin
  assign addend = {{{OUT_WID}{1'b0}}, 1'b1, {{TRUNC_BITS - 1}{1'b0}}};//待输出数据的下一位加1
end

always @(posedge clk or negedge rst_n)
if(!rst_n)
  out_tmp <= {{IN_WID}{1'b0}};
else if((&msxb) == 1'b1)             //结果已经是最大值无需处理
  out_tmp <= dat_i;
else                                 //输入数据+'0.5',处理进位
  out_tmp <= dat_i + addend;

//输出截位
always @(posedge clk or negedge rst_n)
if(!rst_n)
  dat_o <= {{OUT_WID}{1'b0}};
else
  dat_o <= out_tmp[IN_WID - 1 : TRUNC_BITS];

//使能信号延时
always @(posedge clk or negedge rst_n)
if(!rst_n)
  dly_tmp <= 2'b00;
else
  dly_tmp <= {dly_tmp[0], dat_i_en};

assign dat_o_en = dly_tmp[1];

endmodule
