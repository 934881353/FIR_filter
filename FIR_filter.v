//滤波器
module FIR_filter(
input clk_in,//50MHz
input reset_p,//高电平复位
input [2:0]amp_cnt1,//幅值控制信号1--值越大输出幅值越高
input [2:0]amp_cnt2,//幅值控制信号2--值越大输出幅值越高
input [15:0]fre_cnt1,//频率控制信号1--值越大输出频率越低
input [15:0]fre_cnt2,//频率控制信号2--值越大输出频率越低
output [10:0] sin_1,//输出频率1
output [10:0] sin_2,//输出频率2
output [10:0] sin_super,//叠加信号
output [9:0] fir_data//滤波后结果
);

wire [10:0] sin_super_buf;
wire clk_100K;
//分频模块，50M分频到100K
div_clk i_div_clk(
. clk_in(clk_in),
. clk_out(clk_100K)
);

wire [7:0] sin_high_out;//输出频率1
wire [7:0] sin_low_out;//输出频率2

//产生带噪声的正弦波
sin_noise i_sin_noise(
. clk_in(clk_in),//50MHz
. reset_p(reset_p),//高电平复位
. fre_cnt1(fre_cnt1),//频率控制信号1--值越大输出频率越低
. fre_cnt2(fre_cnt2),//频率控制信号2--值越大输出频率越低
. sin_high_out(sin_high_out),//输出频率1
. sin_low_out(sin_low_out)//输出频率2
);

//8阶线性相位结构FIR
FIR i_FIR(
. clk(clk_100K),//100K
. reset_p(reset_p),//高电平复位
. data_in(sin_super_buf[10:1]),//带噪声的正弦波
. fir_data(fir_data)//滤波后结果
);

assign sin_1=amp_cnt1*sin_high_out;//输出频率1
assign sin_2=amp_cnt2*sin_low_out;//输出频率2
assign sin_super_buf=amp_cnt1*sin_high_out+amp_cnt2*sin_low_out;//叠加信号
assign sin_super=sin_super_buf;
endmodule
