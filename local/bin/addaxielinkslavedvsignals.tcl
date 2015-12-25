#!/usr/bin/tclsh
#
# tcl script to add specific signals to the gtkwave window
#
# See gtkwave/src/tcl_commands.c for list of supported commands
#
# run like this (or isert the correct path to the script):
#     gtkwave test.vcd -S addelinkslavedvsignals.tcl &
#
# this script is used to display signals when the axi elink is
# configured so that stimulus is written to the slave interface
# the master interface (RX path) is stubbed or ignored)

# Enable the full signal hierarchy for better name matching
gtkwave::/Edit/Toggle_Trace_Hier

# Pull in all the helper procedures
source [file join [file dirname [info script]] addaxielink.tcl]
source [file join [file dirname [info script]] addemem.tcl]

# add top level signals
addSignals dv_top.clk dv_top.start state dv_top.nreset

# create stimulus to the dut
addGroup stimulus "dv_top.dv_driver.stim\[0\].genblk2.stimulus" stim_count stim_addr stim_data stim_end stim_done mem_access mem_data stim_access stim_packet stim_wait

# create results from the dut
addGroup results "dv_top.dut" dut_active access_out packet_out wait_in access_in packet_in wait_out

# add axi elink
set axi_elink elink0
addAxiElink axi$axi_elink "dv_top.dut.$axi_elink" sys_clk emaxi_to_esaxi nc_frm_emaxi elink1_frm_$axi_elink elink1_to_$axi_elink elink_state esaxi_to_elink elink_to_esaxi

# add elink1
set elink elink1
set frm_elink elink0
set tail_frm _frm_
set tail_to _to_
set tail_state _state
addElink $elink $frm_elink "dv_top.dut" clk $frm_elink$tail_frm$elink $frm_elink$tail_to$elink $elink$tail_state nc_from_$elink emem_frm_$elink 

#
# add emaxi group .. cheat because m_axi_areset does not exist use nreset
#
set emaxi_grp emaxi
set emaxi_module "dv_top.dut"
addGroup $emaxi_grp $emaxi_module "emaxi.aw_go"
gtkwave::/Edit/Toggle_Group_Open|Close

# create request axi_fifo to tx_emaxi
addTransaction emaxi.resp $emaxi_module.emaxi aw_go txrr_access txrr_packet txrr_access

addTransaction emaxi.req $emaxi_module.emaxi aw_go rxrd_access rxrd_packet rxrd_wait

addTransaction emaxi.wrt $emaxi_module.emaxi aw_go rxwr_access rxwr_packet rxwr_wait

# add maxi cheat because m_axi_areset does not exist use nreset
set emaxi_to emaxi_to_axiElink0
addAxiNoDelete $emaxi_to $emaxi_module "emaxi.aw_go" m_axi_awid m_axi_awaddr m_axi_awlen m_axi_awsize m_axi_awburst m_axi_awlock m_axi_awcache m_axi_awprot m_axi_awqos m_axi_awvalid m_axi_wid m_axi_wdata m_axi_wstrb m_axi_wlast m_axi_wvalid m_axi_bready m_axi_arid m_axi_araddr m_axi_arlen m_axi_arsize m_axi_arburst m_axi_arlock m_axi_arcache m_axi_arprot m_axi_arqos m_axi_arvalid m_axi_rready nreset m_axi_awready m_axi_wready m_axi_bid m_axi_bresp m_axi_bvalid m_axi_arready m_axi_rid m_axi_rdata m_axi_rresp m_axi_rlast m_axi_rvalid

# close the Axi group
closeGroupDeleteSignal $emaxi_module.nreset
gtkwave::setTraceHighlightFromNameMatch $emaxi_to on
gtkwave::/Edit/Toggle_Group_Open|Close
moveSetFocus $emaxi_module.emaxi.aw_go

closeGroupDeleteSignal $emaxi_module.emaxi.aw_go
gtkwave::setTraceHighlightFromNameMatch $emaxi_grp on
gtkwave::/Edit/Toggle_Group_Open|Close
#
#
#

## Now add the emem loopback
addEmem emem "dv_top.dut.emem" clk

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
