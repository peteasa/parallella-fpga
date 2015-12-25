#!/usr/bin/tclsh
#
# tcl script to add specific signals to the gtkwave window
#
# See gtkwave/src/tcl_commands.c for list of supported commands
# See addlinkdvsignals.tcl for an example for how to use these procedures

# Procedure to add signal vector after signal
proc addVector {signal name up low} {
    gtkwave::/Edit/UnHighlight_All
    gtkwave::setTraceHighlightFromNameMatch $signal on
    set group [list]
    for {set i $up} {$i >= $low} {incr i -1} {
	lappend group "$name\[$i\]"
    }
    set num_added [ gtkwave::addSignalsFromList $group ]
    gtkwave::/Edit/Combine_Down $name$up\_$low
    gtkwave::/Edit/UnHighlight_All
    gtkwave::setTraceHighlightFromNameMatch $name$up\_$low on
    gtkwave::/Edit/Toggle_Group_Open|Close
}

# Procedure to add variable number of signals
proc addSignals {args} {
    set names [ split $args " " ]
    set group [list]
    foreach a $names {
	lappend group "$a"
    }
    set num_added [ gtkwave::addSignalsFromList $group ]
}

# Procedure to add a variable number of signals from a module
proc addModuleSignals {module args} {
    set names [ split $args " " ]
    set group [list]
    foreach a $names {
	lappend group "$module.$a"
    }
    set num_added [ gtkwave::addSignalsFromList $group ]
}

# Procedure to add variable number of signals from a module to a named group
proc addGroup {name module args} {
    gtkwave::/Edit/UnHighlight_All
    set names [ split $args " " ]
    set group [list]
    foreach a $names {
	lappend group "$module.$a"
    }
    set num_added [ gtkwave::addSignalsFromList $group ]
    gtkwave::/Edit/Create_Group $name

    # collapse the group to its title
    gtkwave::/Edit/Toggle_Group_Open|Close
}

# Procedure to set focus on a specific group
proc SetFocus {name} {
    gtkwave::/Edit/UnHighlight_All
    gtkwave::setTraceHighlightFromNameMatch $name on
}

# Procedure to move the previously selected group at a given signal position
# leaving the group open
# Using a signal name it is possible to anchor all additions into specific
# locations in the groups
proc moveSetFocus {name} {
    gtkwave::/Edit/Cut
    SetFocus $name
    gtkwave::/Edit/Paste
}

# Procedure to close the group
proc closeGroup {} {
    gtkwave::/Edit/UnHighlight_All
}

# Procedure to close the group and delete the named signal
# delete the anchor signal if it is going to be used again!
proc closeGroupDeleteSignal {name} {
    gtkwave::/Edit/UnHighlight_All
    gtkwave::setTraceHighlightFromNameMatch $name on
    gtkwave::/Edit/Cut
    gtkwave::/Edit/UnHighlight_All
}

# Procedure to collapse a named group
proc collapseGroup {name} {
    gtkwave::/Edit/UnHighlight_All
    gtkwave::setTraceHighlightFromNameMatch $name on
    gtkwave::/Edit/Toggle_Group_Open|Close
    gtkwave::/Edit/UnHighlight_All
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

