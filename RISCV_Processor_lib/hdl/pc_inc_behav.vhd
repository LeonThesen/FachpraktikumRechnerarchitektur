--
-- VHDL Architecture RISCV_Processor_lib.pc_inc.behav
--
-- Created:
--          by - st161569.st161569 (pc029)
--          at - 16:19:57 05/14/24
--
-- using Mentor Graphics HDL Designer(TM) 2022.3 Built on 14 Jul 2022 at 13:56:12
--
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

ARCHITECTURE behav OF pc_inc IS
BEGIN
    process(all) is 
    begin
        pc_pf <= std_logic_vector(unsigned(pc_if) + 4);
    end process;
END ARCHITECTURE behav;

