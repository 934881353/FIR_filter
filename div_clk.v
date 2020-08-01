//分频模块，50M分频到100K
module div_clk(
input clk_in,
output reg clk_out
);

reg [15:0] count=16'd0;
always@(posedge clk_in)
	if(count>=16'd500)//50_000K/100K=500
		count<=16'd0;
	else
		count<=count+16'd1;
	
always@(posedge clk_in)
	if(count>=16'd250)
		clk_out<=1;
	else	
		clk_out<=0;

endmodule





