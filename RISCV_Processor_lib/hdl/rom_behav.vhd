--
-- VHDL Architecture RISCV_Processor_lib.rom.behav
--
-- Created:
--          by - st161569.st161569 (pc043)
--          at - 13:32:30 05/08/24
--
-- using Mentor Graphics HDL Designer(TM) 2022.3 Built on 14 Jul 2022 at 13:56:12
--

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
library RISCV_Processor_lib;
use RISCV_Processor_lib.types.ALL;
use RISCV_Processor_lib.isa_defines.ALL;

ARCHITECTURE behav OF rom IS

    constant ROM_SIZE : integer := 256;
    type rom_array is array (0 to ROM_SIZE - 1) of word;

    -- Define ROM contents
    constant ROM_CONTENTS : rom_array := (
        0 => X"93001000",
		1 => X"13011000",
		2 => X"13000000",
		3 => X"13000000",
		4 => X"93e11000",
		5 => X"13c20000",
		6 => X"93f21000",
		7 => X"13a32000",
		8 => X"93b32000",
		9 => X"13944000",
		10 => X"13000000",
		11 => X"13000000",
		12 => X"93542400",
		13 => X"13551440",
		others => X"13000000");
BEGIN
    process(clk, res_n)
    variable instruction_word_little_endian: word;
    begin
        if res_n = '0' then
            instruction_word_if <= (others => '0');
        else 
            if clk'event and clk = '1' then 
                -- Read data from ROM based on the address input (--> pc_if)
                instruction_word_little_endian := ROM_CONTENTS(to_integer(unsigned(pc_if)));
                instruction_word_if <= instruction_word_little_endian(7 downto 0) & instruction_word_little_endian(15 downto 8) & instruction_word_little_endian(23 downto 16) & instruction_word_little_endian(31 downto 24);
            end if;
        end if;
    end process;
END ARCHITECTURE behav;
