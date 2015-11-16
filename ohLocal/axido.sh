#!/bin/bash

## run with ./axido.sh test.memh

./doit.sh axi_elink $1

echo "now try"
echo "gtkwave waveform.vcd -S ../local/bin/addaxielinkdvsignals.tcl &"
