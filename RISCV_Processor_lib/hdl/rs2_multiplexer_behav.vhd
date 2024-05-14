--
-- VHDL Architecture RISCV_Processor_lib.rs2_multiplexer.behav
--
-- Created:
--          by - st161569.st161569 (pc029)
--          at - 13:00:51 05/14/24
--
-- using Mentor Graphics HDL Designer(TM) 2022.3 Built on 14 Jul 2022 at 13:56:12
--
ARCHITECTURE behav OF rs2_multiplexer IS
BEGIN
    process(all) is
        
    begin
        if imm_to_alu_ex = '1' then
            operand_b <= imm_ex;
        else
            operand_b <= rs2_ex;
        end if;
    end process;
END ARCHITECTURE behav;

