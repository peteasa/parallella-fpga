#!/usr/bin/tclsh
#
# tcl scripts to add specific Elink and Axi bus signals to the gtkwave window
#
# See gtkwave/src/tcl_commands.c for list of supported commands
# See addelinkdvsignals.tcl for an example for how to use these procedures

source [file join [file dirname [info script]] addelink.tcl]

proc addEmem {name module signal} {

    # create a group for $name
    addGroup $name $module $signal
    gtkwave::/Edit/Toggle_Group_Open|Close

    addTransaction $name.out $module $signal access_out packet_out wait_out
    addTransaction $name.in $module $signal access_in packet_in wait_in

    # close the group
    closeGroupDeleteSignal $module.$signal

    # outline the group
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
