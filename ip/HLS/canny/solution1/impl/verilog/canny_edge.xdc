create_clock -name ap_clk -period 6.000 -waveform {0.000 3.000} [get_ports ap_clk]
create_clock -name AXI_LITE_clk -period 12.000 -waveform {0.000 6.000} [get_ports AXI_LITE_clk]

#set_input_delay 0 -clock CLK  [all_inputs]
#set_output_delay 0 -clock CLK [all_outputs]

set_false_path -from [get_cells canny_edge_CONTROL_BUS_s_axi_U/int_rows_V_reg[*]]
set_false_path -from [get_cells canny_edge_CONTROL_BUS_s_axi_U/int_cols_V_reg[*]]
set_false_path -from [get_cells canny_edge_CONTROL_BUS_s_axi_U/int_threshold1_reg[*]]
set_false_path -from [get_cells canny_edge_CONTROL_BUS_s_axi_U/int_threshold2_reg[*]]

