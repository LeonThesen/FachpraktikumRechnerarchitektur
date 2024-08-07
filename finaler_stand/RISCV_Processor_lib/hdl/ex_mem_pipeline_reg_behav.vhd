--
-- VHDL Architecture RISCV_Processor_lib.ex_mem_pipeline_reg.behav
--
-- Created:
--          by - st161569.st161569 (pc043)
--          at - 17:25:13 05/08/24
--
-- using Mentor Graphics HDL Designer(TM) 2022.3 Built on 14 Jul 2022 at 13:56:12
--
library RISCV_Processor_lib;
use RISCV_Processor_lib.types.ALL;

ARCHITECTURE behav OF ex_mem_pipeline_reg IS
BEGIN
    process(clk, res_n) is
    begin
        if res_n = '0' then
            ex_out_mem <= (others => '0');
            rd_addr_mem <= (others => '0');
            rs2_mem <= (others => '0');
            mem_mode_mem.memory_access <= IDLE;
            mem_mode_mem.data_width <= WORD;
            mem_mode_mem.is_signed <= false;
            fwd_store_data_mem <= false;
        else 
            if clk'event and clk = '1' then
                if not stall_rest_dc then
                    ex_out_mem <= ex_out_ex;
                    rd_addr_mem <= rd_addr_ex;
                    rs2_mem <= rs2_fwd_mux_out;
                    mem_mode_mem <= mem_mode_ex;
                    fwd_store_data_mem <= fwd_store_data_ex;
                end if;
            end if;
        end if;
    end process;
END ARCHITECTURE behav;