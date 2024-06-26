--
-- VHDL Architecture RISCV_Processor_lib.pc_mux.behav
--
-- Created:
--          by - st161569.st161569 (pc043)
--          at - 15:47:24 05/29/24
--
-- using Mentor Graphics HDL Designer(TM) 2022.3 Built on 14 Jul 2022 at 13:56:12
--
library RISCV_Processor_lib;
use RISCV_Processor_lib.types.ALL;

ARCHITECTURE behav OF pc_mux IS
BEGIN
    process(wrong_jump_prediction, dbta_valid_ex, sbta_valid_dc, jump_predicted_dc, dbta, return_addr, imm_or_bta_dc, pc_pf) is
    begin
        if wrong_jump_prediction then
            if dbta_valid_ex then
                pc <= dbta;
            else
                pc <= return_addr;
            end if;
        else
            if sbta_valid_dc or jump_predicted_dc then
                pc <= imm_or_bta_dc;
            else
                pc <= pc_pf;
            end if;
        end if;
    end process;
END ARCHITECTURE behav;

