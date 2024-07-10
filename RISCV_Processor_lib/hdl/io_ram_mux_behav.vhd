--
-- VHDL Architecture RISCV_Processor_lib.io_ram_mux.behav
--
-- Created:
--          by - st161569.st161569 (pc043)
--          at - 16:01:34 07/10/24
--
-- using Mentor Graphics HDL Designer(TM) 2022.3 Built on 14 Jul 2022 at 13:56:12
--
ARCHITECTURE behav OF io_ram_mux IS
BEGIN
    process(all) is
    begin
        if is_io_access then
            data_memory_result <= io_rdata;
        else
            data_memory_result <= ram_result;
        end if;
    end process;
END ARCHITECTURE behav;

