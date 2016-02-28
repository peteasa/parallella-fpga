// DUT based on oh/elink/dv/dut_axi_elink.v
//
`include "elink_regmap.v"
module dut(/*AUTOARG*/
   // Outputs
   dut_active, wait_out, access_out, packet_out,
   // Inputs
   clk, nreset, vdd, vss, access_in, packet_in, wait_in
   );

   //##########################################################################
   //# INTERFACE
   //##########################################################################

   parameter AW    = 32;
   parameter ID    = 12'h810;
   parameter S_IDW = 12;
   parameter S2_IDW = 12;
   
   parameter M_IDW = 6;
   parameter M2_IDW = 6;
   parameter PW    = 2*AW + 40;
   parameter N     = 1;
   parameter RETURN_ADDR = {ID,
			    `EGROUP_RR,
			    16'b0};          // axi return addr

   //clock,reset
   input            clk;
   input            nreset;
   input [N*N-1:0]  vdd;
   input 	    vss;
   output 	    dut_active;
   
   //Stimulus Driven Transaction
   input [N-1:0]     access_in;
   input [N*PW-1:0]  packet_in;
   output [N-1:0]    wait_out;

   //DUT driven transaction
   output [N-1:0]    access_out;
   output [N*PW-1:0] packet_out;
   input [N-1:0]     wait_in;

   //##########################################################################
   //#BODY
   //##########################################################################

   wire 	     mem_rd_wait;
   wire 	     mem_wr_wait;
   wire 	     mem_access;
   wire [PW-1:0]     mem_packet;

   /*AUTOINPUT*/

   // End of automatics
   /*AUTOWIRE*/
   // Beginning of automatic wires (for undeclared instantiated-module outputs)
   wire			elink0_cclk_n;		// From elink0 of axi_elink.v
   wire			elink0_cclk_p;		// From elink0 of axi_elink.v
   wire			elink0_chip_nreset;	// From elink0 of axi_elink.v
   wire [11:0]		elink0_chipid;		// From elink0 of axi_elink.v
   wire [31:0]		elink0_m_axi_araddr;	// From elink0 of axi_elink.v
   wire [1:0]		elink0_m_axi_arburst;	// From elink0 of axi_elink.v
   wire [3:0]		elink0_m_axi_arcache;	// From elink0 of axi_elink.v
   wire [M_IDW-1:0]	elink0_m_axi_arid;	// From elink0 of axi_elink.v
   wire [7:0]		elink0_m_axi_arlen;	// From elink0 of axi_elink.v
   wire			elink0_m_axi_arlock;	// From elink0 of axi_elink.v
   wire [2:0]		elink0_m_axi_arprot;	// From elink0 of axi_elink.v
   wire [3:0]		elink0_m_axi_arqos;	// From elink0 of axi_elink.v
   wire			elink0_m_axi_arready;	// From axislave_stub of axislave_stub.v
   wire [2:0]		elink0_m_axi_arsize;	// From elink0 of axi_elink.v
   wire			elink0_m_axi_arvalid;	// From elink0 of axi_elink.v
   wire [31:0]		elink0_m_axi_awaddr;	// From elink0 of axi_elink.v
   wire [1:0]		elink0_m_axi_awburst;	// From elink0 of axi_elink.v
   wire [3:0]		elink0_m_axi_awcache;	// From elink0 of axi_elink.v
   wire [M_IDW-1:0]	elink0_m_axi_awid;	// From elink0 of axi_elink.v
   wire [7:0]		elink0_m_axi_awlen;	// From elink0 of axi_elink.v
   wire			elink0_m_axi_awlock;	// From elink0 of axi_elink.v
   wire [2:0]		elink0_m_axi_awprot;	// From elink0 of axi_elink.v
   wire [3:0]		elink0_m_axi_awqos;	// From elink0 of axi_elink.v
   wire			elink0_m_axi_awready;	// From axislave_stub of axislave_stub.v
   wire [2:0]		elink0_m_axi_awsize;	// From elink0 of axi_elink.v
   wire			elink0_m_axi_awvalid;	// From elink0 of axi_elink.v
   wire [S_IDW-1:0]	elink0_m_axi_bid;	// From axislave_stub of axislave_stub.v
   wire			elink0_m_axi_bready;	// From elink0 of axi_elink.v
   wire [1:0]		elink0_m_axi_bresp;	// From axislave_stub of axislave_stub.v
   wire			elink0_m_axi_bvalid;	// From axislave_stub of axislave_stub.v
   wire [31:0]		elink0_m_axi_rdata;	// From axislave_stub of axislave_stub.v
   wire [S_IDW-1:0]	elink0_m_axi_rid;	// From axislave_stub of axislave_stub.v
   wire			elink0_m_axi_rlast;	// From axislave_stub of axislave_stub.v
   wire			elink0_m_axi_rready;	// From elink0 of axi_elink.v
   wire [1:0]		elink0_m_axi_rresp;	// From axislave_stub of axislave_stub.v
   wire			elink0_m_axi_rvalid;	// From axislave_stub of axislave_stub.v
   wire [63:0]		elink0_m_axi_wdata;	// From elink0 of axi_elink.v
   wire [M_IDW-1:0]	elink0_m_axi_wid;	// From elink0 of axi_elink.v
   wire			elink0_m_axi_wlast;	// From elink0 of axi_elink.v
   wire			elink0_m_axi_wready;	// From axislave_stub of axislave_stub.v
   wire [7:0]		elink0_m_axi_wstrb;	// From elink0 of axi_elink.v
   wire			elink0_m_axi_wvalid;	// From elink0 of axi_elink.v
   wire			elink0_mailbox_irq;	// From elink0 of axi_elink.v
   wire			elink0_rxo_rd_wait_n;	// From elink0 of axi_elink.v
   wire			elink0_rxo_rd_wait_p;	// From elink0 of axi_elink.v
   wire			elink0_rxo_wr_wait_n;	// From elink0 of axi_elink.v
   wire			elink0_rxo_wr_wait_p;	// From elink0 of axi_elink.v
   wire [7:0]		elink0_txo_data_n;	// From elink0 of axi_elink.v
   wire [7:0]		elink0_txo_data_p;	// From elink0 of axi_elink.v
   wire			elink0_txo_frame_n;	// From elink0 of axi_elink.v
   wire			elink0_txo_frame_p;	// From elink0 of axi_elink.v
   wire			elink0_txo_lclk_n;	// From elink0 of axi_elink.v
   wire			elink0_txo_lclk_p;	// From elink0 of axi_elink.v
   wire			elink1_cclk_n;		// From elink1 of axi_elink.v
   wire			elink1_cclk_p;		// From elink1 of axi_elink.v
   wire			elink1_chip_nreset;	// From elink1 of axi_elink.v
   wire [11:0]		elink1_chipid;		// From elink1 of axi_elink.v
   wire			elink1_elink_active;	// From elink1 of axi_elink.v
   wire			elink1_mailbox_irq;	// From elink1 of axi_elink.v
   wire			elink1_rxo_rd_wait_n;	// From elink1 of axi_elink.v
   wire			elink1_rxo_rd_wait_p;	// From elink1 of axi_elink.v
   wire			elink1_rxo_wr_wait_n;	// From elink1 of axi_elink.v
   wire			elink1_rxo_wr_wait_p;	// From elink1 of axi_elink.v
   wire [7:0]		elink1_txo_data_n;	// From elink1 of axi_elink.v
   wire [7:0]		elink1_txo_data_p;	// From elink1 of axi_elink.v
   wire			elink1_txo_frame_n;	// From elink1 of axi_elink.v
   wire			elink1_txo_frame_p;	// From elink1 of axi_elink.v
   wire			elink1_txo_lclk_n;	// From elink1 of axi_elink.v
   wire			elink1_txo_lclk_p;	// From elink1 of axi_elink.v
   wire [31:0]		ext1_m_axi_araddr;	// From emaxi of emaxi.v
   wire [1:0]		ext1_m_axi_arburst;	// From emaxi of emaxi.v
   wire [3:0]		ext1_m_axi_arcache;	// From emaxi of emaxi.v
   wire [M_IDW-1:0]	ext1_m_axi_arid;	// From emaxi of emaxi.v
   wire [7:0]		ext1_m_axi_arlen;	// From emaxi of emaxi.v
   wire			ext1_m_axi_arlock;	// From emaxi of emaxi.v
   wire [2:0]		ext1_m_axi_arprot;	// From emaxi of emaxi.v
   wire [3:0]		ext1_m_axi_arqos;	// From emaxi of emaxi.v
   wire			ext1_m_axi_arready;	// From elink1 of axi_elink.v
   wire [2:0]		ext1_m_axi_arsize;	// From emaxi of emaxi.v
   wire			ext1_m_axi_arvalid;	// From emaxi of emaxi.v
   wire [31:0]		ext1_m_axi_awaddr;	// From emaxi of emaxi.v
   wire [1:0]		ext1_m_axi_awburst;	// From emaxi of emaxi.v
   wire [3:0]		ext1_m_axi_awcache;	// From emaxi of emaxi.v
   wire [M_IDW-1:0]	ext1_m_axi_awid;	// From emaxi of emaxi.v
   wire [7:0]		ext1_m_axi_awlen;	// From emaxi of emaxi.v
   wire			ext1_m_axi_awlock;	// From emaxi of emaxi.v
   wire [2:0]		ext1_m_axi_awprot;	// From emaxi of emaxi.v
   wire [3:0]		ext1_m_axi_awqos;	// From emaxi of emaxi.v
   wire			ext1_m_axi_awready;	// From elink1 of axi_elink.v
   wire [2:0]		ext1_m_axi_awsize;	// From emaxi of emaxi.v
   wire			ext1_m_axi_awvalid;	// From emaxi of emaxi.v
   wire [S_IDW-1:0]	ext1_m_axi_bid;		// From elink1 of axi_elink.v
   wire			ext1_m_axi_bready;	// From emaxi of emaxi.v
   wire [1:0]		ext1_m_axi_bresp;	// From elink1 of axi_elink.v
   wire			ext1_m_axi_bvalid;	// From elink1 of axi_elink.v
   wire [31:0]		ext1_m_axi_rdata;	// From elink1 of axi_elink.v
   wire [S_IDW-1:0]	ext1_m_axi_rid;		// From elink1 of axi_elink.v
   wire			ext1_m_axi_rlast;	// From elink1 of axi_elink.v
   wire			ext1_m_axi_rready;	// From emaxi of emaxi.v
   wire [1:0]		ext1_m_axi_rresp;	// From elink1 of axi_elink.v
   wire			ext1_m_axi_rvalid;	// From elink1 of axi_elink.v
   wire [63:0]		ext1_m_axi_wdata;	// From emaxi of emaxi.v
   wire [M_IDW-1:0]	ext1_m_axi_wid;		// From emaxi of emaxi.v
   wire			ext1_m_axi_wlast;	// From emaxi of emaxi.v
   wire			ext1_m_axi_wready;	// From elink1 of axi_elink.v
   wire [7:0]		ext1_m_axi_wstrb;	// From emaxi of emaxi.v
   wire			ext1_m_axi_wvalid;	// From emaxi of emaxi.v
   wire [31:0]		m_axi_araddr;		// From emaxi of emaxi.v
   wire [1:0]		m_axi_arburst;		// From emaxi of emaxi.v
   wire [3:0]		m_axi_arcache;		// From emaxi of emaxi.v
   wire [M_IDW-1:0]	m_axi_arid;		// From emaxi of emaxi.v
   wire [7:0]		m_axi_arlen;		// From emaxi of emaxi.v
   wire			m_axi_arlock;		// From emaxi of emaxi.v
   wire [2:0]		m_axi_arprot;		// From emaxi of emaxi.v
   wire [3:0]		m_axi_arqos;		// From emaxi of emaxi.v
   wire			m_axi_arready;		// From elink0 of axi_elink.v
   wire [2:0]		m_axi_arsize;		// From emaxi of emaxi.v
   wire			m_axi_arvalid;		// From emaxi of emaxi.v
   wire [31:0]		m_axi_awaddr;		// From emaxi of emaxi.v
   wire [1:0]		m_axi_awburst;		// From emaxi of emaxi.v
   wire [3:0]		m_axi_awcache;		// From emaxi of emaxi.v
   wire [M_IDW-1:0]	m_axi_awid;		// From emaxi of emaxi.v
   wire [7:0]		m_axi_awlen;		// From emaxi of emaxi.v
   wire			m_axi_awlock;		// From emaxi of emaxi.v
   wire [2:0]		m_axi_awprot;		// From emaxi of emaxi.v
   wire [3:0]		m_axi_awqos;		// From emaxi of emaxi.v
   wire			m_axi_awready;		// From elink0 of axi_elink.v
   wire [2:0]		m_axi_awsize;		// From emaxi of emaxi.v
   wire			m_axi_awvalid;		// From emaxi of emaxi.v
   wire [S_IDW-1:0]	m_axi_bid;		// From elink0 of axi_elink.v
   wire			m_axi_bready;		// From emaxi of emaxi.v
   wire [1:0]		m_axi_bresp;		// From elink0 of axi_elink.v
   wire			m_axi_bvalid;		// From elink0 of axi_elink.v
   wire [31:0]		m_axi_rdata;		// From elink0 of axi_elink.v
   wire [S_IDW-1:0]	m_axi_rid;		// From elink0 of axi_elink.v
   wire			m_axi_rlast;		// From elink0 of axi_elink.v
   wire			m_axi_rready;		// From emaxi of emaxi.v
   wire [1:0]		m_axi_rresp;		// From elink0 of axi_elink.v
   wire			m_axi_rvalid;		// From elink0 of axi_elink.v
   wire [63:0]		m_axi_wdata;		// From emaxi of emaxi.v
   wire [M_IDW-1:0]	m_axi_wid;		// From emaxi of emaxi.v
   wire			m_axi_wlast;		// From emaxi of emaxi.v
   wire			m_axi_wready;		// From elink0 of axi_elink.v
   wire [7:0]		m_axi_wstrb;		// From emaxi of emaxi.v
   wire			m_axi_wvalid;		// From emaxi of emaxi.v
   wire [31:0]		mem_m_axi_araddr;	// From elink1 of axi_elink.v
   wire [1:0]		mem_m_axi_arburst;	// From elink1 of axi_elink.v
   wire [3:0]		mem_m_axi_arcache;	// From elink1 of axi_elink.v
   wire [M_IDW-1:0]	mem_m_axi_arid;		// From elink1 of axi_elink.v
   wire [7:0]		mem_m_axi_arlen;	// From elink1 of axi_elink.v
   wire			mem_m_axi_arlock;	// From elink1 of axi_elink.v
   wire [2:0]		mem_m_axi_arprot;	// From elink1 of axi_elink.v
   wire [3:0]		mem_m_axi_arqos;	// From elink1 of axi_elink.v
   wire			mem_m_axi_arready;	// From esaxi of esaxi.v
   wire [2:0]		mem_m_axi_arsize;	// From elink1 of axi_elink.v
   wire			mem_m_axi_arvalid;	// From elink1 of axi_elink.v
   wire [31:0]		mem_m_axi_awaddr;	// From elink1 of axi_elink.v
   wire [1:0]		mem_m_axi_awburst;	// From elink1 of axi_elink.v
   wire [3:0]		mem_m_axi_awcache;	// From elink1 of axi_elink.v
   wire [M_IDW-1:0]	mem_m_axi_awid;		// From elink1 of axi_elink.v
   wire [7:0]		mem_m_axi_awlen;	// From elink1 of axi_elink.v
   wire			mem_m_axi_awlock;	// From elink1 of axi_elink.v
   wire [2:0]		mem_m_axi_awprot;	// From elink1 of axi_elink.v
   wire [3:0]		mem_m_axi_awqos;	// From elink1 of axi_elink.v
   wire			mem_m_axi_awready;	// From esaxi of esaxi.v
   wire [2:0]		mem_m_axi_awsize;	// From elink1 of axi_elink.v
   wire			mem_m_axi_awvalid;	// From elink1 of axi_elink.v
   wire [S_IDW-1:0]	mem_m_axi_bid;		// From esaxi of esaxi.v
   wire			mem_m_axi_bready;	// From elink1 of axi_elink.v
   wire [1:0]		mem_m_axi_bresp;	// From esaxi of esaxi.v
   wire			mem_m_axi_bvalid;	// From esaxi of esaxi.v
   wire [31:0]		mem_m_axi_rdata;	// From esaxi of esaxi.v
   wire [S_IDW-1:0]	mem_m_axi_rid;		// From esaxi of esaxi.v
   wire			mem_m_axi_rlast;	// From esaxi of esaxi.v
   wire			mem_m_axi_rready;	// From elink1 of axi_elink.v
   wire [1:0]		mem_m_axi_rresp;	// From esaxi of esaxi.v
   wire			mem_m_axi_rvalid;	// From esaxi of esaxi.v
   wire [63:0]		mem_m_axi_wdata;	// From elink1 of axi_elink.v
   wire [M_IDW-1:0]	mem_m_axi_wid;		// From elink1 of axi_elink.v
   wire			mem_m_axi_wlast;	// From elink1 of axi_elink.v
   wire			mem_m_axi_wready;	// From esaxi of esaxi.v
   wire [7:0]		mem_m_axi_wstrb;	// From elink1 of axi_elink.v
   wire			mem_m_axi_wvalid;	// From elink1 of axi_elink.v
   wire			mem_rd_access;		// From esaxi of esaxi.v
   wire [PW-1:0]	mem_rd_packet;		// From esaxi of esaxi.v
   wire			mem_rr_access;		// From ememory of ememory.v
   wire [PW-1:0]	mem_rr_packet;		// From ememory of ememory.v
   wire			mem_rr_wait;		// From esaxi of esaxi.v
   wire			mem_wait;		// From ememory of ememory.v
   wire			mem_wr_access;		// From esaxi of esaxi.v
   wire [PW-1:0]	mem_wr_packet;		// From esaxi of esaxi.v
   wire			rd_wait;		// From emaxi of emaxi.v, ...
   wire			rr_access;		// From emaxi of emaxi.v
   wire [PW-1:0]	rr_packet;		// From emaxi of emaxi.v
   wire			wr_wait;		// From emaxi of emaxi.v, ...
   // End of automatics

   // Provide an easy way to send mailbox messages to elink0 via the 0x910 address
   wire 		elink0_access_in;
   wire 		elink1_access_in;
   wire 		ext1_write_in;
   wire 		ext1_read_in;
   
   assign elink0_access_in = access_in &
				   (packet_in[39:28]==12'h810  |
				    packet_in[39:28]==12'h808 |
				    packet_in[39:28]==12'h920);
   
   assign elink1_access_in = access_in &
				   (packet_in[39:28]==12'h820 |
				    packet_in[39:28]==12'h910);
   
   assign ext1_write_in = elink1_access_in & packet_in[0];
   assign ext1_read_in  = elink1_access_in & ~packet_in[0];
   

   //######################################################################
   //AXI MASTER
   //######################################################################
   wire 		write_in;
   wire 		read_in;
   
   //Split stimulus to read/write
   assign wait_out = wr_wait | rd_wait;
   assign write_in = elink0_access_in & packet_in[0];
   assign read_in  = elink0_access_in & ~packet_in[0];

   //######################################################################
   //AXI MASTER (DRIVES STIMULUS) to configure elink0
   //######################################################################
    /*emaxi AUTO_TEMPLATE (//Stimulus
               .m_axi_aresetn		(nreset),
               .m_axi_aclk		(clk),
               .m_axi_rdata		({m_axi_rdata[31:0],m_axi_rdata[31:0]}),
               .m_\(.*\)           	(m_\1[]),
               .rr_wait		   	(wait_in),
               .rr_access		(access_out),
               .rr_packet		(packet_out[PW-1:0]),
               .wr_access		(write_in),
               .wr_packet		(packet_in[PW-1:0]),
               .rd_access		(read_in),
               .rd_packet		(packet_in[PW-1:0]),
     );
     */

   emaxi #(.M_IDW(M_IDW))
   emaxi0 (/*AUTOINST*/
	  // Outputs
	  .wr_wait			(wr_wait),
	  .rd_wait			(rd_wait),
	  .rr_access			(access_out),		 // Templated
	  .rr_packet			(packet_out[PW-1:0]),	 // Templated
	  .m_axi_awid			(m_axi_awid[M_IDW-1:0]), // Templated
	  .m_axi_awaddr			(m_axi_awaddr[31:0]),	 // Templated
	  .m_axi_awlen			(m_axi_awlen[7:0]),	 // Templated
	  .m_axi_awsize			(m_axi_awsize[2:0]),	 // Templated
	  .m_axi_awburst		(m_axi_awburst[1:0]),	 // Templated
	  .m_axi_awlock			(m_axi_awlock),		 // Templated
	  .m_axi_awcache		(m_axi_awcache[3:0]),	 // Templated
	  .m_axi_awprot			(m_axi_awprot[2:0]),	 // Templated
	  .m_axi_awqos			(m_axi_awqos[3:0]),	 // Templated
	  .m_axi_awvalid		(m_axi_awvalid),	 // Templated
	  .m_axi_wid			(m_axi_wid[M_IDW-1:0]),	 // Templated
	  .m_axi_wdata			(m_axi_wdata[63:0]),	 // Templated
	  .m_axi_wstrb			(m_axi_wstrb[7:0]),	 // Templated
	  .m_axi_wlast			(m_axi_wlast),		 // Templated
	  .m_axi_wvalid			(m_axi_wvalid),		 // Templated
	  .m_axi_bready			(m_axi_bready),		 // Templated
	  .m_axi_arid			(m_axi_arid[M_IDW-1:0]), // Templated
	  .m_axi_araddr			(m_axi_araddr[31:0]),	 // Templated
	  .m_axi_arlen			(m_axi_arlen[7:0]),	 // Templated
	  .m_axi_arsize			(m_axi_arsize[2:0]),	 // Templated
	  .m_axi_arburst		(m_axi_arburst[1:0]),	 // Templated
	  .m_axi_arlock			(m_axi_arlock),		 // Templated
	  .m_axi_arcache		(m_axi_arcache[3:0]),	 // Templated
	  .m_axi_arprot			(m_axi_arprot[2:0]),	 // Templated
	  .m_axi_arqos			(m_axi_arqos[3:0]),	 // Templated
	  .m_axi_arvalid		(m_axi_arvalid),	 // Templated
	  .m_axi_rready			(m_axi_rready),		 // Templated
	  // Inputs
	  .wr_access			(write_in),		 // Templated
	  .wr_packet			(packet_in[PW-1:0]),	 // Templated
	  .rd_access			(read_in),		 // Templated
	  .rd_packet			(packet_in[PW-1:0]),	 // Templated
	  .rr_wait			(wait_in),		 // Templated
	  .m_axi_aclk			(clk),			 // Templated
	  .m_axi_aresetn		(nreset),		 // Templated
	  .m_axi_awready		(m_axi_awready),	 // Templated
	  .m_axi_wready			(m_axi_wready),		 // Templated
	  .m_axi_bid			(m_axi_bid[M_IDW-1:0]),	 // Templated
	  .m_axi_bresp			(m_axi_bresp[1:0]),	 // Templated
	  .m_axi_bvalid			(m_axi_bvalid),		 // Templated
	  .m_axi_arready		(m_axi_arready),	 // Templated
	  .m_axi_rid			(m_axi_rid[M_IDW-1:0]),	 // Templated
	  .m_axi_rdata			({m_axi_rdata[31:0],m_axi_rdata[31:0]}), // Templated
	  .m_axi_rresp			(m_axi_rresp[1:0]),	 // Templated
	  .m_axi_rlast			(m_axi_rlast),		 // Templated
	  .m_axi_rvalid			(m_axi_rvalid));		 // Templated

   //######################################################################
   //ELINK
   //######################################################################

   /*axi_elink AUTO_TEMPLATE (.m_axi_aresetn      (nreset),
                              .s_axi_aresetn      (nreset),
                              .sys_nreset         (nreset),
                              .s_\(.*\)           (m_\1[]),
                              .sys_clk            (clk),
                              .rxi_\(.*\)         (elink1_txo_\1[]),
                              .txi_\(.*\)         (elink1_rxo_\1[]),
                              .\(.*\)             (@"(substring vl-cell-name  0 6)"_\1[]),
                         );
  */

   axi_elink #(.ID(12'h810),
	       .ETYPE(0))
   elink0 (.elink_active  (dut_active),
	   .s_axi_wstrb	  ((m_axi_wstrb[3:0] | m_axi_wstrb[7:4])),//NOTE:HACK!!
	   .m_axi_rdata			({mem_m_axi_rdata[31:0],mem_m_axi_rdata[31:0]}),
	   /*AUTOINST*/
	   // Outputs
	   .rxo_wr_wait_p		(elink0_rxo_wr_wait_p),	 // Templated
	   .rxo_wr_wait_n		(elink0_rxo_wr_wait_n),	 // Templated
	   .rxo_rd_wait_p		(elink0_rxo_rd_wait_p),	 // Templated
	   .rxo_rd_wait_n		(elink0_rxo_rd_wait_n),	 // Templated
	   .txo_lclk_p			(elink0_txo_lclk_p),	 // Templated
	   .txo_lclk_n			(elink0_txo_lclk_n),	 // Templated
	   .txo_frame_p			(elink0_txo_frame_p),	 // Templated
	   .txo_frame_n			(elink0_txo_frame_n),	 // Templated
	   .txo_data_p			(elink0_txo_data_p[7:0]), // Templated
	   .txo_data_n			(elink0_txo_data_n[7:0]), // Templated
	   .chipid			(elink0_chipid[11:0]),	 // Templated
	   .chip_nreset			(elink0_chip_nreset),	 // Templated
	   .cclk_p			(elink0_cclk_p),	 // Templated
	   .cclk_n			(elink0_cclk_n),	 // Templated
	   .mailbox_irq			(elink0_mailbox_irq),	 // Templated
	   .m_axi_awid			(elink0_m_axi_awid[M_IDW-1:0]), // Templated
	   .m_axi_awaddr		(elink0_m_axi_awaddr[31:0]), // Templated
	   .m_axi_awlen			(elink0_m_axi_awlen[7:0]), // Templated
	   .m_axi_awsize		(elink0_m_axi_awsize[2:0]), // Templated
	   .m_axi_awburst		(elink0_m_axi_awburst[1:0]), // Templated
	   .m_axi_awlock		(elink0_m_axi_awlock),	 // Templated
	   .m_axi_awcache		(elink0_m_axi_awcache[3:0]), // Templated
	   .m_axi_awprot		(elink0_m_axi_awprot[2:0]), // Templated
	   .m_axi_awqos			(elink0_m_axi_awqos[3:0]), // Templated
	   .m_axi_awvalid		(elink0_m_axi_awvalid),	 // Templated
	   .m_axi_wid			(elink0_m_axi_wid[M_IDW-1:0]), // Templated
	   .m_axi_wdata			(elink0_m_axi_wdata[63:0]), // Templated
	   .m_axi_wstrb			(elink0_m_axi_wstrb[7:0]), // Templated
	   .m_axi_wlast			(elink0_m_axi_wlast),	 // Templated
	   .m_axi_wvalid		(elink0_m_axi_wvalid),	 // Templated
	   .m_axi_bready		(elink0_m_axi_bready),	 // Templated
	   .m_axi_arid			(elink0_m_axi_arid[M_IDW-1:0]), // Templated
	   .m_axi_araddr		(elink0_m_axi_araddr[31:0]), // Templated
	   .m_axi_arlen			(elink0_m_axi_arlen[7:0]), // Templated
	   .m_axi_arsize		(elink0_m_axi_arsize[2:0]), // Templated
	   .m_axi_arburst		(elink0_m_axi_arburst[1:0]), // Templated
	   .m_axi_arlock		(elink0_m_axi_arlock),	 // Templated
	   .m_axi_arcache		(elink0_m_axi_arcache[3:0]), // Templated
	   .m_axi_arprot		(elink0_m_axi_arprot[2:0]), // Templated
	   .m_axi_arqos			(elink0_m_axi_arqos[3:0]), // Templated
	   .m_axi_arvalid		(elink0_m_axi_arvalid),	 // Templated
	   .m_axi_rready		(elink0_m_axi_rready),	 // Templated
	   .s_axi_arready		(m_axi_arready),	 // Templated
	   .s_axi_awready		(m_axi_awready),	 // Templated
	   .s_axi_bid			(m_axi_bid[S_IDW-1:0]),	 // Templated
	   .s_axi_bresp			(m_axi_bresp[1:0]),	 // Templated
	   .s_axi_bvalid		(m_axi_bvalid),		 // Templated
	   .s_axi_rid			(m_axi_rid[S_IDW-1:0]),	 // Templated
	   .s_axi_rdata			(m_axi_rdata[31:0]),	 // Templated
	   .s_axi_rlast			(m_axi_rlast),		 // Templated
	   .s_axi_rresp			(m_axi_rresp[1:0]),	 // Templated
	   .s_axi_rvalid		(m_axi_rvalid),		 // Templated
	   .s_axi_wready		(m_axi_wready),		 // Templated
	   // Inputs
	   .sys_nreset			(nreset),		 // Templated
	   .sys_clk			(clk),			 // Templated
	   .rxi_lclk_p			(elink1_txo_lclk_p),	 // Templated
	   .rxi_lclk_n			(elink1_txo_lclk_n),	 // Templated
	   .rxi_frame_p			(elink1_txo_frame_p),	 // Templated
	   .rxi_frame_n			(elink1_txo_frame_n),	 // Templated
	   .rxi_data_p			(elink1_txo_data_p[7:0]), // Templated
	   .rxi_data_n			(elink1_txo_data_n[7:0]), // Templated
	   .txi_wr_wait_p		(elink1_rxo_wr_wait_p),	 // Templated
	   .txi_wr_wait_n		(elink1_rxo_wr_wait_n),	 // Templated
	   .txi_rd_wait_p		(elink1_rxo_rd_wait_p),	 // Templated
	   .txi_rd_wait_n		(elink1_rxo_rd_wait_n),	 // Templated
	   .m_axi_aresetn		(nreset),		 // Templated
	   .m_axi_awready		(elink0_m_axi_awready),	 // Templated
	   .m_axi_wready		(elink0_m_axi_wready),	 // Templated
	   .m_axi_bid			(elink0_m_axi_bid[M_IDW-1:0]), // Templated
	   .m_axi_bresp			(elink0_m_axi_bresp[1:0]), // Templated
	   .m_axi_bvalid		(elink0_m_axi_bvalid),	 // Templated
	   .m_axi_arready		(elink0_m_axi_arready),	 // Templated
	   .m_axi_rid			(elink0_m_axi_rid[M_IDW-1:0]), // Templated
	   .m_axi_rresp			(elink0_m_axi_rresp[1:0]), // Templated
	   .m_axi_rlast			(elink0_m_axi_rlast),	 // Templated
	   .m_axi_rvalid		(elink0_m_axi_rvalid),	 // Templated
	   .s_axi_aresetn		(nreset),		 // Templated
	   .s_axi_arid			(m_axi_arid[S_IDW-1:0]), // Templated
	   .s_axi_araddr		(m_axi_araddr[31:0]),	 // Templated
	   .s_axi_arburst		(m_axi_arburst[1:0]),	 // Templated
	   .s_axi_arcache		(m_axi_arcache[3:0]),	 // Templated
	   .s_axi_arlock		(m_axi_arlock),		 // Templated
	   .s_axi_arlen			(m_axi_arlen[7:0]),	 // Templated
	   .s_axi_arprot		(m_axi_arprot[2:0]),	 // Templated
	   .s_axi_arqos			(m_axi_arqos[3:0]),	 // Templated
	   .s_axi_arsize		(m_axi_arsize[2:0]),	 // Templated
	   .s_axi_arvalid		(m_axi_arvalid),	 // Templated
	   .s_axi_awid			(m_axi_awid[S_IDW-1:0]), // Templated
	   .s_axi_awaddr		(m_axi_awaddr[31:0]),	 // Templated
	   .s_axi_awburst		(m_axi_awburst[1:0]),	 // Templated
	   .s_axi_awcache		(m_axi_awcache[3:0]),	 // Templated
	   .s_axi_awlock		(m_axi_awlock),		 // Templated
	   .s_axi_awlen			(m_axi_awlen[7:0]),	 // Templated
	   .s_axi_awprot		(m_axi_awprot[2:0]),	 // Templated
	   .s_axi_awqos			(m_axi_awqos[3:0]),	 // Templated
	   .s_axi_awsize		(m_axi_awsize[2:0]),	 // Templated
	   .s_axi_awvalid		(m_axi_awvalid),	 // Templated
	   .s_axi_bready		(m_axi_bready),		 // Templated
	   .s_axi_rready		(m_axi_rready),		 // Templated
	   .s_axi_wid			(m_axi_wid[S_IDW-1:0]),	 // Templated
	   .s_axi_wdata			(m_axi_wdata[31:0]),	 // Templated
	   .s_axi_wlast			(m_axi_wlast),		 // Templated
	   .s_axi_wvalid		(m_axi_wvalid));		 // Templated

   //######################################################################
   //TIE OFF UNUSED MASTER PORT ON ELINK0
   //######################################################################
   /*axislave_stub AUTO_TEMPLATE (
                          // Outputs
                          .s_\(.*\)   (elink0_m_\1[]),
                         );
    */

   defparam axislave_stub.S_IDW = S_IDW;
   axislave_stub  axislave_stub (.s_axi_aclk	(clk),
				 .s_axi_aresetn	(nreset),
				 /*AUTOINST*/
				 // Outputs
				 .s_axi_arready		(elink0_m_axi_arready), // Templated
				 .s_axi_awready		(elink0_m_axi_awready), // Templated
				 .s_axi_bid		(elink0_m_axi_bid[S_IDW-1:0]), // Templated
				 .s_axi_bresp		(elink0_m_axi_bresp[1:0]), // Templated
				 .s_axi_bvalid		(elink0_m_axi_bvalid), // Templated
				 .s_axi_rid		(elink0_m_axi_rid[S_IDW-1:0]), // Templated
				 .s_axi_rdata		(elink0_m_axi_rdata[31:0]), // Templated
				 .s_axi_rlast		(elink0_m_axi_rlast), // Templated
				 .s_axi_rresp		(elink0_m_axi_rresp[1:0]), // Templated
				 .s_axi_rvalid		(elink0_m_axi_rvalid), // Templated
				 .s_axi_wready		(elink0_m_axi_wready), // Templated
				 // Inputs
				 .s_axi_arid		(elink0_m_axi_arid[S_IDW-1:0]), // Templated
				 .s_axi_araddr		(elink0_m_axi_araddr[31:0]), // Templated
				 .s_axi_arburst		(elink0_m_axi_arburst[1:0]), // Templated
				 .s_axi_arcache		(elink0_m_axi_arcache[3:0]), // Templated
				 .s_axi_arlock		(elink0_m_axi_arlock), // Templated
				 .s_axi_arlen		(elink0_m_axi_arlen[7:0]), // Templated
				 .s_axi_arprot		(elink0_m_axi_arprot[2:0]), // Templated
				 .s_axi_arqos		(elink0_m_axi_arqos[3:0]), // Templated
				 .s_axi_arsize		(elink0_m_axi_arsize[2:0]), // Templated
				 .s_axi_arvalid		(elink0_m_axi_arvalid), // Templated
				 .s_axi_awid		(elink0_m_axi_awid[S_IDW-1:0]), // Templated
				 .s_axi_awaddr		(elink0_m_axi_awaddr[31:0]), // Templated
				 .s_axi_awburst		(elink0_m_axi_awburst[1:0]), // Templated
				 .s_axi_awcache		(elink0_m_axi_awcache[3:0]), // Templated
				 .s_axi_awlock		(elink0_m_axi_awlock), // Templated
				 .s_axi_awlen		(elink0_m_axi_awlen[7:0]), // Templated
				 .s_axi_awprot		(elink0_m_axi_awprot[2:0]), // Templated
				 .s_axi_awqos		(elink0_m_axi_awqos[3:0]), // Templated
				 .s_axi_awsize		(elink0_m_axi_awsize[2:0]), // Templated
				 .s_axi_awvalid		(elink0_m_axi_awvalid), // Templated
				 .s_axi_bready		(elink0_m_axi_bready), // Templated
				 .s_axi_rready		(elink0_m_axi_rready), // Templated
				 .s_axi_wid		(elink0_m_axi_wid[S_IDW-1:0]), // Templated
				 .s_axi_wdata		(elink0_m_axi_wdata[31:0]), // Templated
				 .s_axi_wlast		(elink0_m_axi_wlast), // Templated
				 .s_axi_wstrb		(elink0_m_axi_wstrb[3:0]), // Templated
				 .s_axi_wvalid		(elink0_m_axi_wvalid)); // Templated


   //######################################################################
   //AXI MASTER (DRIVES STIMULUS) to configure elink1
   //######################################################################
    /*emaxi AUTO_TEMPLATE (//Stimulus
               .m_axi_aresetn		(nreset),
               .m_axi_aclk		(clk),
               .m_\(.*\)           	(ext1_m_\1[]),
               .rr_wait			(1'b0),
               .wr_access		(ext1_write_in),
               .wr_packet		(packet_in[PW-1:0]),
               .rd_access		(ext1_read_in),
               .rd_packet		(packet_in[PW-1:0]),
     );
     */

   emaxi #(.M_IDW(M_IDW))
   emaxi1 (/*AUTOINST*/
	  // Outputs
	  .wr_wait			(wr_wait),
	  .rd_wait			(rd_wait),
	  .rr_access			(rr_access),
	  .rr_packet			(rr_packet[PW-1:0]),
	  .m_axi_awid			(ext1_m_axi_awid[M_IDW-1:0]), // Templated
	  .m_axi_awaddr			(ext1_m_axi_awaddr[31:0]), // Templated
	  .m_axi_awlen			(ext1_m_axi_awlen[7:0]), // Templated
	  .m_axi_awsize			(ext1_m_axi_awsize[2:0]), // Templated
	  .m_axi_awburst		(ext1_m_axi_awburst[1:0]), // Templated
	  .m_axi_awlock			(ext1_m_axi_awlock),	 // Templated
	  .m_axi_awcache		(ext1_m_axi_awcache[3:0]), // Templated
	  .m_axi_awprot			(ext1_m_axi_awprot[2:0]), // Templated
	  .m_axi_awqos			(ext1_m_axi_awqos[3:0]), // Templated
	  .m_axi_awvalid		(ext1_m_axi_awvalid),	 // Templated
	  .m_axi_wid			(ext1_m_axi_wid[M_IDW-1:0]), // Templated
	  .m_axi_wdata			(ext1_m_axi_wdata[63:0]), // Templated
	  .m_axi_wstrb			(ext1_m_axi_wstrb[7:0]), // Templated
	  .m_axi_wlast			(ext1_m_axi_wlast),	 // Templated
	  .m_axi_wvalid			(ext1_m_axi_wvalid),	 // Templated
	  .m_axi_bready			(ext1_m_axi_bready),	 // Templated
	  .m_axi_arid			(ext1_m_axi_arid[M_IDW-1:0]), // Templated
	  .m_axi_araddr			(ext1_m_axi_araddr[31:0]), // Templated
	  .m_axi_arlen			(ext1_m_axi_arlen[7:0]), // Templated
	  .m_axi_arsize			(ext1_m_axi_arsize[2:0]), // Templated
	  .m_axi_arburst		(ext1_m_axi_arburst[1:0]), // Templated
	  .m_axi_arlock			(ext1_m_axi_arlock),	 // Templated
	  .m_axi_arcache		(ext1_m_axi_arcache[3:0]), // Templated
	  .m_axi_arprot			(ext1_m_axi_arprot[2:0]), // Templated
	  .m_axi_arqos			(ext1_m_axi_arqos[3:0]), // Templated
	  .m_axi_arvalid		(ext1_m_axi_arvalid),	 // Templated
	  .m_axi_rready			(ext1_m_axi_rready),	 // Templated
	  // Inputs
	  .wr_access			(ext1_write_in),	 // Templated
	  .wr_packet			(packet_in[PW-1:0]),	 // Templated
	  .rd_access			(ext1_read_in),		 // Templated
	  .rd_packet			(packet_in[PW-1:0]),	 // Templated
	  .rr_wait			(1'b0),			 // Templated
	  .m_axi_aclk			(clk),			 // Templated
	  .m_axi_aresetn		(nreset),		 // Templated
	  .m_axi_awready		(ext1_m_axi_awready),	 // Templated
	  .m_axi_wready			(ext1_m_axi_wready),	 // Templated
	  .m_axi_bid			(ext1_m_axi_bid[M_IDW-1:0]), // Templated
	  .m_axi_bresp			(ext1_m_axi_bresp[1:0]), // Templated
	  .m_axi_bvalid			(ext1_m_axi_bvalid),	 // Templated
	  .m_axi_arready		(ext1_m_axi_arready),	 // Templated
	  .m_axi_rid			(ext1_m_axi_rid[M_IDW-1:0]), // Templated
	  .m_axi_rdata			(ext1_m_axi_rdata[63:0]), // Templated
	  .m_axi_rresp			(ext1_m_axi_rresp[1:0]), // Templated
	  .m_axi_rlast			(ext1_m_axi_rlast),	 // Templated
	  .m_axi_rvalid			(ext1_m_axi_rvalid));	 // Templated

   //######################################################################
   //2ND ELINK 
   //######################################################################
 
   /*axi_elink AUTO_TEMPLATE (.m_axi_aresetn      (nreset),
                              .s_axi_aresetn      (nreset),
                              .sys_nreset         (nreset),
                          .sys_clk            (clk),
                          .rxi_\(.*\)         (elink0_txo_\1[]),
                          .txi_\(.*\)         (elink0_rxo_\1[]),
                          .s_\(.*\)           (ext1_m_\1[]),
                          .m_\(.*\)           (mem_m_\1[]),
                          .\(.*\)             (@"(substring vl-cell-name  0 6)"_\1[]),
    );
    */

   defparam elink1.ID    = 12'h820;   
   defparam elink1.ETYPE = 0; 
   defparam elink1.S_IDW = S2_IDW;
   defparam elink1.M_IDW = M2_IDW;
   //defparam elink1.WAIT_WRRD = 0;
   axi_elink elink1 ( .s_axi_wstrb	((ext1_m_axi_wstrb[3:0] | ext1_m_axi_wstrb[7:4])),//NOTE:HACK!!
		     /*AUTOINST*/
		     // Outputs
		     .elink_active	(elink1_elink_active),	 // Templated
		     .rxo_wr_wait_p	(elink1_rxo_wr_wait_p),	 // Templated
		     .rxo_wr_wait_n	(elink1_rxo_wr_wait_n),	 // Templated
		     .rxo_rd_wait_p	(elink1_rxo_rd_wait_p),	 // Templated
		     .rxo_rd_wait_n	(elink1_rxo_rd_wait_n),	 // Templated
		     .txo_lclk_p	(elink1_txo_lclk_p),	 // Templated
		     .txo_lclk_n	(elink1_txo_lclk_n),	 // Templated
		     .txo_frame_p	(elink1_txo_frame_p),	 // Templated
		     .txo_frame_n	(elink1_txo_frame_n),	 // Templated
		     .txo_data_p	(elink1_txo_data_p[7:0]), // Templated
		     .txo_data_n	(elink1_txo_data_n[7:0]), // Templated
		     .chipid		(elink1_chipid[11:0]),	 // Templated
		     .chip_nreset	(elink1_chip_nreset),	 // Templated
		     .cclk_p		(elink1_cclk_p),	 // Templated
		     .cclk_n		(elink1_cclk_n),	 // Templated
		     .mailbox_irq	(elink1_mailbox_irq),	 // Templated
		     .m_axi_awid	(mem_m_axi_awid[M_IDW-1:0]), // Templated
		     .m_axi_awaddr	(mem_m_axi_awaddr[31:0]), // Templated
		     .m_axi_awlen	(mem_m_axi_awlen[7:0]),	 // Templated
		     .m_axi_awsize	(mem_m_axi_awsize[2:0]), // Templated
		     .m_axi_awburst	(mem_m_axi_awburst[1:0]), // Templated
		     .m_axi_awlock	(mem_m_axi_awlock),	 // Templated
		     .m_axi_awcache	(mem_m_axi_awcache[3:0]), // Templated
		     .m_axi_awprot	(mem_m_axi_awprot[2:0]), // Templated
		     .m_axi_awqos	(mem_m_axi_awqos[3:0]),	 // Templated
		     .m_axi_awvalid	(mem_m_axi_awvalid),	 // Templated
		     .m_axi_wid		(mem_m_axi_wid[M_IDW-1:0]), // Templated
		     .m_axi_wdata	(mem_m_axi_wdata[63:0]), // Templated
		     .m_axi_wstrb	(mem_m_axi_wstrb[7:0]),	 // Templated
		     .m_axi_wlast	(mem_m_axi_wlast),	 // Templated
		     .m_axi_wvalid	(mem_m_axi_wvalid),	 // Templated
		     .m_axi_bready	(mem_m_axi_bready),	 // Templated
		     .m_axi_arid	(mem_m_axi_arid[M_IDW-1:0]), // Templated
		     .m_axi_araddr	(mem_m_axi_araddr[31:0]), // Templated
		     .m_axi_arlen	(mem_m_axi_arlen[7:0]),	 // Templated
		     .m_axi_arsize	(mem_m_axi_arsize[2:0]), // Templated
		     .m_axi_arburst	(mem_m_axi_arburst[1:0]), // Templated
		     .m_axi_arlock	(mem_m_axi_arlock),	 // Templated
		     .m_axi_arcache	(mem_m_axi_arcache[3:0]), // Templated
		     .m_axi_arprot	(mem_m_axi_arprot[2:0]), // Templated
		     .m_axi_arqos	(mem_m_axi_arqos[3:0]),	 // Templated
		     .m_axi_arvalid	(mem_m_axi_arvalid),	 // Templated
		     .m_axi_rready	(mem_m_axi_rready),	 // Templated
		     .s_axi_arready	(ext1_m_axi_arready),	 // Templated
		     .s_axi_awready	(ext1_m_axi_awready),	 // Templated
		     .s_axi_bid		(ext1_m_axi_bid[S_IDW-1:0]), // Templated
		     .s_axi_bresp	(ext1_m_axi_bresp[1:0]), // Templated
		     .s_axi_bvalid	(ext1_m_axi_bvalid),	 // Templated
		     .s_axi_rid		(ext1_m_axi_rid[S_IDW-1:0]), // Templated
		     .s_axi_rdata	(ext1_m_axi_rdata[31:0]), // Templated
		     .s_axi_rlast	(ext1_m_axi_rlast),	 // Templated
		     .s_axi_rresp	(ext1_m_axi_rresp[1:0]), // Templated
		     .s_axi_rvalid	(ext1_m_axi_rvalid),	 // Templated
		     .s_axi_wready	(ext1_m_axi_wready),	 // Templated
		     // Inputs
		     .sys_nreset	(nreset),		 // Templated
		     .sys_clk		(clk),			 // Templated
		     .rxi_lclk_p	(elink0_txo_lclk_p),	 // Templated
		     .rxi_lclk_n	(elink0_txo_lclk_n),	 // Templated
		     .rxi_frame_p	(elink0_txo_frame_p),	 // Templated
		     .rxi_frame_n	(elink0_txo_frame_n),	 // Templated
		     .rxi_data_p	(elink0_txo_data_p[7:0]), // Templated
		     .rxi_data_n	(elink0_txo_data_n[7:0]), // Templated
		     .txi_wr_wait_p	(elink0_rxo_wr_wait_p),	 // Templated
		     .txi_wr_wait_n	(elink0_rxo_wr_wait_n),	 // Templated
		     .txi_rd_wait_p	(elink0_rxo_rd_wait_p),	 // Templated
		     .txi_rd_wait_n	(elink0_rxo_rd_wait_n),	 // Templated
		     .m_axi_aresetn	(nreset),		 // Templated
		     .m_axi_awready	(mem_m_axi_awready),	 // Templated
		     .m_axi_wready	(mem_m_axi_wready),	 // Templated
		     .m_axi_bid		(mem_m_axi_bid[M_IDW-1:0]), // Templated
		     .m_axi_bresp	(mem_m_axi_bresp[1:0]),	 // Templated
		     .m_axi_bvalid	(mem_m_axi_bvalid),	 // Templated
		     .m_axi_arready	(mem_m_axi_arready),	 // Templated
		     .m_axi_rid		(mem_m_axi_rid[M_IDW-1:0]), // Templated
		     .m_axi_rdata	(mem_m_axi_rdata[63:0]), // Templated
		     .m_axi_rresp	(mem_m_axi_rresp[1:0]),	 // Templated
		     .m_axi_rlast	(mem_m_axi_rlast),	 // Templated
		     .m_axi_rvalid	(mem_m_axi_rvalid),	 // Templated
		     .s_axi_aresetn	(nreset),		 // Templated
		     .s_axi_arid	(ext1_m_axi_arid[S_IDW-1:0]), // Templated
		     .s_axi_araddr	(ext1_m_axi_araddr[31:0]), // Templated
		     .s_axi_arburst	(ext1_m_axi_arburst[1:0]), // Templated
		     .s_axi_arcache	(ext1_m_axi_arcache[3:0]), // Templated
		     .s_axi_arlock	(ext1_m_axi_arlock),	 // Templated
		     .s_axi_arlen	(ext1_m_axi_arlen[7:0]), // Templated
		     .s_axi_arprot	(ext1_m_axi_arprot[2:0]), // Templated
		     .s_axi_arqos	(ext1_m_axi_arqos[3:0]), // Templated
		     .s_axi_arsize	(ext1_m_axi_arsize[2:0]), // Templated
		     .s_axi_arvalid	(ext1_m_axi_arvalid),	 // Templated
		     .s_axi_awid	(ext1_m_axi_awid[S_IDW-1:0]), // Templated
		     .s_axi_awaddr	(ext1_m_axi_awaddr[31:0]), // Templated
		     .s_axi_awburst	(ext1_m_axi_awburst[1:0]), // Templated
		     .s_axi_awcache	(ext1_m_axi_awcache[3:0]), // Templated
		     .s_axi_awlock	(ext1_m_axi_awlock),	 // Templated
		     .s_axi_awlen	(ext1_m_axi_awlen[7:0]), // Templated
		     .s_axi_awprot	(ext1_m_axi_awprot[2:0]), // Templated
		     .s_axi_awqos	(ext1_m_axi_awqos[3:0]), // Templated
		     .s_axi_awsize	(ext1_m_axi_awsize[2:0]), // Templated
		     .s_axi_awvalid	(ext1_m_axi_awvalid),	 // Templated
		     .s_axi_bready	(ext1_m_axi_bready),	 // Templated
		     .s_axi_rready	(ext1_m_axi_rready),	 // Templated
		     .s_axi_wid		(ext1_m_axi_wid[S_IDW-1:0]), // Templated
		     .s_axi_wdata	(ext1_m_axi_wdata[31:0]), // Templated
		     .s_axi_wlast	(ext1_m_axi_wlast),	 // Templated
		     .s_axi_wvalid	(ext1_m_axi_wvalid));	 // Templated

   //######################################################################
   //AXI SLAVE
   //######################################################################

   /*esaxi AUTO_TEMPLATE (//Stimulus
                         .s_\(.*\)     (mem_m_\1[]),
                         .\(.*\)       (mem_\1[]),
            );
     */

   esaxi #(.S_IDW(S_IDW), .RETURN_ADDR(RETURN_ADDR))
   esaxi (.s_axi_aclk	        (clk),
	  .s_axi_aresetn	(nreset),
	  .s_axi_wstrb	        (mem_m_axi_wstrb[7:4] | mem_m_axi_wstrb[3:0]),
	  /*AUTOINST*/
	  // Outputs
	  .wr_access			(mem_wr_access),	 // Templated
	  .wr_packet			(mem_wr_packet[PW-1:0]), // Templated
	  .rd_access			(mem_rd_access),	 // Templated
	  .rd_packet			(mem_rd_packet[PW-1:0]), // Templated
	  .rr_wait			(mem_rr_wait),		 // Templated
	  .s_axi_arready		(mem_m_axi_arready),	 // Templated
	  .s_axi_awready		(mem_m_axi_awready),	 // Templated
	  .s_axi_bid			(mem_m_axi_bid[S_IDW-1:0]), // Templated
	  .s_axi_bresp			(mem_m_axi_bresp[1:0]),	 // Templated
	  .s_axi_bvalid			(mem_m_axi_bvalid),	 // Templated
	  .s_axi_rid			(mem_m_axi_rid[S_IDW-1:0]), // Templated
	  .s_axi_rdata			(mem_m_axi_rdata[31:0]), // Templated
	  .s_axi_rlast			(mem_m_axi_rlast),	 // Templated
	  .s_axi_rresp			(mem_m_axi_rresp[1:0]),	 // Templated
	  .s_axi_rvalid			(mem_m_axi_rvalid),	 // Templated
	  .s_axi_wready			(mem_m_axi_wready),	 // Templated
	  // Inputs
	  .wr_wait			(mem_wr_wait),		 // Templated
	  .rd_wait			(mem_rd_wait),		 // Templated
	  .rr_access			(mem_rr_access),	 // Templated
	  .rr_packet			(mem_rr_packet[PW-1:0]), // Templated
	  .s_axi_arid			(mem_m_axi_arid[S_IDW-1:0]), // Templated
	  .s_axi_araddr			(mem_m_axi_araddr[31:0]), // Templated
	  .s_axi_arburst		(mem_m_axi_arburst[1:0]), // Templated
	  .s_axi_arcache		(mem_m_axi_arcache[3:0]), // Templated
	  .s_axi_arlock			(mem_m_axi_arlock),	 // Templated
	  .s_axi_arlen			(mem_m_axi_arlen[7:0]),	 // Templated
	  .s_axi_arprot			(mem_m_axi_arprot[2:0]), // Templated
	  .s_axi_arqos			(mem_m_axi_arqos[3:0]),	 // Templated
	  .s_axi_arsize			(mem_m_axi_arsize[2:0]), // Templated
	  .s_axi_arvalid		(mem_m_axi_arvalid),	 // Templated
	  .s_axi_awid			(mem_m_axi_awid[S_IDW-1:0]), // Templated
	  .s_axi_awaddr			(mem_m_axi_awaddr[31:0]), // Templated
	  .s_axi_awburst		(mem_m_axi_awburst[1:0]), // Templated
	  .s_axi_awcache		(mem_m_axi_awcache[3:0]), // Templated
	  .s_axi_awlock			(mem_m_axi_awlock),	 // Templated
	  .s_axi_awlen			(mem_m_axi_awlen[7:0]),	 // Templated
	  .s_axi_awprot			(mem_m_axi_awprot[2:0]), // Templated
	  .s_axi_awqos			(mem_m_axi_awqos[3:0]),	 // Templated
	  .s_axi_awsize			(mem_m_axi_awsize[2:0]), // Templated
	  .s_axi_awvalid		(mem_m_axi_awvalid),	 // Templated
	  .s_axi_bready			(mem_m_axi_bready),	 // Templated
	  .s_axi_rready			(mem_m_axi_rready),	 // Templated
	  .s_axi_wid			(mem_m_axi_wid[S_IDW-1:0]), // Templated
	  .s_axi_wdata			(mem_m_axi_wdata[31:0]), // Templated
	  .s_axi_wlast			(mem_m_axi_wlast),	 // Templated
	  .s_axi_wvalid			(mem_m_axi_wvalid));	 // Templated

   //######################################################################
   // MEMORY PORT
   //######################################################################
   
   //"Arbitration" between read/write transaction   
   assign mem_access           = mem_wr_access | mem_rd_access;
   
   assign mem_packet[PW-1:0]   = mem_wr_access ? mem_wr_packet[PW-1:0]:
                                                mem_rd_packet[PW-1:0];

   assign mem_rd_wait      = (mem_wait & mem_rd_access) |
			      mem_wr_access;

   assign mem_wr_wait      = (mem_wait & mem_wr_access);
   
   /*ememory AUTO_TEMPLATE ( 
                        // Outputsd
                        .\(.*\)_out       (mem_rr_\1[]),
                        .\(.*\)_in        (mem_\1[]),
                        .wait_out	  (mem_wait),
                        .wait_in	  (mem_rr_wait),  //pushback on reads
                             );
   */
   
   ememory #(.WAIT(0),
	     .MON(1))
   ememory (.clk	        (clk),
	    .coreid		(12'h0),
	    /*AUTOINST*/
	    // Outputs
	    .wait_out			(mem_wait),		 // Templated
	    .access_out			(mem_rr_access),	 // Templated
	    .packet_out			(mem_rr_packet[PW-1:0]), // Templated
	    // Inputs
	    .nreset			(nreset),
	    .access_in			(mem_access),		 // Templated
	    .packet_in			(mem_packet[PW-1:0]),	 // Templated
	    .wait_in			(mem_rr_wait));		 // Templated

endmodule // dv_elink
// Local Variables:
// verilog-library-directories:("." "../oh/elink/hdl" "../oh/emesh/dv" "../oh/axi/dv" "../oh/emesh/hdl" "../oh/memory/hdl" "../oh/axi/hdl")
// End:


