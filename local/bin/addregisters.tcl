#!/usr/bin/tclsh
#
# tcl scripts to add specific Elink and Axi bus signals to the gtkwave window
#
# See gtkwave/src/tcl_commands.c for list of supported commands
# See addsignals.tcl for an example for how to use these procedures
#
# To get all the basic signals added
# gtkwave waveform.vcd -S ../../../local/bin/addelinkdvsignals.tcl &
#

#source [file join [file dirname [info script]] addhelpers.tcl]
source [file join [file dirname [info script]] addfifo.tcl]

proc addExfer_Io {name xmit module} {

    set tail_io "_io"
    set tail_lclk_io "_lclk_io"
    set tail_clkin "_clkin"
    set tail_lclk_div4 "_lclk_div4"
    set tail_access "_access"
    set tail_packet "_packet"
    set tail_data_slow "_data_slow"
    set tail_burst "_burst"
    set tail_wr_wait "_wr_wait"
    set tail_rd_wait "_rd_wait"
    set name_io $name.e$xmit$tail_io
    set module_io $module.e$xmit.e$xmit$tail_io
    
    addGroup $name_io $module_io $xmit$tail_lclk_io $xmit$tail_lclk_div4 firstedge $xmit$tail_clkin $xmit$tail_access $xmit$tail_packet tx_data tx_frame $xmit$tail_burst $xmit$tail_wr_wait $xmit$tail_rd_wait
}

proc addEtx_Protocol {name module} {
    
    set name_etx_protocol $name.etx_protocol
    set module_etx_protocol $module.etx.etx_core.etx_protocol
    
    addGroup $name_etx_protocol $module_etx_protocol etx_access etx_packet tx_enable etx_valid tx_io_wait tx_access tx_packet clk tx_wr_wait tx_rd_wait etx_wr_wait etx_rd_wait
}

proc addErx_Protocol {name module} {
    
    set name_erx_protocol $name.erx_protocol
    set module_erx_protocol $module.erx.erx_core.erx_protocol
    
    addGroup $name_erx_protocol $module_erx_protocol rx_access rx_packet rx_burst dst_addr_reg read_response erx_rdwr_access erx_rr_access erx_access erx_packet test_mode erx_test_access erx_test_data
}

proc addMMU {name module} {

    addGroup $name $module mi_wr_vec mi_addr mi_wr_data emesh_access_in emesh_packet_in emesh_access_out emesh_rd_wait emesh_wr_wait

    set emmu_rd_addr emmu_rd_addr
    set signal emesh_access_in
    addVector $module.$signal $module.$emmu_rd_addr 31 20
    moveSetFocus $module.$signal

    SetFocus $module.$signal
    set emmu_lookup_data emmu_lookup_data
    addSignals $module.$emmu_lookup_data

    set emesh_packet_reg emesh_packet_reg
    set signal emesh_access_out
    addVector $module.$signal $module.$emesh_packet_reg 7 0
    moveSetFocus $module.$signal

    set emesh_dstaddr_out emesh_dstaddr_out
    set signal emesh_access_out
    addVector $module.$signal $module.$emesh_dstaddr_out 31 0
    moveSetFocus $module.$signal
   
    set emesh_packet_reg emesh_packet_reg
    set signal emesh_access_out
    addVector $module.$signal $module.$emesh_packet_reg 103 40
    moveSetFocus $module.$signal
    
    SetFocus $name
}

proc addEtx_MMU {name module} {
    
    set name_etx_mmu $name.etx_mmu
    set module_etx_mmu $module.etx.etx_core.etx_mmu

    addMMU $name_etx_mmu $module_etx_mmu 
}

proc addErx_MMU {name module} {
    
    set name_erx_mmu $name.erx_mmu
    set module_erx_mmu $module.erx.erx_core.erx_mmu
    
    addMMU $name_erx_mmu $module_erx_mmu 
}

proc addEtx_Arbiter {name module} {
    
    set name_etx_arbiter $name.etx_arbiter
    set module_etx_arbiter $module.etx.etx_core.etx_arbiter
    
    addGroup $name_etx_arbiter $module_etx_arbiter clk txwr_grant txrd_grant txrr_grant access_in write_in etx_mux etx_access etx_packet etx_rr txwr_wait txrd_wait txrr_wait
}

proc addErx_Arbiter {name module} {
    
    set name_erx_arbiter $name.erx_arbiter
    set module_erx_arbiter $module.erx.erx_core.erx_arbiter
    
    addGroup $name_erx_arbiter $module_erx_arbiter clk timeout mi_match mi_cfg_en mi_dma_en mi_mmu_en emmu_access emmu_packet edma_access edma_packet ecfg_access ecfg_packet edma_wait ecfg_wait rxwr_access rxwr_packet rxwr_wait rxrd_access rxrd_packet rxrd_wait rxrr_access rxrr_packet rxrr_wait rx_wr_wait rx_rd_wait
}

proc addEcfg_If {name xmit module} {

    set tail_cfgif "_cfgif"
    set tail_core "_core"
    set name_ecfg_if $name.e$xmit$tail_cfgif
    set module_ecfg_if $module.e$xmit.e$xmit$tail_core.e$xmit$tail_cfgif

    # same clock as arbiter
    addGroup $name_ecfg_if $module_ecfg_if mi_match access_out data_out dstaddr mi_cfg_en mi_dma_en mi_mmu_en mi_en mi_rd mi_we mi_rx_en
}

proc addEcfg {name xmit module} {

    set tail_cfg "_cfg"
    set tail_core "_core"
    set tail_reg "_reg"
    set tail_version_reg "_version_reg"
    set tail_cfg_reg $tail_cfg$tail_reg
    set tail_gpio_reg "_gpio_reg"
    set tail_status_reg "_status_reg"
    set tail_offset_reg "_offset_reg"
    set tail_monitor_reg "_monitor_reg"
    set tail_packet_reg "_packet_reg"
    set tail_testdata_reg "_testdata_reg"
    set name_ecfg $name.e$xmit$tail_cfg
    set module_ecfg $module.e$xmit.e$xmit$tail_core.e$xmit$tail_cfg
 
    addGroup $name_ecfg $module_ecfg clk mi_en mi_we mi_addr ecfg_write mi_din $xmit$tail_version_reg $xmit$tail_cfg_reg $xmit$tail_gpio_reg $xmit$tail_status_reg $xmit$tail_offset_reg $xmit$tail_monitor_reg $xmit$tail_packet_reg ecfg_read mi_dout test_mode $xmit$tail_testdata_reg 
}

proc addRegRdWr {name module} {

    set signal sys_clk
	
    # Create a named group for the new signals
    addGroup $name.Tx $module $signal
    gtkwave::/Edit/Toggle_Group_Open|Close
    moveSetFocus $module.$signal

    addExfer_Io $name.Tx tx $module
    moveSetFocus $module.$signal

    addEtx_Protocol $name.Tx $module
    moveSetFocus $module.$signal

    addEtx_MMU $name.Tx $module
    moveSetFocus $module.$signal
    
    addEcfg $name.Tx tx $module
    moveSetFocus $module.$signal
        
    addEcfg_If $name.Tx tx $module
    moveSetFocus $module.$signal
    
    addEtx_Arbiter $name.Tx $module
    moveSetFocus $module.$signal
    
    # close the $name.Tx group
    closeGroupDeleteSignal $module.$signal
    
    collapseGroup $name.Tx

    # Create a named group for the new signals
    addGroup $name.Rx $module $signal
    gtkwave::/Edit/Toggle_Group_Open|Close
    moveSetFocus $module.$signal
    
    set fifo ecfg_cdc
    addfifoNoMove "$name.$fifo" $fifo $module
    moveSetFocus $module.$signal
    collapseGroup $name.$fifo.$fifo
    
    addEcfg $name.Rx rx $module
    moveSetFocus $module.$signal

    addEcfg_If $name.Rx rx $module
    moveSetFocus $module.$signal
    
    addErx_Arbiter $name.Rx $module
    moveSetFocus $module.$signal

    addErx_MMU $name.Rx $module
    moveSetFocus $module.$signal
    
    addErx_Protocol $name.Rx $module
    moveSetFocus $module.$signal
    
    addExfer_Io $name.Rx rx $module
    moveSetFocus $module.$signal
    
    # close the $name.Rx group
    closeGroupDeleteSignal $module.$signal
    
    collapseGroup $name.Rx
}

proc addIoWait {name module} {

    set signal sys_clk
	
    # Create a named group for the new signals
    addGroup $name $module $signal
    gtkwave::/Edit/Toggle_Group_Open|Close
    moveSetFocus $module.$signal

    addTxFifo $name $module
    moveSetFocus $module.$signal
    
    addEtx_Arbiter $name $module
    moveSetFocus $module.$signal
    
    addEtx_Protocol $name $module
    moveSetFocus $module.$signal

    addEtx_Io $name $module
    moveSetFocus $module.$signal

    collapseGroup $name
}

# Copyright (C) 2015 Peter Saunderson
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.This program is distributed in the hope 
# that it wihll be useful,but WITHOUT ANY WARRANTY; without even the implied 
# warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details. You should have received a copy 
# of the GNU General Public License along with this program (see the file 
# COPYING or LICENSE).  If not, see <http://www.gnu.org/licenses/>.
