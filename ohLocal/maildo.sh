#!/bin/bash

## run with ./maildo.sh test.memh

./doit.sh mands_axi_elink $1

echo "now try"
echo "gtkwave waveform.vcd -S ../local/bin/addaxielink0dvsignals.tcl &"
#echo "or try"
#echo "gtkwave waveform.vcd -S ../local/bin/addaxielink1dvsignals.tcl &"
