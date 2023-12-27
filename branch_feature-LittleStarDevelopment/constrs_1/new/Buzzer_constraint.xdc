set_property IOSTANDARD LVCMOS33[get_ports *]

set_property -dict {PACKAGE_PIN P17 IOSTANDARD LVCMOS33} [get_ports clk ]

# TEST CONDUCTED ON EARPHONE, BUZZER NOT TESTED.
set_property -dict {PACKAGE_PIN T1 IOSTANDARD LVCMOS33} [get_ports speaker]
set_property -dict {PACKAGE_PIN M6 IOSTANDARD LVCMOS33} [get_ports sel]