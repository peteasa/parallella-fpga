#
# Simple tcl script for viewing parts of the Elink2 operation in Vivado Simulator
#
# Please modify the sources_1 and imports paths to suit your installation
# if you run vivado from the desktop icon and have parallella clone in root folder then no need to change.
#

set root_dir [pwd]
puts "vivado was launched in $root_dir, modify Elink2.tcl scripts in an editor to adjust paths accordingly!"

set sources_1 "$root_dir/parallella/parallella-fpga/7010_hdmi/7010_hdmi.srcs/sources_1"
set imports "$root_dir/parallella/parallella-fpga/7010_hdmi/7010_hdmi.srcs/sim_1/imports"

# Open the associated Waveform Configuration quietly so that if its already open the simulation continues
open_wave_config -quiet $root_dir/parallella/parallella-fpga/7010_hdmi/Elink2.wcfg

restart

remove_bps -all

# S_AXI_AWADDR 0,4,8,100,104 S_AXI_WDATA 1,2,3,4,5 -> fifo_write -> earb -> emtx_data -> txdata_p -> TX
# eproto_tx starts Tx
proc StartTx {sources_1 imports} {

    #        ecfg_cfgtx_reg[11:0] <= mi_din[11:0];
    add_bp $sources_1/ipshared/adapteva.com/eCfg_v1_0/909fbb94/hdl/ecfg.v 242

    run 20 us

    #        axi_wready <= ~emwr_prog_full;
    add_bp $sources_1/ipshared/adapteva.com/esaxi_v1_0/6e9ed889/hdl/esaxi_v1_0_S00_AXI.v 315

    run 10 us

    puts "*** Break in esaxi_v1_0_S00_AXI.v at start of fifo write ***"
    puts "NOTE: Remove esaxi_v1_0_S00_AXI.v 471 break point "
    puts "      After esaxi_v1_0_S00_AXI.v 315 add esaxi_v1_0_S00_AXI.v 471 break point"
    
    # emwr_wr_data <= {1'b1, wsize, ctrl_mode, aligned_addr, 32'd0, aligned_data}
    # write, only up to 32b,   dstaddr, srcaddr ignored
    add_bp $sources_1/ipshared/adapteva.com/esaxi_v1_0/6e9ed889/hdl/esaxi_v1_0_S00_AXI.v 471

    puts "<SHIFT f2> to step over each TX frame write"
    #       txframe_p <= 8'h3F;  // fifo_write read and elink TX frame asserted
    add_bp $sources_1/ipshared/adapteva.com/eproto_tx_v1_0/9b420543/hdl/eproto_tx.v 94
    
    add_bp $sources_1/ipshared/adapteva.com/eproto_tx_v1_0/9b420543/hdl/eproto_tx.v 106

    puts "NOTE: Remove eio_tx.v 107 break point when reached to proceed to end"
    # In the test the loopback_frame in eio_rx always drives the TX_FRAME_P data
    add_bp $sources_1/ipshared/adapteva.com/eio_tx_v1_0/e550e7d2/hdl/eio_tx.v 107
    add_bp $sources_1/ipshared/adapteva.com/eio_tx_v1_0/e550e7d2/hdl/eio_tx.v 100
    add_bp $sources_1/ipshared/adapteva.com/eio_tx_v1_0/e550e7d2/hdl/eio_tx.v 103
    add_bp $sources_1/ipshared/adapteva.com/eio_tx_v1_0/e550e7d2/hdl/eio_tx.v 112

    add_bp $imports/elink_test/elink2new_tb.v 80
    add_bp $imports/elink_test/elink2new_tb.v 83
    add_bp $imports/elink_test/elink2new_tb.v 87
    add_bp $imports/elink_test/elink2new_tb.v 91
    add_bp $imports/elink_test/elink2new_tb.v 95

    return
}


# read from file and write to elink_gold (note uses same shared axi_traffic_controller_v1_0_M_AXI.v)
# with files from: axi_traffic_controller_0
#    .write_data_file("../../wdata"),
#    .write_addr_file("../../waddr"),
#    .read_data_file("../../rdata0_out"),
#    .read_addr_file("../../raddr")
# Starts when done signal from axi_traffic_controller_2 (m_axi_txn_done is connected to axi_traffic_controller_0 m_axi_init_axi_txn) goes active and generates a pulse:
#
# in axi_traffic_controller_v1_0_M_AXI.v:
#
# init_txn_ff <= INIT_AXI_TXN;
# assign init_txn_pulse	= (!init_txn_ff2) && init_txn_ff;
#
# Complication is that read from file and write to elink2 (esaxi SO0_AXI) is overlapped with this in the traces.
#    .write_data_file("../../wdata"),
#    .write_addr_file("../../waddr"),
#    .read_data_file("../../rdata1_out"),
#    .read_addr_file("../../raddr")
# Starts when done signal from axi_traffic_controller_2 (m_axi_txn_done is connected to axi_traffic_controller_1 m_axi_init_axi_txn) goes active and generates a pulse.
proc WriteElinkGold {sources_1 imports} {

    # $display("=== INIT Complete");
    add_bp $imports/elink_test/elink2new_tb.v 77

    run 20 us
    
    # waddr_status = $fscanf(axi_awaddr_file, "%h", axi_awaddr); 
    add_bp $sources_1/ipshared/adapteva/axi_traffic_controller_v1_0/030c79bb/hdl/axi_traffic_controller_v1_0_M_AXI.v 488
    # raddr_status = $fscanf(axi_araddr_file, "%h", axi_araddr);
    add_bp $sources_1/ipshared/adapteva/axi_traffic_controller_v1_0/030c79bb/hdl/axi_traffic_controller_v1_0_M_AXI.v 535
    # wdata_status = $fscanf(axi_wdata_file, "%h", sim_write_buf);
    add_bp $sources_1/ipshared/adapteva/axi_traffic_controller_v1_0/030c79bb/hdl/axi_traffic_controller_v1_0_M_AXI.v 324
    # $fwrite(axi_rdata_file,"%h\n",M_AXI_RDATA);
    add_bp $sources_1/ipshared/adapteva/axi_traffic_controller_v1_0/030c79bb/hdl/axi_traffic_controller_v1_0_M_AXI.v 782

    run 10 us

    # axi_wdata <= sim_write_buf;
    add_bp $sources_1/ipshared/adapteva/axi_traffic_controller_v1_0/030c79bb/hdl/axi_traffic_controller_v1_0_M_AXI.v 514
    # axi_wdata <= sim_write_buf;
    add_bp $sources_1/ipshared/adapteva/axi_traffic_controller_v1_0/030c79bb/hdl/axi_traffic_controller_v1_0_M_AXI.v 524

    # assign M_AXI_AWADDR	= C_M_TARGET_SLAVE_BASE_ADDR + axi_awaddr;
    add_bp $sources_1/ipshared/adapteva/axi_traffic_controller_v1_0/030c79bb/hdl/axi_traffic_controller_v1_0_M_AXI.v 215
    # assign M_AXI_ARADDR	= C_M_TARGET_SLAVE_BASE_ADDR + axi_araddr;
    add_bp $sources_1/ipshared/adapteva/axi_traffic_controller_v1_0/030c79bb/hdl/axi_traffic_controller_v1_0_M_AXI.v 227
    # assign M_AXI_WDATA	= axi_wdata;
    add_bp $sources_1/ipshared/adapteva/axi_traffic_controller_v1_0/030c79bb/hdl/axi_traffic_controller_v1_0_M_AXI.v 217

    add_bp $imports/elink_test/elink2new_tb.v 80
    add_bp $imports/elink_test/elink2new_tb.v 83
    add_bp $imports/elink_test/elink2new_tb.v 87
    add_bp $imports/elink_test/elink2new_tb.v 91
    add_bp $imports/elink_test/elink2new_tb.v 95
    
    puts "<SHIFT f2> to step over read / write from / into various files"
    #
    # waddr (axi_awaddr_file): contains the addresses of the elink_gold registers
    # wdata (axi_wdata_file): contains data that is sent to the elink_gold registers matching the addresses above
    # raddr (axi_araddr_file): contains the address information for the elink_gold registers
    # rdata0_out (axi_rdata_file): stores the elink_gold registers read from the simulation compare with wdata_ecfg values
    
    return
}

# read from file and write to eCfg (note uses same shared axi_traffic_controller_v1_0_M_AXI.v)
# with files from axi_traffic_controller_2
#    .write_data_file("../../wdata_ecfg"),
#    .write_addr_file("../../waddr_ecfg"),
#    .read_data_file("../../rdata1_ecfg_out"),
#    .read_addr_file("../../raddr_ecfg")
#
# Starts when start signal (connected to axi_traffic_controller_2 m_axi_init_axi_txn) generates a pulse:
# <MODULE FULLNAME="/axi_traffic_controller_2" HWVERSION="1.0" INSTANCE="axi_traffic_controller_2" IPTYPE="PERIPHERAL" IS_ENABLE="1" MODCLASS="PERIPHERAL" MODTYPE="axi_traffic_controller" VLNV="adapteva:user:axi_traffic_controller:1.0">
#    <PORTS>
#        <PORT DIR="I" NAME="m_axi_init_axi_txn" SIGIS="undef" SIGNAME="External_Ports_start">
#          <CONNECTIONS>
#            <CONNECTION INSTANCE="External_Ports" PORT="start"/>
#          </CONNECTIONS>
#        </PORT>
#
# in axi_traffic_controller_v1_0_M_AXI.v:
#
# init_txn_ff <= INIT_AXI_TXN;
# assign init_txn_pulse	= (!init_txn_ff2) && init_txn_ff;
#
proc WriteeCfg {sources_1 imports} {

    # waddr_status = $fscanf(axi_awaddr_file, "%h", axi_awaddr); 
    add_bp $sources_1/ipshared/adapteva/axi_traffic_controller_v1_0/030c79bb/hdl/axi_traffic_controller_v1_0_M_AXI.v 488
    # raddr_status = $fscanf(axi_araddr_file, "%h", axi_araddr);
    add_bp $sources_1/ipshared/adapteva/axi_traffic_controller_v1_0/030c79bb/hdl/axi_traffic_controller_v1_0_M_AXI.v 535
    # wdata_status = $fscanf(axi_wdata_file, "%h", sim_write_buf);
    add_bp $sources_1/ipshared/adapteva/axi_traffic_controller_v1_0/030c79bb/hdl/axi_traffic_controller_v1_0_M_AXI.v 324
    # $fwrite(axi_rdata_file,"%h\n",M_AXI_RDATA);
    add_bp $sources_1/ipshared/adapteva/axi_traffic_controller_v1_0/030c79bb/hdl/axi_traffic_controller_v1_0_M_AXI.v 782

    run 10 us

    # axi_wdata <= sim_write_buf;
    add_bp $sources_1/ipshared/adapteva/axi_traffic_controller_v1_0/030c79bb/hdl/axi_traffic_controller_v1_0_M_AXI.v 514
    # axi_wdata <= sim_write_buf;
    add_bp $sources_1/ipshared/adapteva/axi_traffic_controller_v1_0/030c79bb/hdl/axi_traffic_controller_v1_0_M_AXI.v 524

    # assign M_AXI_AWADDR	= C_M_TARGET_SLAVE_BASE_ADDR + axi_awaddr;
    add_bp $sources_1/ipshared/adapteva/axi_traffic_controller_v1_0/030c79bb/hdl/axi_traffic_controller_v1_0_M_AXI.v 215
    # assign M_AXI_ARADDR	= C_M_TARGET_SLAVE_BASE_ADDR + axi_araddr;
    add_bp $sources_1/ipshared/adapteva/axi_traffic_controller_v1_0/030c79bb/hdl/axi_traffic_controller_v1_0_M_AXI.v 227
    # assign M_AXI_WDATA	= axi_wdata;
    add_bp $sources_1/ipshared/adapteva/axi_traffic_controller_v1_0/030c79bb/hdl/axi_traffic_controller_v1_0_M_AXI.v 217

    # $display("=== INIT Complete");
    add_bp $imports/elink_test/elink2new_tb.v 77
    add_bp $imports/elink_test/elink2new_tb.v 80
    add_bp $imports/elink_test/elink2new_tb.v 83
    add_bp $imports/elink_test/elink2new_tb.v 87
    add_bp $imports/elink_test/elink2new_tb.v 91
    add_bp $imports/elink_test/elink2new_tb.v 95
    
    puts "<SHIFT f2> to step over read / write from / into various files"
    #
    # waddr_ecfg (axi_awaddr_file): contains the addresses of the eCfg registers
    # wdata_ecfg (axi_wdata_file): contains data that is sent to the eCfg registers matching the addresses above
    # raddr_ecfg (axi_araddr_file): contains the address information for the eCfg registers
    # rdata1_ecfg_out (axi_rdata_file): stores the eCfg registers read from the simulation compare with wdata_ecfg values
    return
}


# elink2 eCfg registers are configured for the test
proc eCfgRegWrite {sources_1 imports} {
    add_bp $sources_1/ipshared/adapteva.com/eCfg_v1_0/909fbb94/hdl/ecfg.v 242
    add_bp $sources_1/ipshared/adapteva.com/eCfg_v1_0/909fbb94/hdl/ecfg.v 257
    add_bp $sources_1/ipshared/adapteva.com/eCfg_v1_0/909fbb94/hdl/ecfg.v 272
    add_bp $sources_1/ipshared/adapteva.com/eCfg_v1_0/909fbb94/hdl/ecfg.v 285
    add_bp $sources_1/ipshared/adapteva.com/eCfg_v1_0/909fbb94/hdl/ecfg.v 302
    add_bp $sources_1/ipshared/adapteva.com/eCfg_v1_0/909fbb94/hdl/ecfg.v 313
    add_bp $sources_1/ipshared/adapteva.com/eCfg_v1_0/909fbb94/hdl/ecfg.v 326
    add_bp $sources_1/ipshared/adapteva.com/eCfg_v1_0/909fbb94/hdl/ecfg.v 327
    add_bp $sources_1/ipshared/adapteva.com/eCfg_v1_0/909fbb94/hdl/ecfg.v 328
    add_bp $sources_1/ipshared/adapteva.com/eCfg_v1_0/909fbb94/hdl/ecfg.v 329
    add_bp $sources_1/ipshared/adapteva.com/eCfg_v1_0/909fbb94/hdl/ecfg.v 330
    add_bp $sources_1/ipshared/adapteva.com/eCfg_v1_0/909fbb94/hdl/ecfg.v 331
    add_bp $sources_1/ipshared/adapteva.com/eCfg_v1_0/909fbb94/hdl/ecfg.v 332
    add_bp $sources_1/ipshared/adapteva.com/eCfg_v1_0/909fbb94/hdl/ecfg.v 333

    add_bp $imports/elink_test/elink2new_tb.v 77
    add_bp $imports/elink_test/elink2new_tb.v 80
    add_bp $imports/elink_test/elink2new_tb.v 83
    add_bp $imports/elink_test/elink2new_tb.v 87
    add_bp $imports/elink_test/elink2new_tb.v 91
    add_bp $imports/elink_test/elink2new_tb.v 95
    
    run 20 us

    puts "<SHIFT f2> to step over register writes"
    #
    # 0x40 <= 0x1: elink in reset
    # 0x44 <= 0x1: link TX enable
    # 0x48 <= 0x1: link RX enable
    # 0x4c <= 0x7: CLKIN/1 (full speed)
    # 0x50 <= 0x810: core Id
    # 0x5c <= 0x765: ecfg_dataout_reg <= 0x765
    #
    # then read the registers back.. (see values in file rdata_1_ecfg_out)
    # mi_dout <= *0x50: 0x810 
    # mi_dout <= *0x54: 0x1030303 (E_VERSION)
    # mi_dout <= *0x58: 0x0XX (ecfg_datain_reg but its not defined at this time)
    # mi_dout <= *0x5c: 0x765 (ecfg_dataout_reg)

    return
}

# Uncomment this for eCfgRegWrite
[eCfgRegWrite $sources_1 $imports]

# Uncomment this for WriteeCfg
# [WriteeCfg $sources_1 $imports]

# Uncomment this for WriteElinkGold (and write to elink2)
# [WriteElinkGold $sources_1 $imports]

# Uncomment this for tracing ELINK2 -> Gold
# [StartTx $sources_1 $imports]

puts "Uncomment one at a time the part of the script of interest and reload"
