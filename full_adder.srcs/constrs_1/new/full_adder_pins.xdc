## Inputs (Slide Switches: SW0, SW1, SW2)
set_property PACKAGE_PIN V17 [get_ports a]
set_property IOSTANDARD LVCMOS33 [get_ports a]

set_property PACKAGE_PIN V16 [get_ports b]
set_property IOSTANDARD LVCMOS33 [get_ports b]

set_property PACKAGE_PIN W16 [get_ports cin]
set_property IOSTANDARD LVCMOS33 [get_ports cin]

## Outputs (LEDs: LD0, LD1)
set_property PACKAGE_PIN U16 [get_ports sum]
set_property IOSTANDARD LVCMOS33 [get_ports sum]

# Note: Change 'carry' to 'cout' if your full_adder.v module uses 'cout'
set_property PACKAGE_PIN E19 [get_ports carry]
set_property IOSTANDARD LVCMOS33 [get_ports carry]