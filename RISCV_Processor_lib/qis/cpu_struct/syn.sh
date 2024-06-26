#!/bin/sh
cd "/u/home/clab/st161569/FachpraktikumRechnerarchitektur/RISCV_Processor_lib/qis/cpu_struct"
"/ext/eda/quartus/21_1_1/quartus/bin/quartus_sh" -t invoker.tcl
"/ext/eda/quartus/21_1_1/quartus/bin/quartus_map" cpu -f map.args "--family=cyclone v" --part=5cgxfc5c6f27c7
