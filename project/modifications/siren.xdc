create_clock -period 20.000 -name clk_50MHz [get_ports clk_50MHz]

set_property -dict {PACKAGE_PIN E3 IOSTANDARD LVCMOS33} [get_ports clk_50MHz]

#set_property -dict {PACKAGE_PIN D18 IOSTANDARD LVCMOS33} [get_ports dac_LRCK]

#set_property -dict {PACKAGE_PIN E18 IOSTANDARD LVCMOS33} [get_ports dac_SCLK]

#set_property -dict {PACKAGE_PIN G17 IOSTANDARD LVCMOS33} [get_ports dac_SDIN]

#set_property -dict {PACKAGE_PIN C17 IOSTANDARD LVCMOS33} [get_ports dac_MCLK]

set_property -dict {PACKAGE_PIN E17 IOSTANDARD LVCMOS33} [get_ports dac_LRCK]

set_property -dict {PACKAGE_PIN F18 IOSTANDARD LVCMOS33} [get_ports dac_SCLK]

set_property -dict {PACKAGE_PIN G18 IOSTANDARD LVCMOS33} [get_ports dac_SDIN]

set_property -dict {PACKAGE_PIN D17 IOSTANDARD LVCMOS33} [get_ports dac_MCLK]

set_property -dict {PACKAGE_PIN M18 IOSTANDARD LVCMOS33} [get_ports bt_square]

set_property -dict {PACKAGE_PIN P17 IOSTANDARD LVCMOS33} [get_ports bt_lowpass]

set_property -dict {PACKAGE_PIN M17 IOSTANDARD LVCMOS33} [get_ports bt_highpass]

set_property -dict {PACKAGE_PIN N17 IOSTANDARD LVCMOS33} [get_ports bt_reset_high]

set_property -dict {PACKAGE_PIN P18 IOSTANDARD LVCMOS33} [get_ports bt_reset_low]

set_property -dict {PACKAGE_PIN J15 IOSTANDARD LVCMOS33} [get_ports SW0]

set_property -dict {PACKAGE_PIN L16 IOSTANDARD LVCMOS33} [get_ports SW1]

set_property -dict {PACKAGE_PIN M13 IOSTANDARD LVCMOS33} [get_ports SW2]

set_property -dict {PACKAGE_PIN R15 IOSTANDARD LVCMOS33} [get_ports SW3]

set_property -dict {PACKAGE_PIN R17 IOSTANDARD LVCMOS33} [get_ports SW4]

set_property -dict {PACKAGE_PIN T18 IOSTANDARD LVCMOS33} [get_ports SW5]

set_property -dict {PACKAGE_PIN U18 IOSTANDARD LVCMOS33} [get_ports SW6]

set_property -dict {PACKAGE_PIN R13 IOSTANDARD LVCMOS33} [get_ports SW7]

set_property -dict {PACKAGE_PIN T8 IOSTANDARD LVCMOS33} [get_ports SW8]

set_property -dict {PACKAGE_PIN U8 IOSTANDARD LVCMOS33} [get_ports SW9]

set_property -dict {PACKAGE_PIN R16 IOSTANDARD LVCMOS33} [get_ports SW10]

set_property CONFIG_MODE SPIx1 [current_design]


set_property -dict { PACKAGE_PIN D14   IOSTANDARD LVCMOS33 } [get_ports { KB_col[4] }]; #IO_L20N_T3_A19_15 Sch=ja[1]
set_property -dict { PACKAGE_PIN F16   IOSTANDARD LVCMOS33 } [get_ports { KB_col[3] }]; #IO_L21N_T3_DQS_A18_15 Sch=ja[2]
set_property -dict { PACKAGE_PIN G16   IOSTANDARD LVCMOS33 } [get_ports { KB_col[2] }]; #IO_L21P_T3_DQS_15 Sch=ja[3]
set_property -dict { PACKAGE_PIN H14   IOSTANDARD LVCMOS33 } [get_ports { KB_col[1] }]; #IO_L18N_T2_A23_15 Sch=ja[4]
set_property -dict { PACKAGE_PIN E16   IOSTANDARD LVCMOS33 } [get_ports { KB_row[4] }]; #IO_L16N_T2_A27_15 Sch=ja[7]
set_property -dict { PACKAGE_PIN F13   IOSTANDARD LVCMOS33 } [get_ports { KB_row[3] }]; #IO_L16P_T2_A28_15 Sch=ja[8]
set_property -dict { PACKAGE_PIN G13   IOSTANDARD LVCMOS33 } [get_ports { KB_row[2] }]; #IO_L22N_T3_A16_15 Sch=ja[9]
set_property -dict { PACKAGE_PIN H16   IOSTANDARD LVCMOS33 } [get_ports { KB_row[1] }]; #IO_L22P_T3_A17_15 Sch=ja[10]

set_property -dict {PACKAGE_PIN L18 IOSTANDARD LVCMOS33} [get_ports {SEG7_seg[0]}]
set_property -dict {PACKAGE_PIN T11 IOSTANDARD LVCMOS33} [get_ports {SEG7_seg[1]}]
set_property -dict {PACKAGE_PIN P15 IOSTANDARD LVCMOS33} [get_ports {SEG7_seg[2]}]
set_property -dict {PACKAGE_PIN K13 IOSTANDARD LVCMOS33} [get_ports {SEG7_seg[3]}]
set_property -dict {PACKAGE_PIN K16 IOSTANDARD LVCMOS33} [get_ports {SEG7_seg[4]}]
set_property -dict {PACKAGE_PIN R10 IOSTANDARD LVCMOS33} [get_ports {SEG7_seg[5]}]
set_property -dict {PACKAGE_PIN T10 IOSTANDARD LVCMOS33} [get_ports {SEG7_seg[6]}]

set_property -dict {PACKAGE_PIN U13 IOSTANDARD LVCMOS33} [get_ports {SEG7_anode[7]}]
set_property -dict {PACKAGE_PIN K2 IOSTANDARD LVCMOS33} [get_ports {SEG7_anode[6]}]
set_property -dict {PACKAGE_PIN T14 IOSTANDARD LVCMOS33} [get_ports {SEG7_anode[5]}]
set_property -dict {PACKAGE_PIN P14 IOSTANDARD LVCMOS33} [get_ports {SEG7_anode[4]}]
set_property -dict {PACKAGE_PIN J14 IOSTANDARD LVCMOS33} [get_ports {SEG7_anode[3]}]
set_property -dict {PACKAGE_PIN T9 IOSTANDARD LVCMOS33} [get_ports {SEG7_anode[2]}]
set_property -dict {PACKAGE_PIN J18 IOSTANDARD LVCMOS33} [get_ports {SEG7_anode[1]}]
set_property -dict {PACKAGE_PIN J17 IOSTANDARD LVCMOS33} [get_ports {SEG7_anode[0]}]
