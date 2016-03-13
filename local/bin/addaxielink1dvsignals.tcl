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
source [file join [file dirname [info script]] addaxielinkxdvsignals.tcl]

addAxiElinkXDVSignals elink1

# Disable the full signal hierarchy for better viewing
gtkwave::/Edit/UnHighlight_All
gtkwave::/Edit/Toggle_Trace_Hier

# gtkwave::/Edit/Combine_Down $outputs

# Prepare the screen for use
gtkwave::setWindowStartTime 1.5us
gtkwave::setZoomRangeTimes 1.5us 30us
# gtkwave::setZoomFactor zoom_value

# Copyright (C) 2015-2016 Peter Saunderson
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.This program is distributed in the hope 
# that it will be useful,but WITHOUT ANY WARRANTY; without even the implied 
# warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details. You should have received a copy 
# of the GNU General Public License along with this program (see the file 
# COPYING or LICENSE).  If not, see <http://www.gnu.org/licenses/>.
