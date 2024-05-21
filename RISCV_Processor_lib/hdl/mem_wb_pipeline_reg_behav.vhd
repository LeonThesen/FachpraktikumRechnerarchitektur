--
-- VHDL Architecture RISCV_Processor_lib.mem_wb_pipeline_reg.behav
--
-- Created:
--          by - st161569.st161569 (pc043)
--          at - 17:28:56 05/08/24
--
-- using Mentor Graphics HDL Designer(TM) 2022.3 Built on 14 Jul 2022 at 13:56:12
--
library RISCV_Processor_lib;
use RISCV_Processor_lib.types.ALL;

ARCHITECTURE behav OF mem_wb_pipeline_reg IS
BEGIN
    process(clk, res_n) is
    begin
        if res_n = '0' then
            mem_result_wb <= (others => '0');
            rd_addr_wb <= (others => '0');
            rf_wena_wb <= '0';
        else 
            if clk'event and clk = '1' then
                mem_result_wb <= mem_result_mem;
                rd_addr_wb <= rd_addr_mem;
                rf_wena_wb <= rf_wena_mem;
            end if;
        end if;
    end process;
END ARCHITECTURE behav;
