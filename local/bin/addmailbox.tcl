#!/usr/bin/tclsh
#
# tcl scripts to add specific Elink and Axi bus signals to the gtkwave window
#
# See gtkwave/src/tcl_commands.c for list of supported commands
# See addlinkdvsignals.tcl for an example for how to use these procedures

source [file join [file dirname [info script]] addfifo.tcl]

proc addmailboxNoMove {name module} {

    set name "$name.erx_mailbox"
    
    addGroup $name $module.erx.erx_core.erx_mailbox wr_clk emesh_access emesh_write emesh_addr mailbox_write emesh_din rd_clk mi_en mi_rd mi_addr mailbox_read mi_dout mailbox_irq_en mailbox_irq mailbox_empty mailbox_full emesh_packet mi_we mi_din 
    gtkwave::/Edit/Toggle_Group_Open|Close
}

proc addmailbox {name module} {

    set signal sys_clk
    set erx_fifo "$module.erx.erx_fifo"
    set etx_fifo "$module.etx.etx_fifo"
    set erx_protocol "$module.erx.erx_core.erx_protocol"
    set erx_io "$module.erx.erx_io"

    addTxFifo $name $module
       
    # Create a named group for the new signals
    addGroup $name.Mailbox $erx_fifo $signal
    gtkwave::/Edit/Toggle_Group_Open|Close
    moveSetFocus $erx_fifo.$signal

    addmailboxNoMove $name $module
    moveSetFocus $erx_fifo.$signal
    collapseGroup "$name.erx_mailbox"
    
    set fifo ecfg_cdc
    addfifoNoMove "$name.$fifo" $fifo $module
    moveSetFocus $erx_fifo.$signal
    collapseGroup $name.$fifo.$fifo
    
    # Move the RxFifo to the group
    gtkwave::setTraceHighlightFromNameMatch $name.RxFifo on
    moveSetFocus $erx_fifo.$signal
    
    closeGroupDeleteSignal $erx_fifo.$signal

    collapseGroup "$name.Mailbox"
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
