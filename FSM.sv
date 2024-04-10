module FSM (
	input logic CLOCK_50, rst, load_i,	//enable=1 khi size!=0
	input logic [2:0] new_size,
	output logic shift_o, dis, k, load_o,
	output logic [1:0] state
);

typedef enum logic [1:0] {IDLE = 2'b00,
								INPUT = 2'b01,
								DISPLAY = 2'b10} state_t;
logic [1:0] prestate, nextstate;

always_ff @(posedge CLOCK_50, negedge rst) begin
	if (~rst) begin
		prestate <= IDLE;
		end
	else begin
		prestate <= nextstate;
		end
end

always @(*) begin
	case (prestate)
		IDLE:		begin
						if (load_i) begin
							nextstate = IDLE;
							shift_o = 1'b0;
							load_o = 1'b0;
							end
						else if (~load_i) begin
							nextstate = INPUT;
							shift_o = 1'b0;
							load_o = 1'b1;
							end
					end
		
		INPUT:	begin
						if (new_size == 3'b000) begin
							nextstate = IDLE;
							shift_o = 1'b0;
							load_o = 1'b0;
							end
						else if (k == 1'b0) begin
								nextstate = INPUT;
								shift_o = 1'b0;
								load_o = 1'b0;
								end
							else if (k == 1'b1) begin
								nextstate = DISPLAY;
								shift_o = 1'b1;
								load_o = 1'b0;
								end
					end
		
		DISPLAY:	begin
						if (k == 1'b0) begin
							nextstate = DISPLAY;
							shift_o = 1'b0;
							load_o = 1'b0;
							end
						else if (k == 1'b1) begin
							nextstate = INPUT;
							shift_o = 1'b0;
							load_o = 1'b0;
							end
					end
	endcase
end

assign dis = (prestate == DISPLAY);

// tạo tín hiệu k=1 trong 1/50M giây sau mỗi 0,5s
int t=0;
always_ff @(posedge CLOCK_50) begin
	 t = t + 1;
		if (t == 2) begin
			t = 0;
			end
end
assign k = (t == 0) ? 1 : 0;
endmodule : FSM