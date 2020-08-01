//8阶线性相位结构FIR
module FIR(
input clk,//100K
input reset_p,//高电平复位
input  [9:0]data_in,//叠加信号
output [9:0]fir_data//滤波后结果
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

//设计截止频率10K的低通滤波器，时钟为100KHz，100K*0.1=10K
//m=fir1(7,0.2),fir1为matlab中滤波器设计函数，7表示滤波器阶数为7，0.2表示截止频率为100K*0.1=10K
//滤波器系数设计:打开Matlab软件在指令窗口中键入:m=fir1(7,0.2)，即可得到如下的系数:
//0.009、0.048、0.164、0.279、0.279、0.164、0.048、0.009
//将系数放大1000倍即：9,48,164,279;乘加计算计算完成后再除以1000.

//乘加计算
assign mul_data_1=9*(shift_data_0+shift_data_7);//线性结构，对称结构
assign mul_data_2=48*(shift_data_1+shift_data_6);
assign mul_data_3=164*(shift_data_2+shift_data_5);
assign mul_data_4=279*(shift_data_3+shift_data_4); 
assign add_data=(mul_data_1+mul_data_2+mul_data_3+mul_data_4)/1000;//累加，再除以1000.
assign fir_data=add_data[9:0];//滤波后结果

//移位寄存器，每个时钟移位一次
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
