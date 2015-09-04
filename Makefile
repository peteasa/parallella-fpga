
M_VIVADO := vivado -mode batch -source

all:
	make -C AdiHDLLib/ all
	$(M_VIVADO) 7020_hdmi.tcl
