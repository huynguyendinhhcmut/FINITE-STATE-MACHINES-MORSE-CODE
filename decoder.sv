module decoder (
	input logic [2:0] in, //SW
	output logic [3:0] code_o,
	output logic [2:0] size_o
);

always_comb begin
	case (in)
		3'b000:	begin
					code_o = 4'b0010;
					size_o = 3'b010;
					end
					
		3'b001:	begin
					code_o = 4'b0001;
					size_o = 3'b100;
					end
					
		3'b010:	begin
					code_o = 4'b0101;
					size_o = 3'b100;
					end
		
		3'b011:	begin
					code_o = 4'b0001;
					size_o = 3'b011;
					end
					
		3'b100:	begin
					code_o = 4'b0000;
					size_o = 3'b001;
					end
					
		3'b101:	begin
					code_o = 4'b0100;
					size_o = 3'b100;
					end
					
		3'b110:	begin
					code_o = 4'b0011;
					size_o = 3'b011;
					end
					
		3'b111:	begin
					code_o = 4'b0000;
					size_o = 3'b100;
					end
	endcase
end

endmodule : decoder