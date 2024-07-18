set_property PACKAGE_PIN Y9 [get_ports clk]
set_property IOSTANDARD LVCMOS33 [get_ports clk]
create_clock -period 10.000 -name clk -waveform {0.000 5.000} [get_ports clk]


set_property PACKAGE_PIN V20 [get_ports R]
set_property PACKAGE_PIN U20 [get_ports R]
set_property PACKAGE_PIN V19 [get_ports R]
set_property PACKAGE_PIN V18 [get_ports R]

set_property PACKAGE_PIN AB22 [get_ports G]
set_property PACKAGE_PIN AA22 [get_ports G]
set_property PACKAGE_PIN AB21 [get_ports G]
set_property PACKAGE_PIN AA21 [get_ports G]

set_property PACKAGE_PIN Y21 [get_ports B]
set_property PACKAGE_PIN Y20 [get_ports B]
set_property PACKAGE_PIN AB20 [get_ports B]
set_property PACKAGE_PIN AB19 [get_ports B]

set_property IOSTANDARD LVCMOS33 [get_ports R]
set_property IOSTANDARD LVCMOS33 [get_ports R]
set_property IOSTANDARD LVCMOS33 [get_ports R]
set_property IOSTANDARD LVCMOS33 [get_ports R]

set_property IOSTANDARD LVCMOS33 [get_ports G]
set_property IOSTANDARD LVCMOS33 [get_ports G]
set_property IOSTANDARD LVCMOS33 [get_ports G]
set_property IOSTANDARD LVCMOS33 [get_ports G]

set_property IOSTANDARD LVCMOS33 [get_ports B]
set_property IOSTANDARD LVCMOS33 [get_ports B]
set_property IOSTANDARD LVCMOS33 [get_ports B]
set_property IOSTANDARD LVCMOS33 [get_ports B]


set_property PACKAGE_PIN AA19 [get_ports h_sync_out]
set_property IOSTANDARD LVCMOS33 [get_ports h_sync_out]

set_property PACKAGE_PIN Y19 [get_ports v_sync_out]
set_property IOSTANDARD LVCMOS33 [get_ports v_sync_out]

set_property PACKAGE_PIN V10 [get_ports rx_in]
set_property IOSTANDARD LVCMOS33 [get_ports rx_in]