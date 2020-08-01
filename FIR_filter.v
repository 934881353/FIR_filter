//�˲���
module FIR_filter(
input clk_in,//50MHz
input reset_p,//�ߵ�ƽ��λ
input [2:0]amp_cnt1,//��ֵ�����ź�1--ֵԽ�������ֵԽ��
input [2:0]amp_cnt2,//��ֵ�����ź�2--ֵԽ�������ֵԽ��
input [15:0]fre_cnt1,//Ƶ�ʿ����ź�1--ֵԽ�����Ƶ��Խ��
input [15:0]fre_cnt2,//Ƶ�ʿ����ź�2--ֵԽ�����Ƶ��Խ��
output [10:0] sin_1,//���Ƶ��1
output [10:0] sin_2,//���Ƶ��2
output [10:0] sin_super,//�����ź�
output [9:0] fir_data//�˲�����
);

wire [10:0] sin_super_buf;
wire clk_100K;
//��Ƶģ�飬50M��Ƶ��100K
div_clk i_div_clk(
. clk_in(clk_in),
. clk_out(clk_100K)
);

wire [7:0] sin_high_out;//���Ƶ��1
wire [7:0] sin_low_out;//���Ƶ��2

//���������������Ҳ�
sin_noise i_sin_noise(
. clk_in(clk_in),//50MHz
. reset_p(reset_p),//�ߵ�ƽ��λ
. fre_cnt1(fre_cnt1),//Ƶ�ʿ����ź�1--ֵԽ�����Ƶ��Խ��
. fre_cnt2(fre_cnt2),//Ƶ�ʿ����ź�2--ֵԽ�����Ƶ��Խ��
. sin_high_out(sin_high_out),//���Ƶ��1
. sin_low_out(sin_low_out)//���Ƶ��2
);

//8��������λ�ṹFIR
FIR i_FIR(
. clk(clk_100K),//100K
. reset_p(reset_p),//�ߵ�ƽ��λ
. data_in(sin_super_buf[10:1]),//�����������Ҳ�
. fir_data(fir_data)//�˲�����
);

assign sin_1=amp_cnt1*sin_high_out;//���Ƶ��1
assign sin_2=amp_cnt2*sin_low_out;//���Ƶ��2
assign sin_super_buf=amp_cnt1*sin_high_out+amp_cnt2*sin_low_out;//�����ź�
assign sin_super=sin_super_buf;
endmodule
