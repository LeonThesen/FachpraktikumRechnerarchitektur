--
-- VHDL Architecture RISCV_Processor_lib.dbpu.behav
--
-- Created:
--          by - st161569.st161569 (pc043)
--          at - 17:26:57 05/29/24
--
-- using Mentor Graphics HDL Designer(TM) 2022.3 Built on 14 Jul 2022 at 13:56:12
--
library RISCV_Processor_lib;
use RISCV_Processor_lib.types.all;

ARCHITECTURE behav OF dbpu IS
BEGIN
process(all) is 
begin
    is_return_addr <= false;
    dbta <= (others => '0');
    dbta_valid_ex <= false;

    case dbpu_mode_ex is
        when NO_BRANCH =>
            null;
        when JAL =>
            is_return_addr <= true;
        when JALR =>
            is_return_addr <= true;
            dbta <= alu_result_ex;
            dbta_valid_ex <= true;
        when EQUAL =>
            if alu_flags.zero then
                dbta <= imm_or_bta_ex;
                dbta_valid_ex <= true;
            end if;
        when NOT_EQUAL =>
            if not alu_flags.zero then
                dbta <= imm_or_bta_ex;
                dbta_valid_ex <= true;
            end if;
        when LESS_THAN =>
            if alu_flags.negative xor alu_flags.overflow then
                dbta <= imm_or_bta_ex;
                dbta_valid_ex <= true;
            end if;
        when GREATER_OR_EQUAL =>
            if alu_flags.negative = alu_flags.overflow then
                dbta <= imm_or_bta_ex;
                dbta_valid_ex <= true;
            end if;
        when LESS_THAN_UNSIGNED =>
            if alu_flags.carry then
                dbta <= imm_or_bta_ex;
                dbta_valid_ex <= true;
            end if;
        when GREATER_OR_EQUAL_UNSIGNED =>
            if not alu_flags.carry then
                dbta <= imm_or_bta_ex;
                dbta_valid_ex <= true;
            end if;
    end case;
end process;
END ARCHITECTURE behav;
