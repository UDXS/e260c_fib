module fibonacci_tb ();
    reg [15:0] fib_tab [24];

    reg [4:0] input_s;
    reg reset;
    reg begin_fibo;
    reg clk;
    wire done;
    wire [15:0] fibo_out;

    fibonacci_calculator dut (
	    input_s, 
	    reset,
	    begin_fibo, 
	    clk, 
	    done, 
	    fibo_out);  

    integer tab_file;
    integer i;
    integer clock_ctr;

    initial begin
        #1 clk = 0;

        $display ("Fibonacci Testbench");
        $display ("D. Markarian, 2022");
        $display("======");

        tab_file = $fopen("../test/table.txt");
        for(i = 0; i < 24; i++) begin
            $fscanf(tab_file, "%d", fib_tab[i]);
        end
        for (i = 0; i < 24; i++) begin

            #1 clk = 1;
            #1 clk = 0;
            reset = 1;
            #1 clk = 1;
            #1 clk = 0;
            reset = 0;

            input_s = i[4:0];
            begin_fibo = 1;

            #1 clk = 1;
            #1 clk = 0;
            
            begin_fibo = 0;

            clock_ctr = 1;
            while(!done) begin
                #1 clk = 1;
                #1 clk = 0;        
                clock_ctr = clock_ctr + 1;
            end

            $display ("%d-th Fibonacci: E(%d) ?= %d. t = %d cycles.", i, fib_tab[i], fibo_out, clock_ctr);
            if(fib_tab[i] ==  fibo_out)
                $display("\t- PASS");
            else
                $display("\t- FAIL");
        end

        $display("======");
    end

endmodule