//�������Ҳ�
module sin_noise(
input clk_in,//50MHz
input reset_p,//�ߵ�ƽ��λ
input [15:0]fre_cnt1,//Ƶ�ʿ����ź�1--ֵԽ�����Ƶ��Խ��--52
input [15:0]fre_cnt2,//Ƶ�ʿ����ź�2--ֵԽ�����Ƶ��Խ��--1562��
output [7:0] sin_high_out,//���Ƶ��1
output [7:0] sin_low_out//���Ƶ��2
);
//����2��Ƶ�ʵ����Ҳ���Ȼ�������ϳɴ����������Ҳ�
//����2����ͬƵ�ʵ����Ҳ�
wire clk_high;
wire clk_low;
reg [7:0] count_1=8'd0;
reg [15:0] count_2=16'd0;
//��Ƶ����ʱ��1
always@(posedge clk_in or posedge reset_p)
	if(reset_p)
		count_1<=8'd0;
	else
		if(count_1>=fre_cnt1)
			count_1<=8'd0;
		else
			count_1<=count_1+8'd1;
			
assign clk_high= (count_1>=fre_cnt1/2)?1:0;

//��Ƶ����ʱ��2
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
//�������Ҳ�������
sin_wave i1_sin_wave(
. clk(clk_high),//����ʱ��
. rst_p(reset_p),
. sin(sin_high)//��������ź�Ƶ�ʵ���clk/32
);

//�������Ҳ�������
sin_wave i2_sin_wave(
. clk(clk_low),//����ʱ��
. rst_p(reset_p),
. sin(sin_low)//��������ź�Ƶ�ʵ���clk/32
);

assign sin_high_out=sin_high;
assign sin_low_out=sin_low;

endmodule
