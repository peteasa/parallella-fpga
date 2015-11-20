#!/bin/bash

## run with ./axido.sh test.memh

./doit.sh slave_axi_elink $1

echo "now try"
echo "gtkwave waveform.vcd -S ../local/bin/addaxielinkslavedvsignals.tcl &"
