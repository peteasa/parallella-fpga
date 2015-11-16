#!/bin/bash

## run with ./do.sh test.memh

./doit.sh elink $1

echo "now try"
echo "gtkwave waveform.vcd -S ../local/bin/addelinkdvsignals.tcl &"
