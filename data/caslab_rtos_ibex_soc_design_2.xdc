##Raspberry Digital I/O 

set_property -dict { PACKAGE_PIN W18   IOSTANDARD LVCMOS33 } [get_ports { uart_rtl_rxd }]; #IO_L22P_T3_34 Sch=rpio_02_r
set_property -dict { PACKAGE_PIN W19   IOSTANDARD LVCMOS33 } [get_ports { uart_rtl_txd }]; #IO_L22N_T3_34 Sch=rpio_03_r
set_property -dict { PACKAGE_PIN Y18   IOSTANDARD LVCMOS33 } [get_ports { irq_external }]; #IO_L17P_T2_34 Sch=rpio_04_r