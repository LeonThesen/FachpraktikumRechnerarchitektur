--
-- VHDL Architecture RISCV_Processor_lib.bta_adder.behav
--
-- Created:
--          by - st161569.st161569 (pc043)
--          at - 17:25:59 05/29/24
--
-- using Mentor Graphics HDL Designer(TM) 2022.3 Built on 14 Jul 2022 at 13:56:12
--
library ieee;
use ieee.numeric_std.all;

ARCHITECTURE behav OF bta_adder IS
BEGIN
    bta <= std_logic_vector(unsigned(pc_dc) + unsigned(imm_dc));
END ARCHITECTURE behav;

