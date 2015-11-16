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
source [file join [file dirname [info script]] addregisters.tcl]
source [file join [file dirname [info script]] addmailbox.tcl]

# add top level signals
addSignals dv_top.clk dv_top.start state dv_top.nreset

# create stimulus to the dut
addGroup stimulus "dv_top.dv_driver.stim\[0\].genblk2.stimulus" stim_count stim_addr stim_data stim_end stim_done mem_access mem_data stim_access stim_packet stim_wait

# create results from the dut
addGroup results "dv_top.dut" dut_active access_out packet_out wait_in access_in packet_in wait_out

# add elink0
addElink elink0 "dv_top.dut" clk elink1_frm_elink0 elink1_to_elink0 elink0_state stimulus_to_elink0 results_frm_elink0 elink1_txo_lclk_p elink1_txo_frame_p elink1_txo_data_p elink1_rxo_wr_wait_p elink1_rxo_rd_wait_p elink0_rxo_wr_wait_p elink0_rxo_rd_wait_p elink0_txo_lclk_p elink0_txo_frame_p elink0_txo_data_p elink0_chipid elink0_cclk_p elink0_chip_resetb elink0_mailbox_not_empty elink0_mailbox_full elink0_timeout elink0_rxwr_access elink0_rxwr_packet elink0_rxrd_access elink0_rxrd_packet elink0_rxrr_access elink0_rxrr_packet elink0_txwr_wait elink0_txrd_wait elink0_txrr_wait elink0_rxwr_wait elink0_rxrd_wait elink0_rxrr_wait elink0_txwr_access elink0_txwr_packet elink0_txrd_access elink0_txrd_packet elink0_txrr_access elink0_txrr_packet

# add elink1
addElink elink1 "dv_top.dut" clk elink0_frm_elink1 elink0_to_elink1 elink1_state nc_frm_elink1 elink1_to_emem elink0_txo_lclk_p elink0_txo_frame_p elink0_txo_data_p elink0_rxo_wr_wait_p elink0_rxo_rd_wait_p elink1_rxo_wr_wait_p elink1_rxo_rd_wait_p elink1_txo_lclk_p elink1_txo_frame_p elink1_txo_data_p elink1_chipid elink1_cclk_p elink1_chip_resetb elink1_mailbox_not_empty elink1_mailbox_full elink1_timeout elink1_rxwr_access elink1_rxwr_packet elink1_rxrd_access elink1_rxrd_packet elink1_rxrr_access elink1_rxrr_packet elink1_txwr_wait elink1_txrd_wait elink1_txrr_wait elink1_rxwr_wait elink1_rxrd_wait elink1_rxrr_wait elink1_txwr_access elink1_txwr_packet elink1_txrd_access elink1_txrd_packet elink1_txrr_access elink1_txrr_packet


# Add registers
addRegRdWr axielink0RegRdWr "dv_top.dut.elink0.elink"

# Add mailbox
set name axielink0Mailbox
set module "dv_top.dut.elink0.elink"

addmailbox $name $module

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
