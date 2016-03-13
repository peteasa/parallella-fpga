#!/usr/bin/tclsh
#
# tcl script to add specific signals to the gtkwave window
#
# See gtkwave/src/tcl_commands.c for list of supported commands
#
# run like this (or isert the correct path to the script):
#     gtkwave test.vcd -S addaxielink0dvsignals.tcl &
#
# this script is used to display signals of the axi elink

# Pull in all the helper procedures
source [file join [file dirname [info script]] addaxielink.tcl]
source [file join [file dirname [info script]] addemem.tcl]
source [file join [file dirname [info script]] addregisters.tcl]

proc addAxiElinkXDVSignals { elink } {

    # add top level signals
    addSignals dv_top.clk dv_top.start state dv_top.nreset

    # create stimulus to the dut
    addGroup stimulus "dv_top.dv_driver.stim\[0\].genblk2.stimulus" stim_count stim_addr stim_data stim_end stim_done mem_access mem_data stim_access stim_packet stim_wait

    # create results from the dut
    addGroup results "dv_top.dut" dut_active access_out packet_out wait_in access_in packet_in wait_out

    # add axi elink
    set axi_elink $elink
    set fullelinkpath $axi_elink.elink

    addAxiElink axi$axi_elink "dv_top.dut.$axi_elink" sys_clk emaxi_to_esaxi frm_emaxi elink_frm_$axi_elink elink_to_$axi_elink elink_state esaxi_to_elink elink_to_esaxi

    # Display the Rx and Tx register accesses
    addRegRdWr $axi_elink.RegRdWr "dv_top.dut.$fullelinkpath"

    ## Now add the emem loopback
    addEmem emem "dv_top.dut.ememory" clk

}

# Copyright (C) 2015-2016 Peter Saunderson
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.This program is distributed in the hope 
# that it will be useful,but WITHOUT ANY WARRANTY; without even the implied 
# warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details. You should have received a copy 
# of the GNU General Public License along with this program (see the file 
# COPYING or LICENSE).  If not, see <http://www.gnu.org/licenses/>.
