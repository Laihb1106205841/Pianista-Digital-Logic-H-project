set_property -dict {PACKAGE_PIN P17 IOSTANDARD LVCMOS33} [get_ports clk ]
set_property -dict {PACKAGE_PIN P15 IOSTANDARD LVCMOS33} [get_ports rst_n]
#set_property -dict {PACKAGE_PIN R1 IOSTANDARD LVCMOS33} [get_ports record]

set_property -dict {PACKAGE_PIN F6 IOSTANDARD LVCMOS33} [get_ports {led[3]}]
set_property -dict {PACKAGE_PIN G4 IOSTANDARD LVCMOS33} [get_ports {led[4]}]
set_property -dict {PACKAGE_PIN G3 IOSTANDARD LVCMOS33} [get_ports {led[5]}]
set_property -dict {PACKAGE_PIN J4 IOSTANDARD LVCMOS33} [get_ports {led[6]}]
set_property -dict {PACKAGE_PIN H4 IOSTANDARD LVCMOS33} [get_ports {led[7]}]
set_property -dict {PACKAGE_PIN J3 IOSTANDARD LVCMOS33} [get_ports {led[8]}]
set_property -dict {PACKAGE_PIN J2 IOSTANDARD LVCMOS33} [get_ports {led[9]}]

set_property -dict {PACKAGE_PIN K1 IOSTANDARD LVCMOS33} [get_ports {led[0]}]
set_property -dict {PACKAGE_PIN H6 IOSTANDARD LVCMOS33} [get_ports {led[1]}]
set_property -dict {PACKAGE_PIN H5 IOSTANDARD LVCMOS33} [get_ports {led[2]}]

set_property -dict {PACKAGE_PIN U3 IOSTANDARD LVCMOS33} [get_ports {note_and_pitch_user[0]}]
set_property -dict {PACKAGE_PIN U2 IOSTANDARD LVCMOS33} [get_ports {note_and_pitch_user[1]}]
set_property -dict {PACKAGE_PIN V2 IOSTANDARD LVCMOS33} [get_ports {note_and_pitch_user[2]}]
#set_property -dict {PACKAGE_PIN M1 IOSTANDARD LVCMOS33} [get_ports {state_led[1]}]
#set_property -dict {PACKAGE_PIN K3 IOSTANDARD LVCMOS33} [get_ports {state_led[0]}]



set_property -dict {PACKAGE_PIN P5 IOSTANDARD LVCMOS33} [get_ports {note_and_pitch_user[3]}]
set_property -dict {PACKAGE_PIN P4 IOSTANDARD LVCMOS33} [get_ports {note_and_pitch_user[4]}]
set_property -dict {PACKAGE_PIN P3 IOSTANDARD LVCMOS33} [get_ports {note_and_pitch_user[5]}]
set_property -dict {PACKAGE_PIN P2 IOSTANDARD LVCMOS33} [get_ports {note_and_pitch_user[6]}]
set_property -dict {PACKAGE_PIN R2 IOSTANDARD LVCMOS33} [get_ports {note_and_pitch_user[7]}]
set_property -dict {PACKAGE_PIN M4 IOSTANDARD LVCMOS33} [get_ports {note_and_pitch_user[8]}]
set_property -dict {PACKAGE_PIN N4 IOSTANDARD LVCMOS33} [get_ports {note_and_pitch_user[9]}]

#set_property -dict {PACKAGE_PIN T1 IOSTANDARD LVCMOS33} [get_ports speaker]
#set_property -dict {PACKAGE_PIN M6 IOSTANDARD LVCMOS33} [get_ports sel]

# set_property -dict {PACKAGE_PIN R2 IOSTANDARD LVCMOS33} [get_ports {n_th_song[1]}]
# set_property -dict {PACKAGE_PIN M4 IOSTANDARD LVCMOS33} [get_ports {n_th_song[0]}]
