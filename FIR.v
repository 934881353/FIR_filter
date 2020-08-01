//8��������λ�ṹFIR
module FIR(
input clk,//100K
input reset_p,//�ߵ�ƽ��λ
input  [9:0]data_in,//�����ź�
output [9:0]fir_data//�˲�����
);
wire [31:0] mul_data_1;
wire [31:0] mul_data_2;
wire [31:0] mul_data_3;
wire [31:0] mul_data_4;
wire [31:0]add_data;
reg  [9:0] shift_data_0=10'd0;
reg  [9:0] shift_data_1=10'd0;
reg  [9:0] shift_data_2=10'd0;
reg  [9:0] shift_data_3=10'd0;
reg  [9:0] shift_data_4=10'd0;
reg  [9:0] shift_data_5=10'd0;
reg  [9:0] shift_data_6=10'd0;
reg  [9:0] shift_data_7=10'd0;

//��ƽ�ֹƵ��10K�ĵ�ͨ�˲�����ʱ��Ϊ100KHz��100K*0.1=10K
//m=fir1(7,0.2),fir1Ϊmatlab���˲�����ƺ�����7��ʾ�˲�������Ϊ7��0.2��ʾ��ֹƵ��Ϊ100K*0.1=10K
//�˲���ϵ�����:��Matlab�����ָ����м���:m=fir1(7,0.2)�����ɵõ����µ�ϵ��:
//0.009��0.048��0.164��0.279��0.279��0.164��0.048��0.009
//��ϵ���Ŵ�1000������9,48,164,279;�˼Ӽ��������ɺ��ٳ���1000.

//�˼Ӽ���
assign mul_data_1=9*(shift_data_0+shift_data_7);//���Խṹ���Գƽṹ
assign mul_data_2=48*(shift_data_1+shift_data_6);
assign mul_data_3=164*(shift_data_2+shift_data_5);
assign mul_data_4=279*(shift_data_3+shift_data_4); 
assign add_data=(mul_data_1+mul_data_2+mul_data_3+mul_data_4)/1000;//�ۼӣ��ٳ���1000.
assign fir_data=add_data[9:0];//�˲�����

//��λ�Ĵ�����ÿ��ʱ����λһ��
always @(posedge clk or posedge reset_p)
    begin
        if(reset_p)
        begin
            shift_data_0<=10'd0;
            shift_data_1<=10'd0;
            shift_data_2<=10'd0;
            shift_data_3<=10'd0;
            shift_data_4<=10'd0;
            shift_data_5<=10'd0;
            shift_data_6<=10'd0;
            shift_data_7<=10'd0;
        end
        else
        begin
			shift_data_0<=data_in;
            shift_data_1<=shift_data_0;
            shift_data_2<=shift_data_1;
            shift_data_3<=shift_data_2;
            shift_data_4<=shift_data_3;
            shift_data_5<=shift_data_4;
            shift_data_6<=shift_data_5;
            shift_data_7<=shift_data_6;
        end
    end
endmodule
