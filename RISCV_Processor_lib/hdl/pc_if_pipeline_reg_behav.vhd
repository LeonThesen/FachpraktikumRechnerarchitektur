--
-- VHDL Architecture RISCV_Processor_lib.pc_if_pipeline_reg.behav
--
-- Created:
--          by - st161569.st161569 (pc029)
--          at - 16:11:24 05/14/24
--
-- using Mentor Graphics HDL Designer(TM) 2022.3 Built on 14 Jul 2022 at 13:56:12
--
library RISCV_Processor_lib;
use RISCV_Processor_lib.types.ALL;

ARCHITECTURE behav OF pf_if_pipeline_reg IS
BEGIN
    process(clk, res_n) is
    begin
        if res_n = '0' then
            pc_if <= (others => '0');
        else 
            if clk'event and clk = '1' then
                pc_if <= pc_pf;
            end if;
        end if;
    end process;
END ARCHITECTURE behav;