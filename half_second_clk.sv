module half_second_clk (
	input logic CLOCK_50,
	output logic half_clk
);

int t=0;
always_ff @(posedge CLOCK_50) begin
	 t = t + 1;
		if (t == 5) begin
			half_clk = 1;
			t = 0;
			end
end

endmodule 