#!/usr/bin/tclsh
#
# tcl script to add specific signals to the gtkwave window
#
# See gtkwave/src/tcl_commands.c for list of supported commands
#
# run like this (or isert the correct path to the script):
#     gtkwave test.vcd -S addelhinkdvsignals.tcl &

# Enable the full signal hierarchy for better name matching
gtkwave::/Edit/Toggle_Trace_Hier

# Pull in all the helper procedures
source [file join [file dirname [info script]] addelink.tcl]

# add top level signals
addSignals dv_top.clk dv_top.start state dv_top.nreset

# create stimulus to the dut
addGroup stimulus "dv_top.dv_driver.stim\[0\].genblk2.stimulus" stim_count stim_addr stim_data stim_end stim_done mem_access mem_data stim_access stim_packet stim_wait

# create results from the dut
addGroup results "dv_top.dut" dut_active access_out packet_out wait_in access_in packet_in wait_out

# add elink0
set elink elink0
set frm_elink elink1
set tail_frm _frm_
set tail_to _to_
set tail_state _state
addElink $elink $frm_elink "dv_top.dut" clk $frm_elink$tail_frm$elink $frm_elink$tail_to$elink $elink$tail_state stimulus_to_$elink results_frm_$elink

# add elink1
set elink elink1
set frm_elink elink0
#set tail_frm _frm_
#set tail_to _to_
#set tail_state _state
addElink $elink $frm_elink "dv_top.dut" clk $frm_elink$tail_frm$elink $frm_elink$tail_to$elink $elink$tail_state nc_frm_$elink emem_frm_$elink

# Disable the full signal hierarchy for better viewing
gtkwave::/Edit/UnHighlight_All
gtkwave::/Edit/Toggle_Trace_Hier

# gtkwave::/Edit/Combine_Down $outputs

# Prepare the screen for use
gtkwave::setWindowStartTime 1.5us
gtkwave::setZoomRangeTimes 1.5us 6us
# gtkwave::setZoomFactor zoom_value

# Copyright (C) 2015 Peter Saunderson
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.This program is distributed in the hope 
# that it will be useful,but WITHOUT ANY WARRANTY; without even the implied 
# warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details. You should have received a copy 
# of the GNU General Public License along with this program (see the file 
# COPYING or LICENSE).  If not, see <http://www.gnu.org/licenses/>.
