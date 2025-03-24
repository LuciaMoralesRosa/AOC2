#!/bin/bash

rm -r WORK
if [ ! -d WORK ]; then 
    mkdir WORK
fi
rm Makefile

ghdl -i --ieee=synopsys -fexplicit --workdir=WORK *.vhd
ghdl --gen-makefile --ieee=synopsys -fexplicit --workdir=WORK testbench > Makefile
make

ghdl -r testbench --stop-time=500ns --wave=test2.ghw
gtkwave test2.ghw &
