--
-- VHDL Architecture RISCV_Processor_lib.io_mem.beahv
--
-- Created:
--          by - st161569.st161569 (pc043)
--          at - 16:18:17 07/10/24
--
-- using Mentor Graphics HDL Designer(TM) 2022.3 Built on 14 Jul 2022 at 13:56:12
--
ARCHITECTURE behav OF io_controller IS
BEGIN
    io_control_cpu <= io_control;
    io_out <= io_rdata;
    io_wdata_cpu <= io_wdata;
END ARCHITECTURE behav;

