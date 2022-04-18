module fibonacci_calculator (
	input  [4:0] input_s, 
	input  reset,
	input  begin_fibo, 
	input  clk, 
	output logic done, 
	output logic[15:0] fibo_out);   

	enum {
		RESET,
		WORKING,
		DONE
	} fib_state;

	reg [$bits(fib_state)-1:0] state;
	reg [15:0] n;
	reg [15:0] n_prev;
	wire [15:0] n_next;
	reg [4:0] ctr;
	assign n_next = n + n_prev;

	assign fibo_out = n;
	assign done = state == DONE;

	always_ff @(posedge clk) begin
		unique case (state)
			RESET: begin
				if(begin_fibo) begin
					if(input_s == 5'd1 || input_s == 5'd2) begin
						state <= DONE;
						n <= 16'd1;
					end else begin
						state <= WORKING;
						ctr <= input_s - 5'd2;
					end
				end
			end
			WORKING: begin
				ctr <= ctr - 1;
				n_prev <= n;
				n <= n_next;
				if(ctr == 0)
					state <= DONE;
			end
			DONE:;
		endcase

				
		
		if(reset) begin
			n <= 1;
			n_prev <= 1;
			state <= RESET;
		end
	end
	
endmodule