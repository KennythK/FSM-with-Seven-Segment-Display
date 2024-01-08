//Timer module
module timer_module(clock, reset, slow_clock);

parameter lowcount = 10000000;

input clock, reset;
output reg slow_clock;
reg [30:0]count;
always @(negedge reset, posedge clock)
	if(!reset)
		begin
		count <= 0;
		slow_clock <= 0;
		end
	else if (count==lowcount)
		begin
		count <= 0;
		slow_clock <= !slow_clock;
		end
	else
		count <= count + 1;
endmodule

//Counter module
module counter(clock, reset, updown, resetn, count);
input clock, reset, updown, resetn;
output reg [7:0]count = 0;

always @(negedge reset, posedge clock)
	if(!reset)
		count <= 0;
	else if(resetn)
		begin
			if(updown == 1)
				if(count < 9)
				count <= count + 1;
				else
				count <= 0;
					
			else if(updown == 0)
				if(count > 0)
				count <= count - 1;
				else
				count <= 9;
			end

endmodule

//Seven Segment Display
module seven_segment(q,h);
input[3:0]q;
output[6:0]h;

assign h[0] = (q[2] & ~q[1] & ~q[0]) + (~q[3] & ~q[2] & ~q[1] & q[0]);
assign h[1] = (q[2] & (q[1] ^ q[0]));
assign h[2] = ~q[2] & q[1] & ~q[0];
assign h[3] = (q[2] & ~q[1] & ~q[0]) + (~q[2] & ~q[1] & q[0]) + (q[2] & q[1] & q[0]);
assign h[4] = (q[0]) +(q[2] & ~q[1]);
assign h[5] = (~q[2] & q[1]) + (q[1] & q[0]) + (~q[3] & ~q[2] & q[0]);
assign h[6] = (~q[3] & ~q[2] & ~q[1]) + (q[1] & q[2] & q[0]);

endmodule

module segments(q, h);
input[3:0]q;
output reg[6:0]h;
	always@(q)
		case(q)
		
		0: h = 7'b1111110;
		1: h = 7'b0110000;
		2: h = 7'b1101101;
		3: h = 7'b1111001;
		4: h = 7'b0110011;
		5: h = 7'b1011011;
		6: h = 7'b1011111;
		7: h = 7'b1110000;
		8: h = 7'b1111111;
		9: h = 7'b1111011;
	endcase
endmodule