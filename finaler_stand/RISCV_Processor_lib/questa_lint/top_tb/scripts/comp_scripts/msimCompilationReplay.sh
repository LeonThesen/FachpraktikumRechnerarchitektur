SCRIPTDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
vcom -work "RISCV_Processor_lib" -nologo -2008 -f $SCRIPTDIR/Files0
vcom -work "RISCV_Processor_lib" -nologo -93 -f $SCRIPTDIR/Files1
vcom -work "RISCV_Processor_lib" -nologo -2008 -f $SCRIPTDIR/Files2
vcom -work "RISCV_Processor_lib" -nologo -93 -f $SCRIPTDIR/Files3
vcom -work "RISCV_Processor_lib" -nologo -2008 -f $SCRIPTDIR/Files4
