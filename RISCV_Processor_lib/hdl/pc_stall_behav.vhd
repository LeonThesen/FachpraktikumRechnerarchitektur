--
-- VHDL Architecture RISCV_Processor_lib.pc_inc1.behav
--
-- Created:
--          by - st161569.st161569 (pc043)
--          at - 15:27:00 06/19/24
--
-- using Mentor Graphics HDL Designer(TM) 2022.3 Built on 14 Jul 2022 at 13:56:12
--
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

ARCHITECTURE behav OF pc_stall IS
BEGIN
    process(all) is 
    begin
        if res_n = '0' then
            pc_if <= (others => '0');
        elsif clk'event and clk = '1' then
            pc_if <= pc_pre_if;
        end if;
    end process;
END ARCHITECTURE behav;

