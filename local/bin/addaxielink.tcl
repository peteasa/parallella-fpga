#!/usr/bin/tclsh
#
# tcl scripts to add specific Elink and Axi bus signals to the gtkwave window
#
# See gtkwave/src/tcl_commands.c for list of supported commands
# See addelinkdvsignals.tcl for an example for how to use these procedures

source [file join [file dirname [info script]] addelink.tcl]

proc addAxiNoDelete {axi module signal axi_awid axi_awaddr axi_awlen axi_awsize axi_awburst axi_awlock axi_awcache axi_awprot axi_awqos axi_awvalid axi_wid axi_wdata axi_wstrb axi_wlast axi_wvalid axi_bready axi_arid axi_araddr axi_arlen axi_arsize axi_arburst axi_arlock axi_arcache axi_arprot axi_arqos axi_arvalid axi_rready axi_aresetn axi_awready axi_wready axi_bid axi_bresp axi_bvalid axi_arready axi_rid axi_rdata axi_rresp axi_rlast axi_rvalid} {

    addGroup $axi $module $axi_aresetn
    gtkwave::/Edit/Toggle_Group_Open|Close
    moveSetFocus $module.$signal

    # create a group for everything else!
    addGroup Ctrl $module $axi_awburst $axi_arburst $axi_bid $axi_bresp $axi_bvalid $axi_bready $axi_awid $axi_awlen $axi_awsize $axi_awlock $axi_awcache $axi_awprot $axi_awqos $axi_wid $axi_wstrb $axi_wlast $axi_arid $axi_arlen $axi_arsize $axi_arlock $axi_arcache $axi_arprot $axi_arqos $axi_rid $axi_rlast
    
    moveSetFocus $module.$axi_aresetn
    
    # create key signals
    addGroup Rd $module $axi_araddr $axi_arvalid $axi_arready $axi_rdata $axi_rresp $axi_rvalid $axi_rready
    moveSetFocus $module.$axi_aresetn
    addGroup Wr $module $axi_awaddr $axi_awvalid $axi_awready $axi_wdata $axi_wvalid $axi_wready
    moveSetFocus $module.$axi_aresetn
}

proc addAxiElink {name module signal axis axim txfer rxfer state intran outtran rxi_lclk_p rxi_frame_p rxi_data_p txi_wr_wait_p txi_rd_wait_p rxo_wr_wait_p rxo_rd_wait_p txo_lclk_p txo_frame_p txo_data_p chipid cclk_p chip_resetb mailbox_not_empty mailbox_full timeout rxwr_access rxwr_packet rxrd_access rxrd_packet rxrr_access rxrr_packet txwr_wait txrd_wait txrr_wait rxwr_wait rxrd_wait rxrr_wait txwr_access txwr_packet txrd_access txrd_packet txrr_access txrr_packet m_axi_awid m_axi_awaddr m_axi_awlen m_axi_awsize m_axi_awburst m_axi_awlock m_axi_awcache m_axi_awprot m_axi_awqos m_axi_awvalid m_axi_wid m_axi_wdata m_axi_wstrb m_axi_wlast m_axi_wvalid m_axi_bready m_axi_arid m_axi_araddr m_axi_arlen m_axi_arsize m_axi_arburst m_axi_arlock m_axi_arcache m_axi_arprot m_axi_arqos m_axi_arvalid m_axi_rready m_axi_aresetn m_axi_awready m_axi_wready m_axi_bid m_axi_bresp m_axi_bvalid m_axi_arready m_axi_rid m_axi_rdata m_axi_rresp m_axi_rlast m_axi_rvalid s_axi_awid s_axi_awaddr s_axi_awlen s_axi_awsize s_axi_awburst s_axi_awlock s_axi_awcache s_axi_awprot s_axi_awqos s_axi_awvalid s_axi_wid s_axi_wdata s_axi_wstrb s_axi_wlast s_axi_wvalid s_axi_bready s_axi_arid s_axi_araddr s_axi_arlen s_axi_arsize s_axi_arburst s_axi_arlock s_axi_arcache s_axi_arprot s_axi_arqos s_axi_arvalid s_axi_rready s_axi_aresetn s_axi_awready s_axi_wready s_axi_bid s_axi_bresp s_axi_bvalid s_axi_arready s_axi_rid s_axi_rdata s_axi_rresp s_axi_rlast s_axi_rvalid} {
    addElinkNoDelete $name $module $signal $txfer $rxfer $state $intran $outtran $rxi_lclk_p $rxi_frame_p $rxi_data_p $txi_wr_wait_p $txi_rd_wait_p $rxo_wr_wait_p $rxo_rd_wait_p $txo_lclk_p $txo_frame_p $txo_data_p $chipid $cclk_p $chip_resetb $mailbox_not_empty $mailbox_full $timeout $rxwr_access $rxwr_packet $rxrd_access $rxrd_packet $rxrr_access $rxrr_packet $txwr_wait $txrd_wait $txrr_wait $rxwr_wait $rxrd_wait $rxrr_wait $txwr_access $txwr_packet $txrd_access $txrd_packet $txrr_access $txrr_packet

    addAxiNoDelete $axim.master $module $signal $m_axi_awid $m_axi_awaddr $m_axi_awlen $m_axi_awsize $m_axi_awburst $m_axi_awlock $m_axi_awcache $m_axi_awprot $m_axi_awqos $m_axi_awvalid $m_axi_wid $m_axi_wdata $m_axi_wstrb $m_axi_wlast $m_axi_wvalid $m_axi_bready $m_axi_arid $m_axi_araddr $m_axi_arlen $m_axi_arsize $m_axi_arburst $m_axi_arlock $m_axi_arcache $m_axi_arprot $m_axi_arqos $m_axi_arvalid $m_axi_rready $m_axi_aresetn $m_axi_awready $m_axi_wready $m_axi_bid $m_axi_bresp $m_axi_bvalid $m_axi_arready $m_axi_rid $m_axi_rdata $m_axi_rresp $m_axi_rlast $m_axi_rvalid

    # close the Axi group
    closeGroupDeleteSignal $module.$m_axi_aresetn

    addAxiNoDelete $axis.slave $module $signal $s_axi_awid $s_axi_awaddr $s_axi_awlen $s_axi_awsize $s_axi_awburst $s_axi_awlock $s_axi_awcache $s_axi_awprot $s_axi_awqos $s_axi_awvalid $s_axi_wid $s_axi_wdata $s_axi_wstrb $s_axi_wlast $s_axi_wvalid $s_axi_bready $s_axi_arid $s_axi_araddr $s_axi_arlen $s_axi_arsize $s_axi_arburst $s_axi_arlock $s_axi_arcache $s_axi_arprot $s_axi_arqos $s_axi_arvalid $s_axi_rready $s_axi_aresetn $s_axi_awready $s_axi_wready $s_axi_bid $s_axi_bresp $s_axi_bvalid $s_axi_arready $s_axi_rid $s_axi_rdata $s_axi_rresp $s_axi_rlast $s_axi_rvalid
    
    # close the Axi group
    closeGroupDeleteSignal $module.$s_axi_aresetn    
    # outline the axi and elink groups

    # close the elink0 group
    closeGroupDeleteSignal $module.$signal

    gtkwave::setTraceHighlightFromNameMatch $axim.master on
    gtkwave::/Edit/Toggle_Group_Open|Close
    gtkwave::setTraceHighlightFromNameMatch $axis.slave on
    gtkwave::/Edit/Toggle_Group_Open|Close
    gtkwave::setTraceHighlightFromNameMatch $name on
    gtkwave::/Edit/Toggle_Group_Open|Close
}

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
