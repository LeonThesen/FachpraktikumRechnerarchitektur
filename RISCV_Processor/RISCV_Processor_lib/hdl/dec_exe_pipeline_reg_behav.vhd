--
-- VHDL Architecture RISCV_Processor_lib.dec_exe_pipeline_reg.behav
--
-- Created:
--          by - st161569.st161569 (pc043)
--          at - 15:02:16 05/08/24
--
-- using Mentor Graphics HDL Designer(TM) 2022.3 Built on 14 Jul 2022 at 13:56:12
--
library RISCV_Processor_lib;
use RISCV_Processor_lib.types.ALL;

ARCHITECTURE behav OF dc_ex_pipeline_reg IS
BEGIN
    process(clk, res_n) is
    begin
        if res_n = '0' then
            operand_a <= (others => '0');
            operand_b <= (others => '0');
            alu_mode_ex <= NOP_MODE;
        else 
            if clk'event and clk = '1' then
                operand_a <= rs1;
                operand_b <= rs2;
                alu_mode_ex <= alu_mode_dc;
                rd_address_ex <= rd_address_dc;
            end if;
        end if;
    end process;
END ARCHITECTURE behav;

