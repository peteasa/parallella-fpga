#!/bin/bash

## run with ./do.sh test.memh
## or with ./axido.sh test.memh
## or with ./doit.sh elink test.memh
## or with ./doit.sh axi_elink test.memh

dut=$1
echo $dut
top="./common/dv/dv_top_local.v"

if [ "axi_mailbox" == "${dut}" ]; then
    dutsrc="dut_${dut}.v"
else
    dutsrc="../oh/elink/dv/dut_${dut}.v"
fi

## use the simple fifo
iverilog -g2005 -DTIMEOUT=20000 -DTARGET_SIM=1 -DTARGET_XILINX=1 $top $dutsrc -f ./libs.cmd -o ${dut}.vvp

#-pfileline=1
#-Wall

if [ -e "test_0.memh" ]
then
    rm test_0.memh
fi
cp $2 test_0.memh
./${dut}.vvp


