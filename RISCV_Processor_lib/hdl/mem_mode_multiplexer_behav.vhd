--
-- VHDL Architecture RISCV_Processor_lib.mem_mode_multiplexer.behav
--
-- Created:
--          by - st161569.st161569 (pc029)
--          at - 13:09:32 05/21/24
--
-- using Mentor Graphics HDL Designer(TM) 2022.3 Built on 14 Jul 2022 at 13:56:12
--
ARCHITECTURE behav OF mem_mode_mux IS
BEGIN
    process(all) is
    begin
        if mem_mode_mem.memory_access = LOAD then
            mem_result_mem <= data_memory_result;
        else
            mem_result_mem <= alu_result_mem;
        end if;
    end process;
END ARCHITECTURE behav;

