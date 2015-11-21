//Copyright 1986-2014 Xilinx, Inc. All Rights Reserved.
//--------------------------------------------------------------------------------
//Tool Version: Vivado v.2014.4.1 (lin64) Build 1149489 Thu Feb 19 16:01:47 MST 2015
//Date        : Fri Sep  4 18:33:50 2015
//Host        : HomeMegaUbuntu running 64-bit Ubuntu 15.04
//Command     : generate_target elink_testbench_wrapper.bd
//Design      : elink_testbench_wrapper
//Purpose     : IP block netlist
//--------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

module elink_testbench_wrapper
   (aclk,
    aresetn,
    csysreq,
    done0,
    done1,
    done2,
    error0,
    error1,
    error2,
    reset,
    rx_cclk_n,
    rx_cclk_p,
    start);
  input aclk;
  input aresetn;
  input csysreq;
  output done0;
  output done1;
  output done2;
  output error0;
  output error1;
  output error2;
  input reset;
  output rx_cclk_n;
  output rx_cclk_p;
  input start;

  wire aclk;
  wire aresetn;
  wire csysreq;
  wire done0;
  wire done1;
  wire done2;
  wire error0;
  wire error1;
  wire error2;
  wire reset;
  wire rx_cclk_n;
  wire rx_cclk_p;
  wire start;

elink_testbench elink_testbench_i
       (.aclk(aclk),
        .aresetn(aresetn),
        .csysreq(csysreq),
        .done0(done0),
        .done1(done1),
        .done2(done2),
        .error0(error0),
        .error1(error1),
        .error2(error2),
        .reset(reset),
        .rx_cclk_n(rx_cclk_n),
        .rx_cclk_p(rx_cclk_p),
        .start(start));
endmodule
