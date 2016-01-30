#!/bin/sh

make clean

cd oh;git clean -d -f;git checkout -- parallella/fpga/headless/parallella.bit.bin;cd ..

git clean -d -f
git checkout -- 7010_hdmi/7010_hdmi.xpr
git checkout -- 7010_hdmi/7010_hdmi.srcs/sources_1/bd/elink2_top/elink2_top.bd
git checkout -- 7010_hdmi/7010_hdmi.srcs/sources_1/bd/elink2_top/hdl/elink2_top_wrapper.v
git checkout -- 7020_hdmi/7020_hdmi.xpr
git checkout -- 7020_hdmi/7020_hdmi.srcs/sources_1/bd/elink2_top/elink2_top.bd
git checkout -- 7020_hdmi/7020_hdmi.srcs/sources_1/bd/elink2_top/hdl/elink2_top_wrapper.v

