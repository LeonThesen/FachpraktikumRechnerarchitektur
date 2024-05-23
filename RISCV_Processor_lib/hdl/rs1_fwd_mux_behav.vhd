--
-- VHDL Architecture RISCV_Processor_lib.rs1_fwd_mux.behav
--
-- Created:
--          by - st161569.st161569 (pc043)
--          at - 12:51:01 05/22/24
--
-- using Mentor Graphics HDL Designer(TM) 2022.3 Built on 14 Jul 2022 at 13:56:12
--
ARCHITECTURE behav OF rs1_fwd_mux IS
BEGIN
    process(all) is
    begin 
        case fwd_rs1_ex is 
            when FROM_EX => 
                operand_a <= rs1_ex;
            when FROM_MEM => 
                operand_a <= alu_result_mem;
            when FROM_WB =>
                operand_a <= mem_result_wb;
        end case;
    end process;
END ARCHITECTURE behav;

