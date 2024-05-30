--
-- VHDL Architecture RISCV_Processor_lib.pc_ex_inc.behav
--
-- Created:
--          by - st161569.st161569 (pc043)
--          at - 17:26:42 05/29/24
--
-- using Mentor Graphics HDL Designer(TM) 2022.3 Built on 14 Jul 2022 at 13:56:12
--
ARCHITECTURE behav OF pc_ex_inc IS
BEGIN
    process(all) is 
    begin
        pc_ex <= std_logic_vector(unsigned(pc_dc) + 4);
    end process;
END ARCHITECTURE behav;

