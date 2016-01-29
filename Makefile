
M_VIVADO := vivado -mode batch -source

.PHONY: all clean

all:
	make -C AdiHDLLib/ all
	make -C oh/parallella/fpga/ all
	# remove old elink simulation for now $(M_VIVADO) elinkdv.tcl
	$(M_VIVADO) 7020_hdmi.tcl
	cd 7020_hdmi ; rm -f bit2bin.bin elink2_top_wrapper.bit.bin ; bootgen -image bit2bin.bif -split bin ; cd ..
	$(M_VIVADO) 7010_hdmi.tcl
	cd 7010_hdmi ; rm -f bit2bin.bin elink2_top_wrapper.bit.bin ; bootgen -image bit2bin.bif -split bin ; cd ..

clean:
	make -C oh/parallella/fpga/ clean
