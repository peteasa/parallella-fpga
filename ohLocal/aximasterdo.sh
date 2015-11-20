#!/bin/bash

## run with ./aximasterdo.sh test.memh

./doit.sh master_axi_elink $1

echo "now try"
echo "gtkwave waveform.vcd -S ../local/bin/addaxielinkmasterdvsignals.tcl &"
