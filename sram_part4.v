module sram_part4(clk,rstn,we,d,write_add,data,out,a4,a3_0,w4,w3_0);
input clk;
input rstn;
input we;
input [3:0] d;
input [4:0] write_add;
output wire [6:0]data;
output wire [6:0]out;
output wire [6:0]a4;
output wire [6:0]a3_0;
output wire [6:0]w4;
output wire [6:0]w3_0;

reg [4:0]read_add;
wire [3:0]q;
reg clkdiv;
reg [24:0]div;
always@(posedge clk)
begin
div=div+1'b1;
clkdiv=div[24];
end


always@(posedge clkdiv)
begin
if(! rstn)
	read_add=0;
else
	read_add=read_add+1;

end
hexto7segment o2(d,data);
hexto7segment o3(q,out);
hexto7segment3 o1(write_add[4],w4);
hexto7segment o4(write_add[3:0],w3_0);
hexto7segment3 o5(read_add[4],a4);
hexto7segment o6(read_add[3:0],a3_0);


ram2port	ram2port_inst (
	.clock ( clk ),
	.data ( d ),
	.rdaddress ( read_add ),
	.wraddress ( write_add ),
	.wren ( we ),
	.q ( q )
	);

endmodule



module hexto7segment(input  [3:0]x,output reg [6:0]z);
always @*
case (x)
4'b0000 :   z = 7'b1000000;
4'b0001 :   z = 7'b1111001;
4'b0010 :  	z = 7'b0100100;
4'b0011 : 	z = 7'b0110000;
4'b0100 :	z = 7'b0011001;
4'b0101 :	z = 7'b0010010;
4'b0110 :	z = 7'b0000010;
4'b0111 :	z = 7'b1111000;
4'b1000 :   z = 7'b0000000;
4'b1001 :   z = 7'b0010000;
4'b1010 :   z = 7'b0001000;
4'b1011 :   z = 7'b0000011;
4'b1100 :	z = 7'b1000110;
4'b1101 :	z = 7'b0100001;
4'b1110 :	z = 7'b0000110;
4'b1111 :	z = 7'b0001110;
endcase
endmodule

module hexto7segment3(input  x,output reg [6:0]z);
always @*
case (x)
1'b0 :   z = 7'b1000000;
1'b1 :   z = 7'b1111001;

endcase
 
endmodule