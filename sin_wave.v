//正弦波发生器
module sin_wave(
input clk,//输入时钟
input rst_p,
output [7:0]sin//输出正弦信号
);

reg [7:0] sin_valu=8'd0;
reg [4:0] count=5'd0;
//波形地址计数
always @(posedge clk)
  begin
    if(rst_p)
      count<=0;
    else
     if(count==5'b11111)
        count<=5'b00000;
     else
        count<=count+5'b00001;   
  end
  
//正弦波发生器
 always @(posedge clk)
  begin
    if(rst_p)
      sin_valu<=8'b10000000;
  else
  case (count)
   5'b00000:sin_valu<=8'b10000000;       
   5'b00001:sin_valu<=8'b10011000;
   5'b00010:sin_valu<=8'b10110000;
   5'b00011:sin_valu<=8'b11000111;
   5'b00100:sin_valu<=8'b11011010;
   5'b00101:sin_valu<=8'b11101010;
   5'b00110:sin_valu<=8'b11110110;
   5'b00111:sin_valu<=8'b11111101;
   5'b01000:sin_valu<=8'b11111111;
   5'b01001:sin_valu<=8'b11111101;
   5'b01010:sin_valu<=8'b11110110;
   5'b01011:sin_valu<=8'b11101010;
   5'b01100:sin_valu<=8'b11011010;
   5'b01101:sin_valu<=8'b11000111;
   5'b01110:sin_valu<=8'b10110001;
   5'b01111:sin_valu<=8'b10011001;
   5'b10000:sin_valu<=8'b10000000;
   5'b10001:sin_valu<=8'b01100111;
   5'b10010:sin_valu<=8'b01001111;
   5'b10011:sin_valu<=8'b00111001;
   5'b10100:sin_valu<=8'b00100101;
   5'b10101:sin_valu<=8'b00010101;
   5'b10110:sin_valu<=8'b00001001;
   5'b10111:sin_valu<=8'b00000010;
   5'b11000:sin_valu<=8'b00000000;
   5'b11001:sin_valu<=8'b00000010;
   5'b11010:sin_valu<=8'b00001001;
   5'b11011:sin_valu<=8'b00010101;
   5'b11100:sin_valu<=8'b00100101;
   5'b11101:sin_valu<=8'b00111000;
   5'b11110:sin_valu<=8'b01001110;
   5'b11111:sin_valu<=8'b01100110;
   default:sin_valu<=8'b11011010;
  endcase
end

assign sin=sin_valu;

endmodule
