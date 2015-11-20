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
addAxiElink axielink0 "dv_top.dut.elink0" sys_clk emaxi_to_esaxi nc_frm_emaxi elink0_to_elink1 elink0_frm_elink1 elink_state esaxi_to_elink elink_to_esaxi

# add elink1
addElink elink1 "dv_top.dut" clk elink0_frm_elink1 elink0_to_elink1 elink1_state nc_from_elink1 elink1_to_emem elink0_txo_lclk_p elink0_txo_frame_p elink0_txo_data_p elink0_rxo_wr_wait_p elink0_rxo_rd_wait_p elink1_rxo_wr_wait_p elink1_rxo_rd_wait_p elink1_txo_lclk_p elink1_txo_frame_p elink1_txo_data_p elink1_chipid elink1_cclk_p elink1_chip_resetb elink1_mailbox_not_empty elink1_mailbox_full elink1_timeout elink1_rxwr_access elink1_rxwr_packet elink1_rxrd_access elink1_rxrd_packet elink1_rxrr_access elink1_rxrr_packet elink1_txwr_wait elink1_txrd_wait elink1_txrr_wait elink1_rxwr_wait elink1_rxrd_wait elink1_rxrr_wait elink1_txwr_access elink1_txwr_packet elink1_txrd_access elink1_txrd_packet elink1_txrr_access elink1_txrr_packet

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
