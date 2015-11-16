#!/usr/bin/tclsh
#
# tcl scripts to add specific Elink and Axi bus signals to the gtkwave window
#
# See gtkwave/src/tcl_commands.c for list of supported commands
# See addsignals.tcl for an example for how to use these procedures

source [file join [file dirname [info script]] addhelpers.tcl]

proc addfifoNoMove {name fifo module} {
    addGroup $name.$fifo $module.$fifo.fifo wr_clk wr_en din empty full prog_full rd_clk rd_en valid dout
    gtkwave::/Edit/Toggle_Group_Open|Close
}

proc addfifo {name fifo module signal} {
    addfifoNoMove $name $fifo $module
    moveSetFocus $module.$signal
}

proc addRxFifo {name module} {

    set signal sys_clk
    set erx_fifo "$module.erx.erx_fifo"
    set etx_fifo "$module.etx.etx_fifo"
    set erx_protocol "$module.erx.erx_core.erx_protocol"
    set erx_io "$module.erx.erx_io"
    
    # Create a named group for the new signals
    addGroup $name.RxFifo $erx_fifo $signal
    gtkwave::/Edit/Toggle_Group_Open|Close
    moveSetFocus $erx_fifo.$signal

    set fifo txrr_fifo
    addfifoNoMove $name $fifo $etx_fifo
    moveSetFocus $erx_fifo.$signal
    collapseGroup $name.$fifo
    set fifo rxrd_fifo
    addfifo $name $fifo $erx_fifo $signal
    collapseGroup $name.$fifo
    set fifo rxwr_fifo
    addfifo $name $fifo $erx_fifo $signal
    collapseGroup $name.$fifo
    
    #addModuleSignals $erx_protocol rx_io_wait 
    #moveSetFocus $erx_fifo.$signal

    #addModuleSignals $erx_io tx_state
    #moveSetFocus $erx_fifo.$signal
    
    closeGroupDeleteSignal $erx_fifo.$signal

    collapseGroup $name.RxFifo
}

proc addTxFifo {name module} {

    set signal sys_clk
    set erx_fifo "$module.erx.erx_fifo"
    set etx "$module.etx"
    set etx_fifo "$etx.etx_fifo"
    set etx_core "$etx.etx_core"
    set etx_protocol "$etx_core.etx_protocol"
    
    # Create a named group for the new signals
    addGroup $name.TxFifo $etx_fifo $signal
    gtkwave::/Edit/Toggle_Group_Open|Close
    moveSetFocus $etx_fifo.$signal

    set fifo rxrr_fifo
    addfifoNoMove $name $fifo $erx_fifo
    moveSetFocus $etx_fifo.$signal
    collapseGroup $name.$fifo
    set fifo txrd_fifo
    addfifo $name $fifo $etx_fifo $signal
    collapseGroup $name.$fifo
    set fifo txwr_fifo
    addfifo $name $fifo $etx_fifo $signal
    collapseGroup $name.$fifo

    addModuleSignals $etx_core emmu_access
    moveSetFocus $etx_fifo.$signal
    
    addModuleSignals "$etx_core.etx_remap" emesh_access_out
    moveSetFocus $etx_fifo.$signal

    closeGroupDeleteSignal $etx_fifo.$signal

    collapseGroup $name.TxFifo
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
