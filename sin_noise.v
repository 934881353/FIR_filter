//产生正弦波
module sin_noise(
input clk_in,//50MHz
input reset_p,//高电平复位
input [15:0]fre_cnt1,//频率控制信号1--值越大输出频率越低--52
input [15:0]fre_cnt2,//频率控制信号2--值越大输出频率越低--1562、
output [7:0] sin_high_out,//输出频率1
output [7:0] sin_low_out//输出频率2
);
//产生2个频率的正弦波，然后叠加组合成带噪声的正弦波
//产生2个不同频率的正弦波
wire clk_high;
wire clk_low;
reg [7:0] count_1=8'd0;
reg [15:0] count_2=16'd0;
//分频产生时钟1
always@(posedge clk_in or posedge reset_p)
	if(reset_p)
		count_1<=8'd0;
	else
		if(count_1>=fre_cnt1)
			count_1<=8'd0;
		else
			count_1<=count_1+8'd1;
			
assign clk_high= (count_1>=fre_cnt1/2)?1:0;

//分频产生时钟2
always@(posedge clk_in or posedge reset_p)
	if(reset_p)
		count_2<=16'd0;
	else
		if(count_2>=fre_cnt2)
			count_2<=16'd0;
		else
			count_2<=count_2+16'd1;

assign clk_low= (count_2>=fre_cnt2/2)?1:0;

wire [7:0] sin_high;
wire [7:0] sin_low;
//调用正弦波发生器
sin_wave i1_sin_wave(
. clk(clk_high),//输入时钟
. rst_p(reset_p),
. sin(sin_high)//输出正弦信号频率等于clk/32
);

//调用正弦波发生器
sin_wave i2_sin_wave(
. clk(clk_low),//输入时钟
. rst_p(reset_p),
. sin(sin_low)//输出正弦信号频率等于clk/32
);

assign sin_high_out=sin_high;
assign sin_low_out=sin_low;

endmodule
