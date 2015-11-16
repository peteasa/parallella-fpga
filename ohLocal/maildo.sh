#!/bin/bash

## run with ./maildo.sh test.memh

./doit.sh axi_mailbox $1

echo "now try"
echo "gtkwave waveform.vcd -S ../local/bin/addaxielinkdvsignals.tcl &"
