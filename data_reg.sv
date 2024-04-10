module data_reg (
	input logic [3:0] code_in,
	input logic rst, load_i, shift_i, half_clk,
	output logic data,
	output logic [3:0] new_data
);
logic [3:0] temp;

always_ff @(posedge half_clk, negedge rst) begin
	if (~rst) begin
		new_data = 4'bXXXX;
		end
	else	if (load_i) begin
		new_data = code_in;
		temp = code_in;
		end
	else if (shift_i == 1'b1) begin
				data  = temp[0];
				temp = temp >>1;
				new_data = temp;
				end
end

endmodule : data_reg