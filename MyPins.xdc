set_property IOSTANDARD LVCMOS33[get_ports *]

#------------------- SYSTEM CLOCK -----------------------#
set_property -dict {PACKAGE_PIN P17 IOSTANDARD LVCMOS33} [get_ports clk]
#################### SYSTEM CLOCK END ####################

#------------------- led module -------------------------#
set_property -dict {PACKAGE_PIN F6 IOSTANDARD LVCMOS33} [get_ports {led_note[0]}]
set_property -dict {PACKAGE_PIN G4 IOSTANDARD LVCMOS33} [get_ports {led_note[1]}]
set_property -dict {PACKAGE_PIN G3 IOSTANDARD LVCMOS33} [get_ports {led_note[2]}]
set_property -dict {PACKAGE_PIN J4 IOSTANDARD LVCMOS33} [get_ports {led_note[3]}]
set_property -dict {PACKAGE_PIN H4 IOSTANDARD LVCMOS33} [get_ports {led_note[4]}]
set_property -dict {PACKAGE_PIN J3 IOSTANDARD LVCMOS33} [get_ports {led_note[5]}]
set_property -dict {PACKAGE_PIN J2 IOSTANDARD LVCMOS33} [get_ports {led_note[6]}]

set_property -dict {PACKAGE_PIN K1 IOSTANDARD LVCMOS33} [get_ports {led_HighLow[0]}]
set_property -dict {PACKAGE_PIN H6 IOSTANDARD LVCMOS33} [get_ports {led_HighLow[1]}]
set_property -dict {PACKAGE_PIN H5 IOSTANDARD LVCMOS33} [get_ports {led_HighLow[2]}]
#################### led module END ####################

#------------------- PIN module -------------------------#
set_property -dict {PACKAGE_PIN P5 IOSTANDARD LVCMOS33} [get_ports {Pin_Note[0]}]
set_property -dict {PACKAGE_PIN P4 IOSTANDARD LVCMOS33} [get_ports {Pin_Note[1]}]
set_property -dict {PACKAGE_PIN P3 IOSTANDARD LVCMOS33} [get_ports {Pin_Note[2]}]
set_property -dict {PACKAGE_PIN P2 IOSTANDARD LVCMOS33} [get_ports {Pin_Note[3]}]
set_property -dict {PACKAGE_PIN R2 IOSTANDARD LVCMOS33} [get_ports {Pin_Note[4]}]
set_property -dict {PACKAGE_PIN M4 IOSTANDARD LVCMOS33} [get_ports {Pin_Note[5]}]
set_property -dict {PACKAGE_PIN N4 IOSTANDARD LVCMOS33} [get_ports {Pin_Note[6]}]
#°´Å¥
set_property -dict {PACKAGE_PIN U3 IOSTANDARD LVCMOS33} [get_ports {Pin_Note[7]}]
set_property -dict {PACKAGE_PIN U2 IOSTANDARD LVCMOS33} [get_ports {Pin_Note[8]}]
set_property -dict {PACKAGE_PIN V2 IOSTANDARD LVCMOS33} [get_ports {Pin_Note[9]}]

set_property -dict {PACKAGE_PIN T3 IOSTANDARD LVCMOS33} [get_ports {next_state[0]}]
set_property -dict {PACKAGE_PIN T5 IOSTANDARD LVCMOS33} [get_ports {next_state[1]}]
set_property -dict {PACKAGE_PIN S6 IOSTANDARD LVCMOS33} [get_ports rst]
#################### PIN module END ####################

#------------------- BUZZER module --------------------#
set_property -dict {PACKAGE_PIN T1 IOSTANDARD LVCMOS33} [get_ports speaker]
set_property -dict {PACKAGE_PIN M6 IOSTANDARD LVCMOS33} [get_ports sel]
#################### BUZZER module END ####################