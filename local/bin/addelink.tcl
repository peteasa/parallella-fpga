#!/usr/bin/tclsh
#
# tcl script to add specific Elink signals to the gtkwave window
#
# See gtkwave/src/tcl_commands.c for list of supported commands
# See addlinkdvsignals.tcl for an example for how to use these procedures

source [file join [file dirname [info script]] addhelpers.tcl]

proc addTransaction {grp module signal access packet wait} {
    # create response dv_elink.v to elink0
    addGroup $grp $module $access $wait
    moveSetFocus $module.$signal
    # nc
    addVector $module.$wait $module.$packet 7 7
    # ctrlmode
    addVector $module.$wait $module.$packet 6 3
    # datamode
    addVector $module.$wait $module.$packet 2 1
    # src_addr (less need to split it up)
    addVector $module.$wait $module.$packet 103 72
    # data
    addVector $module.$access $module.$packet 71 40
    # dest_addr
    addVector $module.$access $module.$packet 27 8
    # dest.Id
    addVector $module.$access $module.$packet 39 28
    # write
    addVector $module.$access $module.$packet 0 0
}

proc addElinkNoDelete {name module signal txfer rxfer state intran outtran rxi_lclk_p rxi_frame_p rxi_data_p txi_wr_wait_p txi_rd_wait_p rxo_wr_wait_p rxo_rd_wait_p txo_lclk_p txo_frame_p txo_data_p chipid cclk_p chip_resetb mailbox_irq rxwr_access rxwr_packet rxrd_access rxrd_packet rxrr_access rxrr_packet txwr_wait txrd_wait txrr_wait rxwr_wait rxrd_wait rxrr_wait txwr_access txwr_packet txrd_access txrd_packet txrr_access txrr_packet} {
    # create a group for $name
    addGroup $name $module $signal
    gtkwave::/Edit/Toggle_Group_Open|Close

    addTransaction $outtran.resp $module $signal $txrr_access $txrr_packet $txrr_wait

    # create request elink0 to dv_elink.v
    addTransaction $outtran.req $module $signal $rxrd_access $rxrd_packet $rxrd_wait

    # create write elink0 to dv_elink.v
    addTransaction $outtran.wrt $module $signal $rxwr_access $rxwr_packet $rxwr_wait

    # create response elink0 to dv_elinkv
    addTransaction $intran.resp $module $signal $rxrr_access $rxrr_packet $rxrr_wait

    # create request dv_elinkv to elink0
    addTransaction $intran.req $module $signal $txrd_access $txrd_packet $txrd_wait

    # create write dv_elink.v to elink0
    addTransaction $intran.wrt $module $signal $txwr_access $txwr_packet  $txwr_wait

    # create outputs of generic stuff from elink0
    addGroup $state $module $mailbox_irq
    moveSetFocus $module.$signal
        
    # create inputs to elink0 from elink1
    addGroup $rxfer.rxi $module $rxi_lclk_p $rxi_frame_p $rxi_data_p $rxo_wr_wait_p $rxo_rd_wait_p
    moveSetFocus $module.$signal

    # create 
    addGroup $txfer.txo $module $txo_lclk_p $txo_frame_p $txo_data_p $txi_wr_wait_p $txi_rd_wait_p
    moveSetFocus $module.$signal
}

proc addElink {elink frm_elink module signal txfer rxfer state intran outtran} {

    # for frm_elink signals
    set tail_txo_lclk_p _txo_lclk_p
    set tail_txo_frame_p _txo_frame_p
    set tail_txo_data_p _txo_data_p
    set tail_rxo_wr_wait_p _rxo_wr_wait_p
    set tail_rxo_rd_wait_p _rxo_rd_wait_p

    # for elink signals
    #set tail_rxo_wr_wait_p _rxo_wr_wait_p
    #set tail_rxo_rd_wait_p _rxo_rd_wait_p
    #set tail_txo_lclk_p _txo_lclk_p
    #set tail_txo_frame_p _txo_frame_p
    #set tail_txo_data_p _txo_data_p
    set tail_chipid _chipid
    set tail_cclk_p _cclk_p
    set tail_chip_resetb _chip_resetb
    set tail_mailbox_irq _mailbox_irq
    set tail_rxwr_access _rxwr_access
    set tail_rxwr_packet _rxwr_packet
    set tail_rxrd_access _rxrd_access
    set tail_rxrd_packet _rxrd_packet
    set tail_rxrr_access _rxrr_access
    set tail_rxrr_packet _rxrr_packet
    set tail_txwr_wait _txwr_wait
    set tail_txrd_wait _txrd_wait
    set tail_txrr_wait _txrr_wait
    set tail_rxwr_wait _rxwr_wait
    set tail_rxrd_wait _rxrd_wait
    set tail_rxrr_wait _rxrr_wait
    set tail_txwr_access _txwr_access
    set tail_txwr_packet _txwr_packet
    set tail_txrd_access _txrd_access
    set tail_txrd_packet _txrd_packet
    set tail_txrr_access _txrr_access
    set tail_txrr_packet _txrr_packet
	
    addElinkNoDelete $elink $module $signal $txfer $rxfer $state $intran $outtran $frm_elink$tail_txo_lclk_p $frm_elink$tail_txo_frame_p $frm_elink$tail_txo_data_p $frm_elink$tail_rxo_wr_wait_p $frm_elink$tail_rxo_rd_wait_p $elink$tail_rxo_wr_wait_p $elink$tail_rxo_rd_wait_p $elink$tail_txo_lclk_p $elink$tail_txo_frame_p $elink$tail_txo_data_p $elink$tail_chipid $elink$tail_cclk_p $elink$tail_chip_resetb $elink$tail_mailbox_irq $elink$tail_rxwr_access $elink$tail_rxwr_packet $elink$tail_rxrd_access $elink$tail_rxrd_packet $elink$tail_rxrr_access $elink$tail_rxrr_packet $elink$tail_txwr_wait $elink$tail_txrd_wait $elink$tail_txrr_wait $elink$tail_rxwr_wait $elink$tail_rxrd_wait $elink$tail_rxrr_wait $elink$tail_txwr_access $elink$tail_txwr_packet $elink$tail_txrd_access $elink$tail_txrd_packet $elink$tail_txrr_access $elink$tail_txrr_packet
    
    # close the elink0 group
    closeGroupDeleteSignal $module.$signal

    # outline the elink0 group
    gtkwave::setTraceHighlightFromNameMatch $elink on
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
