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

    constant ROM_SIZE : integer := 2**10;
    type rom_array is array (0 to ROM_SIZE - 1) of byte_t;

    -- Define ROM contents
    constant ROM_CONTENTS : rom_array := (
		0 => X"93",
		1 => X"00",
		2 => X"50",
		3 => X"00",
		4 => X"23",
		5 => X"20",
		6 => X"10",
		7 => X"00",
		8 => X"13",
		9 => X"00",
		10 => X"00",
		11 => X"00",
		12 => X"13",
		13 => X"00",
		14 => X"00",
		15 => X"00",
		16 => X"13",
		17 => X"00",
		18 => X"00",
		19 => X"00",
		20 => X"03",
		21 => X"21",
		22 => X"00",
		23 => X"00",
		24 => X"93",
		25 => X"01",
		26 => X"21",
		27 => X"00",
		others => X"00");
BEGIN
    process(clk, res_n)
    variable instruction_word_little_endian: word_t;
    begin
        if res_n = '0' then
            instruction_word_if <= (others => '0');
        else 
            if clk'event and clk = '1' then 
                -- Read data from ROM based on the address input (--> pc_if)
                instruction_word_if <= ROM_CONTENTS(to_integer(unsigned(pc_if)) + 3) &
                                       ROM_CONTENTS(to_integer(unsigned(pc_if)) + 2) &
                                       ROM_CONTENTS(to_integer(unsigned(pc_if)) + 1) &
                                       ROM_CONTENTS(to_integer(unsigned(pc_if)) + 0);
            end if;
        end if;
    end process;
END ARCHITECTURE behav;
