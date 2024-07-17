--
-- VHDL Architecture RISCV_Processor_lib.store_data_fwd_mux.behav
--
-- Created:
--          by - st161569.st161569 (pc043)
--          at - 12:59:22 05/22/24
--
-- using Mentor Graphics HDL Designer(TM) 2022.3 Built on 14 Jul 2022 at 13:56:12
--
ARCHITECTURE behav OF store_data_fwd_mux IS
BEGIN
    store_data <= mem_result_wb when fwd_store_data_mem else rs2_mem;  
END ARCHITECTURE behav;

