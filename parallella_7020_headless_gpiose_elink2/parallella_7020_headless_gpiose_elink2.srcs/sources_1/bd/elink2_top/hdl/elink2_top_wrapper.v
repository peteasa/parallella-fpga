//Copyright 1986-2014 Xilinx, Inc. All Rights Reserved.
//--------------------------------------------------------------------------------
//Tool Version: Vivado v.2014.3 (lin64) Build 1034051 Fri Oct  3 16:31:15 MDT 2014
//Date        : Mon Jan 26 14:01:04 2015
//Host        : FredsLaptop running 64-bit Ubuntu 14.04.1 LTS
//Command     : generate_target elink2_top_wrapper.bd
//Design      : elink2_top_wrapper
//Purpose     : IP block netlist
//--------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

module elink2_top_wrapper
   (CCLK_N,
    CCLK_P,
    DDR_addr,
    DDR_ba,
    DDR_cas_n,
    DDR_ck_n,
    DDR_ck_p,
    DDR_cke,
    DDR_cs_n,
    DDR_dm,
    DDR_dq,
    DDR_dqs_n,
    DDR_dqs_p,
    DDR_odt,
    DDR_ras_n,
    DDR_reset_n,
    DDR_we_n,
    DSP_RESET_N,
    FIXED_IO_ddr_vrn,
    FIXED_IO_ddr_vrp,
    FIXED_IO_mio,
    FIXED_IO_ps_clk,
    FIXED_IO_ps_porb,
    FIXED_IO_ps_srstb,
    GPIO_N,
    GPIO_P,
    I2C_SCL,
    I2C_SDA,
    RX_data_n,
    RX_data_p,
    RX_frame_n,
    RX_frame_p,
    RX_lclk_n,
    RX_lclk_p,
    RX_rd_wait_n,
    RX_rd_wait_p,
    RX_wr_wait_n,
    RX_wr_wait_p,
    TX_data_n,
    TX_data_p,
    TX_frame_n,
    TX_frame_p,
    TX_lclk_n,
    TX_lclk_p,
    TX_rd_wait_n,
    TX_rd_wait_p,
    TX_wr_wait_n,
    TX_wr_wait_p);
  output CCLK_N;
  output CCLK_P;
  inout [14:0]DDR_addr;
  inout [2:0]DDR_ba;
  inout DDR_cas_n;
  inout DDR_ck_n;
  inout DDR_ck_p;
  inout DDR_cke;
  inout DDR_cs_n;
  inout [3:0]DDR_dm;
  inout [31:0]DDR_dq;
  inout [3:0]DDR_dqs_n;
  inout [3:0]DDR_dqs_p;
  inout DDR_odt;
  inout DDR_ras_n;
  inout DDR_reset_n;
  inout DDR_we_n;
  output [0:0]DSP_RESET_N;
  inout FIXED_IO_ddr_vrn;
  inout FIXED_IO_ddr_vrp;
  inout [53:0]FIXED_IO_mio;
  inout FIXED_IO_ps_clk;
  inout FIXED_IO_ps_porb;
  inout FIXED_IO_ps_srstb;
  inout [23:0]GPIO_N;
  inout [23:0]GPIO_P;
  inout I2C_SCL;
  inout I2C_SDA;
  input [7:0]RX_data_n;
  input [7:0]RX_data_p;
  input RX_frame_n;
  input RX_frame_p;
  input RX_lclk_n;
  input RX_lclk_p;
  output RX_rd_wait_n;
  output RX_rd_wait_p;
  output RX_wr_wait_n;
  output RX_wr_wait_p;
  output [7:0]TX_data_n;
  output [7:0]TX_data_p;
  output TX_frame_n;
  output TX_frame_p;
  output TX_lclk_n;
  output TX_lclk_p;
  input TX_rd_wait_n;
  input TX_rd_wait_p;
  input TX_wr_wait_n;
  input TX_wr_wait_p;

  wire CCLK_N;
  wire CCLK_P;
  wire [14:0]DDR_addr;
  wire [2:0]DDR_ba;
  wire DDR_cas_n;
  wire DDR_ck_n;
  wire DDR_ck_p;
  wire DDR_cke;
  wire DDR_cs_n;
  wire [3:0]DDR_dm;
  wire [31:0]DDR_dq;
  wire [3:0]DDR_dqs_n;
  wire [3:0]DDR_dqs_p;
  wire DDR_odt;
  wire DDR_ras_n;
  wire DDR_reset_n;
  wire DDR_we_n;
  wire [0:0]DSP_RESET_N;
  wire FIXED_IO_ddr_vrn;
  wire FIXED_IO_ddr_vrp;
  wire [53:0]FIXED_IO_mio;
  wire FIXED_IO_ps_clk;
  wire FIXED_IO_ps_porb;
  wire FIXED_IO_ps_srstb;
  wire [23:0]GPIO_N;
  wire [23:0]GPIO_P;
  wire I2C_SCL;
  wire I2C_SDA;
  wire [7:0]RX_data_n;
  wire [7:0]RX_data_p;
  wire RX_frame_n;
  wire RX_frame_p;
  wire RX_lclk_n;
  wire RX_lclk_p;
  wire RX_rd_wait_n;
  wire RX_rd_wait_p;
  wire RX_wr_wait_n;
  wire RX_wr_wait_p;
  wire [7:0]TX_data_n;
  wire [7:0]TX_data_p;
  wire TX_frame_n;
  wire TX_frame_p;
  wire TX_lclk_n;
  wire TX_lclk_p;
  wire TX_rd_wait_n;
  wire TX_rd_wait_p;
  wire TX_wr_wait_n;
  wire TX_wr_wait_p;

elink2_top elink2_top_i
       (.CCLK_N(CCLK_N),
        .CCLK_P(CCLK_P),
        .DDR_addr(DDR_addr),
        .DDR_ba(DDR_ba),
        .DDR_cas_n(DDR_cas_n),
        .DDR_ck_n(DDR_ck_n),
        .DDR_ck_p(DDR_ck_p),
        .DDR_cke(DDR_cke),
        .DDR_cs_n(DDR_cs_n),
        .DDR_dm(DDR_dm),
        .DDR_dq(DDR_dq),
        .DDR_dqs_n(DDR_dqs_n),
        .DDR_dqs_p(DDR_dqs_p),
        .DDR_odt(DDR_odt),
        .DDR_ras_n(DDR_ras_n),
        .DDR_reset_n(DDR_reset_n),
        .DDR_we_n(DDR_we_n),
        .DSP_RESET_N(DSP_RESET_N),
        .FIXED_IO_ddr_vrn(FIXED_IO_ddr_vrn),
        .FIXED_IO_ddr_vrp(FIXED_IO_ddr_vrp),
        .FIXED_IO_mio(FIXED_IO_mio),
        .FIXED_IO_ps_clk(FIXED_IO_ps_clk),
        .FIXED_IO_ps_porb(FIXED_IO_ps_porb),
        .FIXED_IO_ps_srstb(FIXED_IO_ps_srstb),
        .GPIO_N(GPIO_N),
        .GPIO_P(GPIO_P),
        .I2C_SCL(I2C_SCL),
        .I2C_SDA(I2C_SDA),
        .RX_data_n(RX_data_n),
        .RX_data_p(RX_data_p),
        .RX_frame_n(RX_frame_n),
        .RX_frame_p(RX_frame_p),
        .RX_lclk_n(RX_lclk_n),
        .RX_lclk_p(RX_lclk_p),
        .RX_rd_wait_n(RX_rd_wait_n),
        .RX_rd_wait_p(RX_rd_wait_p),
        .RX_wr_wait_n(RX_wr_wait_n),
        .RX_wr_wait_p(RX_wr_wait_p),
        .TX_data_n(TX_data_n),
        .TX_data_p(TX_data_p),
        .TX_frame_n(TX_frame_n),
        .TX_frame_p(TX_frame_p),
        .TX_lclk_n(TX_lclk_n),
        .TX_lclk_p(TX_lclk_p),
        .TX_rd_wait_n(TX_rd_wait_n),
        .TX_rd_wait_p(TX_rd_wait_p),
        .TX_wr_wait_n(TX_wr_wait_n),
        .TX_wr_wait_p(TX_wr_wait_p));
endmodule
