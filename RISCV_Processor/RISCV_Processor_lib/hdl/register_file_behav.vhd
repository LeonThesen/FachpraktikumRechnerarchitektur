--
-- VHDL Architecture RISCV_Processor_lib.register_file.behav
--
-- Created:
--          by - st161569.st161569 (pc043)
--          at - 13:41:29 05/08/24
--
-- using Mentor Graphics HDL Designer(TM) 2022.3 Built on 14 Jul 2022 at 13:56:12
--
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
library RISCV_Processor_lib;
use RISCV_Processor_lib.types.ALL;

ARCHITECTURE behav OF register_file IS
    constant NUM_REGISTERS : positive := 32;
    type register_array is array (0 to NUM_REGISTERS - 1) of word;
    signal x : register_array;
BEGIN
    process(res_n) is
    begin 
        if res_n = '0' then
            x <= others => (others => '0');
        end if;
    end process;

    rs1 <= x(to_integer(unsigned(rs1_address)));
    rs2 <= x(to_integer(unsigned(rs2_address)));

END ARCHITECTURE behav;

