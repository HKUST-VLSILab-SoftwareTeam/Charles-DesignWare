###################################################################

# Created by write_sdc on Sat Jun 8 09:19:01 2024

###################################################################
set sdc_version 2.1

set_units -time ns -resistance kOhm -capacitance pF -voltage V -current mA
set_load -pin_load 1 [get_ports {read_data[31]}]
set_load -pin_load 1 [get_ports {read_data[30]}]
set_load -pin_load 1 [get_ports {read_data[29]}]
set_load -pin_load 1 [get_ports {read_data[28]}]
set_load -pin_load 1 [get_ports {read_data[27]}]
set_load -pin_load 1 [get_ports {read_data[26]}]
set_load -pin_load 1 [get_ports {read_data[25]}]
set_load -pin_load 1 [get_ports {read_data[24]}]
set_load -pin_load 1 [get_ports {read_data[23]}]
set_load -pin_load 1 [get_ports {read_data[22]}]
set_load -pin_load 1 [get_ports {read_data[21]}]
set_load -pin_load 1 [get_ports {read_data[20]}]
set_load -pin_load 1 [get_ports {read_data[19]}]
set_load -pin_load 1 [get_ports {read_data[18]}]
set_load -pin_load 1 [get_ports {read_data[17]}]
set_load -pin_load 1 [get_ports {read_data[16]}]
set_load -pin_load 1 [get_ports {read_data[15]}]
set_load -pin_load 1 [get_ports {read_data[14]}]
set_load -pin_load 1 [get_ports {read_data[13]}]
set_load -pin_load 1 [get_ports {read_data[12]}]
set_load -pin_load 1 [get_ports {read_data[11]}]
set_load -pin_load 1 [get_ports {read_data[10]}]
set_load -pin_load 1 [get_ports {read_data[9]}]
set_load -pin_load 1 [get_ports {read_data[8]}]
set_load -pin_load 1 [get_ports {read_data[7]}]
set_load -pin_load 1 [get_ports {read_data[6]}]
set_load -pin_load 1 [get_ports {read_data[5]}]
set_load -pin_load 1 [get_ports {read_data[4]}]
set_load -pin_load 1 [get_ports {read_data[3]}]
set_load -pin_load 1 [get_ports {read_data[2]}]
set_load -pin_load 1 [get_ports {read_data[1]}]
set_load -pin_load 1 [get_ports {read_data[0]}]
create_clock [get_ports clk]  -period 5  -waveform {0 2.5}
group_path -name FEEDTHROUGH  -from [list [get_ports reset_n] [get_ports cs] [get_ports we] [get_ports {address[7]}] [get_ports {address[6]}] [get_ports {address[5]}] [get_ports {address[4]}] [get_ports {address[3]}] [get_ports {address[2]}] [get_ports {address[1]}] [get_ports {address[0]}] [get_ports {write_data[31]}] [get_ports {write_data[30]}] [get_ports {write_data[29]}] [get_ports {write_data[28]}] [get_ports {write_data[27]}] [get_ports {write_data[26]}] [get_ports {write_data[25]}] [get_ports {write_data[24]}] [get_ports {write_data[23]}] [get_ports {write_data[22]}] [get_ports {write_data[21]}] [get_ports {write_data[20]}] [get_ports {write_data[19]}] [get_ports {write_data[18]}] [get_ports {write_data[17]}] [get_ports {write_data[16]}] [get_ports {write_data[15]}] [get_ports {write_data[14]}] [get_ports {write_data[13]}] [get_ports {write_data[12]}] [get_ports {write_data[11]}] [get_ports {write_data[10]}] [get_ports {write_data[9]}] [get_ports {write_data[8]}] [get_ports {write_data[7]}] [get_ports {write_data[6]}] [get_ports {write_data[5]}] [get_ports {write_data[4]}] [get_ports {write_data[3]}] [get_ports {write_data[2]}] [get_ports {write_data[1]}] [get_ports {write_data[0]}]]  -to [list [get_ports {read_data[31]}] [get_ports {read_data[30]}] [get_ports {read_data[29]}] [get_ports {read_data[28]}] [get_ports {read_data[27]}] [get_ports {read_data[26]}] [get_ports {read_data[25]}] [get_ports {read_data[24]}] [get_ports {read_data[23]}] [get_ports {read_data[22]}] [get_ports {read_data[21]}] [get_ports {read_data[20]}] [get_ports {read_data[19]}] [get_ports {read_data[18]}] [get_ports {read_data[17]}] [get_ports {read_data[16]}] [get_ports {read_data[15]}] [get_ports {read_data[14]}] [get_ports {read_data[13]}] [get_ports {read_data[12]}] [get_ports {read_data[11]}] [get_ports {read_data[10]}] [get_ports {read_data[9]}] [get_ports {read_data[8]}] [get_ports {read_data[7]}] [get_ports {read_data[6]}] [get_ports {read_data[5]}] [get_ports {read_data[4]}] [get_ports {read_data[3]}] [get_ports {read_data[2]}] [get_ports {read_data[1]}] [get_ports {read_data[0]}]]
group_path -name REGIN  -from [list [get_ports reset_n] [get_ports cs] [get_ports we] [get_ports {address[7]}] [get_ports {address[6]}] [get_ports {address[5]}] [get_ports {address[4]}] [get_ports {address[3]}] [get_ports {address[2]}] [get_ports {address[1]}] [get_ports {address[0]}] [get_ports {write_data[31]}] [get_ports {write_data[30]}] [get_ports {write_data[29]}] [get_ports {write_data[28]}] [get_ports {write_data[27]}] [get_ports {write_data[26]}] [get_ports {write_data[25]}] [get_ports {write_data[24]}] [get_ports {write_data[23]}] [get_ports {write_data[22]}] [get_ports {write_data[21]}] [get_ports {write_data[20]}] [get_ports {write_data[19]}] [get_ports {write_data[18]}] [get_ports {write_data[17]}] [get_ports {write_data[16]}] [get_ports {write_data[15]}] [get_ports {write_data[14]}] [get_ports {write_data[13]}] [get_ports {write_data[12]}] [get_ports {write_data[11]}] [get_ports {write_data[10]}] [get_ports {write_data[9]}] [get_ports {write_data[8]}] [get_ports {write_data[7]}] [get_ports {write_data[6]}] [get_ports {write_data[5]}] [get_ports {write_data[4]}] [get_ports {write_data[3]}] [get_ports {write_data[2]}] [get_ports {write_data[1]}] [get_ports {write_data[0]}]]
group_path -name REGOUT  -to [list [get_ports {read_data[31]}] [get_ports {read_data[30]}] [get_ports {read_data[29]}] [get_ports {read_data[28]}] [get_ports {read_data[27]}] [get_ports {read_data[26]}] [get_ports {read_data[25]}] [get_ports {read_data[24]}] [get_ports {read_data[23]}] [get_ports {read_data[22]}] [get_ports {read_data[21]}] [get_ports {read_data[20]}] [get_ports {read_data[19]}] [get_ports {read_data[18]}] [get_ports {read_data[17]}] [get_ports {read_data[16]}] [get_ports {read_data[15]}] [get_ports {read_data[14]}] [get_ports {read_data[13]}] [get_ports {read_data[12]}] [get_ports {read_data[11]}] [get_ports {read_data[10]}] [get_ports {read_data[9]}] [get_ports {read_data[8]}] [get_ports {read_data[7]}] [get_ports {read_data[6]}] [get_ports {read_data[5]}] [get_ports {read_data[4]}] [get_ports {read_data[3]}] [get_ports {read_data[2]}] [get_ports {read_data[1]}] [get_ports {read_data[0]}]]
set_input_delay -clock clk  -max 0.5  [get_ports reset_n]
set_input_delay -clock clk  -min 0.3  [get_ports reset_n]
set_input_delay -clock clk  -max 0.5  [get_ports cs]
set_input_delay -clock clk  -min 0.3  [get_ports cs]
set_input_delay -clock clk  -max 0.5  [get_ports we]
set_input_delay -clock clk  -min 0.3  [get_ports we]
set_input_delay -clock clk  -max 0.5  [get_ports {address[7]}]
set_input_delay -clock clk  -min 0.3  [get_ports {address[7]}]
set_input_delay -clock clk  -max 0.5  [get_ports {address[6]}]
set_input_delay -clock clk  -min 0.3  [get_ports {address[6]}]
set_input_delay -clock clk  -max 0.5  [get_ports {address[5]}]
set_input_delay -clock clk  -min 0.3  [get_ports {address[5]}]
set_input_delay -clock clk  -max 0.5  [get_ports {address[4]}]
set_input_delay -clock clk  -min 0.3  [get_ports {address[4]}]
set_input_delay -clock clk  -max 0.5  [get_ports {address[3]}]
set_input_delay -clock clk  -min 0.3  [get_ports {address[3]}]
set_input_delay -clock clk  -max 0.5  [get_ports {address[2]}]
set_input_delay -clock clk  -min 0.3  [get_ports {address[2]}]
set_input_delay -clock clk  -max 0.5  [get_ports {address[1]}]
set_input_delay -clock clk  -min 0.3  [get_ports {address[1]}]
set_input_delay -clock clk  -max 0.5  [get_ports {address[0]}]
set_input_delay -clock clk  -min 0.3  [get_ports {address[0]}]
set_input_delay -clock clk  -max 0.5  [get_ports {write_data[31]}]
set_input_delay -clock clk  -min 0.3  [get_ports {write_data[31]}]
set_input_delay -clock clk  -max 0.5  [get_ports {write_data[30]}]
set_input_delay -clock clk  -min 0.3  [get_ports {write_data[30]}]
set_input_delay -clock clk  -max 0.5  [get_ports {write_data[29]}]
set_input_delay -clock clk  -min 0.3  [get_ports {write_data[29]}]
set_input_delay -clock clk  -max 0.5  [get_ports {write_data[28]}]
set_input_delay -clock clk  -min 0.3  [get_ports {write_data[28]}]
set_input_delay -clock clk  -max 0.5  [get_ports {write_data[27]}]
set_input_delay -clock clk  -min 0.3  [get_ports {write_data[27]}]
set_input_delay -clock clk  -max 0.5  [get_ports {write_data[26]}]
set_input_delay -clock clk  -min 0.3  [get_ports {write_data[26]}]
set_input_delay -clock clk  -max 0.5  [get_ports {write_data[25]}]
set_input_delay -clock clk  -min 0.3  [get_ports {write_data[25]}]
set_input_delay -clock clk  -max 0.5  [get_ports {write_data[24]}]
set_input_delay -clock clk  -min 0.3  [get_ports {write_data[24]}]
set_input_delay -clock clk  -max 0.5  [get_ports {write_data[23]}]
set_input_delay -clock clk  -min 0.3  [get_ports {write_data[23]}]
set_input_delay -clock clk  -max 0.5  [get_ports {write_data[22]}]
set_input_delay -clock clk  -min 0.3  [get_ports {write_data[22]}]
set_input_delay -clock clk  -max 0.5  [get_ports {write_data[21]}]
set_input_delay -clock clk  -min 0.3  [get_ports {write_data[21]}]
set_input_delay -clock clk  -max 0.5  [get_ports {write_data[20]}]
set_input_delay -clock clk  -min 0.3  [get_ports {write_data[20]}]
set_input_delay -clock clk  -max 0.5  [get_ports {write_data[19]}]
set_input_delay -clock clk  -min 0.3  [get_ports {write_data[19]}]
set_input_delay -clock clk  -max 0.5  [get_ports {write_data[18]}]
set_input_delay -clock clk  -min 0.3  [get_ports {write_data[18]}]
set_input_delay -clock clk  -max 0.5  [get_ports {write_data[17]}]
set_input_delay -clock clk  -min 0.3  [get_ports {write_data[17]}]
set_input_delay -clock clk  -max 0.5  [get_ports {write_data[16]}]
set_input_delay -clock clk  -min 0.3  [get_ports {write_data[16]}]
set_input_delay -clock clk  -max 0.5  [get_ports {write_data[15]}]
set_input_delay -clock clk  -min 0.3  [get_ports {write_data[15]}]
set_input_delay -clock clk  -max 0.5  [get_ports {write_data[14]}]
set_input_delay -clock clk  -min 0.3  [get_ports {write_data[14]}]
set_input_delay -clock clk  -max 0.5  [get_ports {write_data[13]}]
set_input_delay -clock clk  -min 0.3  [get_ports {write_data[13]}]
set_input_delay -clock clk  -max 0.5  [get_ports {write_data[12]}]
set_input_delay -clock clk  -min 0.3  [get_ports {write_data[12]}]
set_input_delay -clock clk  -max 0.5  [get_ports {write_data[11]}]
set_input_delay -clock clk  -min 0.3  [get_ports {write_data[11]}]
set_input_delay -clock clk  -max 0.5  [get_ports {write_data[10]}]
set_input_delay -clock clk  -min 0.3  [get_ports {write_data[10]}]
set_input_delay -clock clk  -max 0.5  [get_ports {write_data[9]}]
set_input_delay -clock clk  -min 0.3  [get_ports {write_data[9]}]
set_input_delay -clock clk  -max 0.5  [get_ports {write_data[8]}]
set_input_delay -clock clk  -min 0.3  [get_ports {write_data[8]}]
set_input_delay -clock clk  -max 0.5  [get_ports {write_data[7]}]
set_input_delay -clock clk  -min 0.3  [get_ports {write_data[7]}]
set_input_delay -clock clk  -max 0.5  [get_ports {write_data[6]}]
set_input_delay -clock clk  -min 0.3  [get_ports {write_data[6]}]
set_input_delay -clock clk  -max 0.5  [get_ports {write_data[5]}]
set_input_delay -clock clk  -min 0.3  [get_ports {write_data[5]}]
set_input_delay -clock clk  -max 0.5  [get_ports {write_data[4]}]
set_input_delay -clock clk  -min 0.3  [get_ports {write_data[4]}]
set_input_delay -clock clk  -max 0.5  [get_ports {write_data[3]}]
set_input_delay -clock clk  -min 0.3  [get_ports {write_data[3]}]
set_input_delay -clock clk  -max 0.5  [get_ports {write_data[2]}]
set_input_delay -clock clk  -min 0.3  [get_ports {write_data[2]}]
set_input_delay -clock clk  -max 0.5  [get_ports {write_data[1]}]
set_input_delay -clock clk  -min 0.3  [get_ports {write_data[1]}]
set_input_delay -clock clk  -max 0.5  [get_ports {write_data[0]}]
set_input_delay -clock clk  -min 0.3  [get_ports {write_data[0]}]
set_output_delay -clock clk  -max 0.5  [get_ports {read_data[31]}]
set_output_delay -clock clk  -min 0.3  [get_ports {read_data[31]}]
set_output_delay -clock clk  -max 0.5  [get_ports {read_data[30]}]
set_output_delay -clock clk  -min 0.3  [get_ports {read_data[30]}]
set_output_delay -clock clk  -max 0.5  [get_ports {read_data[29]}]
set_output_delay -clock clk  -min 0.3  [get_ports {read_data[29]}]
set_output_delay -clock clk  -max 0.5  [get_ports {read_data[28]}]
set_output_delay -clock clk  -min 0.3  [get_ports {read_data[28]}]
set_output_delay -clock clk  -max 0.5  [get_ports {read_data[27]}]
set_output_delay -clock clk  -min 0.3  [get_ports {read_data[27]}]
set_output_delay -clock clk  -max 0.5  [get_ports {read_data[26]}]
set_output_delay -clock clk  -min 0.3  [get_ports {read_data[26]}]
set_output_delay -clock clk  -max 0.5  [get_ports {read_data[25]}]
set_output_delay -clock clk  -min 0.3  [get_ports {read_data[25]}]
set_output_delay -clock clk  -max 0.5  [get_ports {read_data[24]}]
set_output_delay -clock clk  -min 0.3  [get_ports {read_data[24]}]
set_output_delay -clock clk  -max 0.5  [get_ports {read_data[23]}]
set_output_delay -clock clk  -min 0.3  [get_ports {read_data[23]}]
set_output_delay -clock clk  -max 0.5  [get_ports {read_data[22]}]
set_output_delay -clock clk  -min 0.3  [get_ports {read_data[22]}]
set_output_delay -clock clk  -max 0.5  [get_ports {read_data[21]}]
set_output_delay -clock clk  -min 0.3  [get_ports {read_data[21]}]
set_output_delay -clock clk  -max 0.5  [get_ports {read_data[20]}]
set_output_delay -clock clk  -min 0.3  [get_ports {read_data[20]}]
set_output_delay -clock clk  -max 0.5  [get_ports {read_data[19]}]
set_output_delay -clock clk  -min 0.3  [get_ports {read_data[19]}]
set_output_delay -clock clk  -max 0.5  [get_ports {read_data[18]}]
set_output_delay -clock clk  -min 0.3  [get_ports {read_data[18]}]
set_output_delay -clock clk  -max 0.5  [get_ports {read_data[17]}]
set_output_delay -clock clk  -min 0.3  [get_ports {read_data[17]}]
set_output_delay -clock clk  -max 0.5  [get_ports {read_data[16]}]
set_output_delay -clock clk  -min 0.3  [get_ports {read_data[16]}]
set_output_delay -clock clk  -max 0.5  [get_ports {read_data[15]}]
set_output_delay -clock clk  -min 0.3  [get_ports {read_data[15]}]
set_output_delay -clock clk  -max 0.5  [get_ports {read_data[14]}]
set_output_delay -clock clk  -min 0.3  [get_ports {read_data[14]}]
set_output_delay -clock clk  -max 0.5  [get_ports {read_data[13]}]
set_output_delay -clock clk  -min 0.3  [get_ports {read_data[13]}]
set_output_delay -clock clk  -max 0.5  [get_ports {read_data[12]}]
set_output_delay -clock clk  -min 0.3  [get_ports {read_data[12]}]
set_output_delay -clock clk  -max 0.5  [get_ports {read_data[11]}]
set_output_delay -clock clk  -min 0.3  [get_ports {read_data[11]}]
set_output_delay -clock clk  -max 0.5  [get_ports {read_data[10]}]
set_output_delay -clock clk  -min 0.3  [get_ports {read_data[10]}]
set_output_delay -clock clk  -max 0.5  [get_ports {read_data[9]}]
set_output_delay -clock clk  -min 0.3  [get_ports {read_data[9]}]
set_output_delay -clock clk  -max 0.5  [get_ports {read_data[8]}]
set_output_delay -clock clk  -min 0.3  [get_ports {read_data[8]}]
set_output_delay -clock clk  -max 0.5  [get_ports {read_data[7]}]
set_output_delay -clock clk  -min 0.3  [get_ports {read_data[7]}]
set_output_delay -clock clk  -max 0.5  [get_ports {read_data[6]}]
set_output_delay -clock clk  -min 0.3  [get_ports {read_data[6]}]
set_output_delay -clock clk  -max 0.5  [get_ports {read_data[5]}]
set_output_delay -clock clk  -min 0.3  [get_ports {read_data[5]}]
set_output_delay -clock clk  -max 0.5  [get_ports {read_data[4]}]
set_output_delay -clock clk  -min 0.3  [get_ports {read_data[4]}]
set_output_delay -clock clk  -max 0.5  [get_ports {read_data[3]}]
set_output_delay -clock clk  -min 0.3  [get_ports {read_data[3]}]
set_output_delay -clock clk  -max 0.5  [get_ports {read_data[2]}]
set_output_delay -clock clk  -min 0.3  [get_ports {read_data[2]}]
set_output_delay -clock clk  -max 0.5  [get_ports {read_data[1]}]
set_output_delay -clock clk  -min 0.3  [get_ports {read_data[1]}]
set_output_delay -clock clk  -max 0.5  [get_ports {read_data[0]}]
set_output_delay -clock clk  -min 0.3  [get_ports {read_data[0]}]
set_input_transition -max 0.1  [get_ports reset_n]
set_input_transition -min 0.1  [get_ports reset_n]
set_input_transition -max 0.1  [get_ports cs]
set_input_transition -min 0.1  [get_ports cs]
set_input_transition -max 0.1  [get_ports we]
set_input_transition -min 0.1  [get_ports we]
set_input_transition -max 0.1  [get_ports {address[7]}]
set_input_transition -min 0.1  [get_ports {address[7]}]
set_input_transition -max 0.1  [get_ports {address[6]}]
set_input_transition -min 0.1  [get_ports {address[6]}]
set_input_transition -max 0.1  [get_ports {address[5]}]
set_input_transition -min 0.1  [get_ports {address[5]}]
set_input_transition -max 0.1  [get_ports {address[4]}]
set_input_transition -min 0.1  [get_ports {address[4]}]
set_input_transition -max 0.1  [get_ports {address[3]}]
set_input_transition -min 0.1  [get_ports {address[3]}]
set_input_transition -max 0.1  [get_ports {address[2]}]
set_input_transition -min 0.1  [get_ports {address[2]}]
set_input_transition -max 0.1  [get_ports {address[1]}]
set_input_transition -min 0.1  [get_ports {address[1]}]
set_input_transition -max 0.1  [get_ports {address[0]}]
set_input_transition -min 0.1  [get_ports {address[0]}]
set_input_transition -max 0.1  [get_ports {write_data[31]}]
set_input_transition -min 0.1  [get_ports {write_data[31]}]
set_input_transition -max 0.1  [get_ports {write_data[30]}]
set_input_transition -min 0.1  [get_ports {write_data[30]}]
set_input_transition -max 0.1  [get_ports {write_data[29]}]
set_input_transition -min 0.1  [get_ports {write_data[29]}]
set_input_transition -max 0.1  [get_ports {write_data[28]}]
set_input_transition -min 0.1  [get_ports {write_data[28]}]
set_input_transition -max 0.1  [get_ports {write_data[27]}]
set_input_transition -min 0.1  [get_ports {write_data[27]}]
set_input_transition -max 0.1  [get_ports {write_data[26]}]
set_input_transition -min 0.1  [get_ports {write_data[26]}]
set_input_transition -max 0.1  [get_ports {write_data[25]}]
set_input_transition -min 0.1  [get_ports {write_data[25]}]
set_input_transition -max 0.1  [get_ports {write_data[24]}]
set_input_transition -min 0.1  [get_ports {write_data[24]}]
set_input_transition -max 0.1  [get_ports {write_data[23]}]
set_input_transition -min 0.1  [get_ports {write_data[23]}]
set_input_transition -max 0.1  [get_ports {write_data[22]}]
set_input_transition -min 0.1  [get_ports {write_data[22]}]
set_input_transition -max 0.1  [get_ports {write_data[21]}]
set_input_transition -min 0.1  [get_ports {write_data[21]}]
set_input_transition -max 0.1  [get_ports {write_data[20]}]
set_input_transition -min 0.1  [get_ports {write_data[20]}]
set_input_transition -max 0.1  [get_ports {write_data[19]}]
set_input_transition -min 0.1  [get_ports {write_data[19]}]
set_input_transition -max 0.1  [get_ports {write_data[18]}]
set_input_transition -min 0.1  [get_ports {write_data[18]}]
set_input_transition -max 0.1  [get_ports {write_data[17]}]
set_input_transition -min 0.1  [get_ports {write_data[17]}]
set_input_transition -max 0.1  [get_ports {write_data[16]}]
set_input_transition -min 0.1  [get_ports {write_data[16]}]
set_input_transition -max 0.1  [get_ports {write_data[15]}]
set_input_transition -min 0.1  [get_ports {write_data[15]}]
set_input_transition -max 0.1  [get_ports {write_data[14]}]
set_input_transition -min 0.1  [get_ports {write_data[14]}]
set_input_transition -max 0.1  [get_ports {write_data[13]}]
set_input_transition -min 0.1  [get_ports {write_data[13]}]
set_input_transition -max 0.1  [get_ports {write_data[12]}]
set_input_transition -min 0.1  [get_ports {write_data[12]}]
set_input_transition -max 0.1  [get_ports {write_data[11]}]
set_input_transition -min 0.1  [get_ports {write_data[11]}]
set_input_transition -max 0.1  [get_ports {write_data[10]}]
set_input_transition -min 0.1  [get_ports {write_data[10]}]
set_input_transition -max 0.1  [get_ports {write_data[9]}]
set_input_transition -min 0.1  [get_ports {write_data[9]}]
set_input_transition -max 0.1  [get_ports {write_data[8]}]
set_input_transition -min 0.1  [get_ports {write_data[8]}]
set_input_transition -max 0.1  [get_ports {write_data[7]}]
set_input_transition -min 0.1  [get_ports {write_data[7]}]
set_input_transition -max 0.1  [get_ports {write_data[6]}]
set_input_transition -min 0.1  [get_ports {write_data[6]}]
set_input_transition -max 0.1  [get_ports {write_data[5]}]
set_input_transition -min 0.1  [get_ports {write_data[5]}]
set_input_transition -max 0.1  [get_ports {write_data[4]}]
set_input_transition -min 0.1  [get_ports {write_data[4]}]
set_input_transition -max 0.1  [get_ports {write_data[3]}]
set_input_transition -min 0.1  [get_ports {write_data[3]}]
set_input_transition -max 0.1  [get_ports {write_data[2]}]
set_input_transition -min 0.1  [get_ports {write_data[2]}]
set_input_transition -max 0.1  [get_ports {write_data[1]}]
set_input_transition -min 0.1  [get_ports {write_data[1]}]
set_input_transition -max 0.1  [get_ports {write_data[0]}]
set_input_transition -min 0.1  [get_ports {write_data[0]}]