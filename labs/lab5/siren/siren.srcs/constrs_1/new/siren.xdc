create_clock -period 20.000 -name clk_50MHz [get_ports clk_50MHz]

set_property -dict {PACKAGE_PIN E3 IOSTANDARD LVCMOS33} [get_ports clk_50MHz]

set_property -dict {PACKAGE_PIN D18 IOSTANDARD LVCMOS33} [get_ports dac_LRCK]

set_property -dict {PACKAGE_PIN E18 IOSTANDARD LVCMOS33} [get_ports dac_SCLK]

set_property -dict {PACKAGE_PIN G17 IOSTANDARD LVCMOS33} [get_ports dac_SDIN]

set_property -dict {PACKAGE_PIN C17 IOSTANDARD LVCMOS33} [get_ports dac_MCLK]

set_property -dict {PACKAGE_PIN M18 IOSTANDARD LVCMOS33} [get_ports bt_square]

set_property -dict {PACKAGE_PIN J15 IOSTANDARD LVCMOS33} [get_ports SW0]

set_property -dict {PACKAGE_PIN L16 IOSTANDARD LVCMOS33} [get_ports SW1]

set_property -dict {PACKAGE_PIN M13 IOSTANDARD LVCMOS33} [get_ports SW2]

set_property -dict {PACKAGE_PIN R15 IOSTANDARD LVCMOS33} [get_ports SW3]

set_property -dict {PACKAGE_PIN R17 IOSTANDARD LVCMOS33} [get_ports SW4]

set_property -dict {PACKAGE_PIN T18 IOSTANDARD LVCMOS33} [get_ports SW5]

set_property -dict {PACKAGE_PIN U18 IOSTANDARD LVCMOS33} [get_ports SW6]

set_property -dict {PACKAGE_PIN R13 IOSTANDARD LVCMOS33} [get_ports SW7]

set_property CONFIG_MODE SPIx1 [current_design]