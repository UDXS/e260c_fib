set clk_period 0.5
set io_delay 0.2 

create_clock -name clk -period $clk_period [get_ports clk]

set_input_delay  $io_delay -clock clk [all_inputs] 
set_output_delay $io_delay -clock clk [all_outputs]
