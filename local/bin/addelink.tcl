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
    # ctrlmode
    addVector $module.$wait $module.$packet 7 4
    # datamode
    addVector $module.$wait $module.$packet 3 2
    # src_addr (less need to split it up)
    addVector $module.$wait $module.$packet 103 72
    # data
    addVector $module.$access $module.$packet 71 40
    # dest_addr
    addVector $module.$access $module.$packet 27 8
    # dest.Id
    addVector $module.$access $module.$packet 39 28
    # write
    addVector $module.$access $module.$packet 1 1
}

proc addElinkNoDelete {name module signal txfer rxfer state intran outtran rxi_lclk_p rxi_frame_p rxi_data_p txi_wr_wait_p txi_rd_wait_p rxo_wr_wait_p rxo_rd_wait_p txo_lclk_p txo_frame_p txo_data_p chipid cclk_p chip_resetb mailbox_not_empty mailbox_full timeout rxwr_access rxwr_packet rxrd_access rxrd_packet rxrr_access rxrr_packet txwr_wait txrd_wait txrr_wait rxwr_wait rxrd_wait rxrr_wait txwr_access txwr_packet txrd_access txrd_packet txrr_access txrr_packet} {
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
    addGroup $state $module $mailbox_not_empty $mailbox_full $timeout
    moveSetFocus $module.$signal
        
    # create inputs to elink0 from elink1
    addGroup $rxfer.rxi $module $rxi_lclk_p $rxi_frame_p $rxi_data_p $rxo_wr_wait_p $rxo_rd_wait_p
    moveSetFocus $module.$signal

    # create 
    addGroup $txfer.txo $module $txo_lclk_p $txo_frame_p $txo_data_p $txi_wr_wait_p $txi_rd_wait_p
    moveSetFocus $module.$signal
}

proc addElink {name module signal txfer rxfer state intran outtran rxi_lclk_p rxi_frame_p rxi_data_p txi_wr_wait_p txi_rd_wait_p rxo_wr_wait_p rxo_rd_wait_p txo_lclk_p txo_frame_p txo_data_p chipid cclk_p chip_nreset mailbox_not_empty mailbox_full timeout rxwr_access rxwr_packet rxrd_access rxrd_packet rxrr_access rxrr_packet txwr_wait txrd_wait txrr_wait rxwr_wait rxrd_wait rxrr_wait txwr_access txwr_packet txrd_access txrd_packet txrr_access txrr_packet} {
    addElinkNoDelete $name $module $signal $txfer $rxfer $state $intran $outtran $rxi_lclk_p $rxi_frame_p $rxi_data_p $txi_wr_wait_p $txi_rd_wait_p $rxo_wr_wait_p $rxo_rd_wait_p $txo_lclk_p $txo_frame_p $txo_data_p $chipid $cclk_p $chip_nreset $mailbox_not_empty $mailbox_full $timeout $rxwr_access $rxwr_packet $rxrd_access $rxrd_packet $rxrr_access $rxrr_packet $txwr_wait $txrd_wait $txrr_wait $rxwr_wait $rxrd_wait $rxrr_wait $txwr_access $txwr_packet $txrd_access $txrd_packet $txrr_access $txrr_packet
    
    # close the elink0 group
    closeGroupDeleteSignal $module.$signal

    # outline the elink0 group
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
