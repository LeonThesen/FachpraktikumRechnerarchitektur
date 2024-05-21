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
		2 => X"b0",
		3 => X"00",
		4 => X"13",
		5 => X"01",
		6 => X"30",
		7 => X"00",
		8 => X"93",
		9 => X"01",
		10 => X"70",
		11 => X"00",
		12 => X"13",
		13 => X"00",
		14 => X"00",
		15 => X"00",
		16 => X"13",
		17 => X"00",
		18 => X"00",
		19 => X"00",
		20 => X"33",
		21 => X"82",
		22 => X"20",
		23 => X"00",
		24 => X"13",
		25 => X"00",
		26 => X"00",
		27 => X"00",
		28 => X"13",
		29 => X"00",
		30 => X"00",
		31 => X"00",
		32 => X"23",
		33 => X"20",
		34 => X"32",
		35 => X"00",
		36 => X"13",
		37 => X"00",
		38 => X"00",
		39 => X"00",
		40 => X"13",
		41 => X"00",
		42 => X"00",
		43 => X"00",
		44 => X"13",
		45 => X"00",
		46 => X"00",
		47 => X"00",
		48 => X"13",
		49 => X"00",
		50 => X"00",
		51 => X"00",
		52 => X"83",
		53 => X"22",
		54 => X"02",
		55 => X"00",
		56 => X"23",
		57 => X"00",
		58 => X"21",
		59 => X"00",
		60 => X"23",
		61 => X"90",
		62 => X"10",
		63 => X"00",
		64 => X"13",
		65 => X"00",
		66 => X"00",
		67 => X"00",
		68 => X"13",
		69 => X"00",
		70 => X"00",
		71 => X"00",
		72 => X"13",
		73 => X"00",
		74 => X"00",
		75 => X"00",
		76 => X"13",
		77 => X"00",
		78 => X"00",
		79 => X"00",
		80 => X"03",
		81 => X"04",
		82 => X"01",
		83 => X"00",
		84 => X"83",
		85 => X"94",
		86 => X"00",
		87 => X"00",
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
