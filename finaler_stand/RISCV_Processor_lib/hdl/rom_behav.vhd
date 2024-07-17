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
library RISCV_Processor_lib;
use RISCV_Processor_lib.types.ALL;
use RISCV_Processor_lib.isa_defines.ALL;

ARCHITECTURE behav OF rom IS
	constant ROM_WIDTH : integer := 10;
	subtype ROM_RANGE is natural range (ROM_WIDTH + 1) downto 2;
    constant ROM_WORD_COUNT : integer := 2**ROM_WIDTH;
    type rom_array_t is array (0 to ROM_WORD_COUNT - 1) of word_t;

	signal instruction_word_little_endian: word_t;

    -- Define ROM contents
    constant ROM_CONTENTS : rom_array_t := (
				0 => X"93001000",
		1 => X"13011000",
		2 => X"63842000",
		3 => X"6f008011",
		4 => X"130f1f00",
		5 => X"93002000",
		6 => X"13013000",
		7 => X"63942000",
		8 => X"6f004010",
		9 => X"130f1f00",
		10 => X"93002000",
		11 => X"13013000",
		12 => X"63c42000",
		13 => X"6f00000f",
		14 => X"130f1f00",
		15 => X"93003000",
		16 => X"13013000",
		17 => X"63d42000",
		18 => X"6f00c00d",
		19 => X"130f1f00",
		20 => X"93004000",
		21 => X"13013000",
		22 => X"63d42000",
		23 => X"6f00800c",
		24 => X"130f1f00",
		25 => X"93003000",
		26 => X"13014000",
		27 => X"63e42000",
		28 => X"6f00400b",
		29 => X"130f1f00",
		30 => X"93003000",
		31 => X"13013000",
		32 => X"63f42000",
		33 => X"6f00000a",
		34 => X"130f1f00",
		35 => X"93004000",
		36 => X"13013000",
		37 => X"63f42000",
		38 => X"6f00c008",
		39 => X"130f1f00",
		40 => X"93003000",
		41 => X"13013000",
		42 => X"63f42000",
		43 => X"6f008007",
		44 => X"130f1f00",
		45 => X"93003000",
		46 => X"13013000",
		47 => X"67008000",
		48 => X"6f004006",
		49 => X"130f1f00",
		50 => X"9300f0ff",
		51 => X"1301f0ff",
		52 => X"63842000",
		53 => X"6f000005",
		54 => X"130f1f00",
		55 => X"9300e0ff",
		56 => X"13013000",
		57 => X"63942000",
		58 => X"6f00c003",
		59 => X"130f1f00",
		60 => X"9300e0ff",
		61 => X"13013000",
		62 => X"63c42000",
		63 => X"6f008002",
		64 => X"130f1f00",
		65 => X"93003000",
		66 => X"1301d0ff",
		67 => X"63d42000",
		68 => X"6f004001",
		69 => X"130f1f00",
		70 => X"970e0000",
		71 => X"930f1000",
		72 => X"6f00c000",
		73 => X"930ff0ff",
		74 => X"6f004000",
		75 => X"6f000000",


		others => X"00000000");
BEGIN
	-- Read data from ROM based on the address input (--> pc_if)
	instruction_word_little_endian <= ROM_CONTENTS(to_integer(unsigned(pc_if(ROM_RANGE))));                

	instruction_word_rom <= instruction_word_little_endian(7 downto 0) & 
						   instruction_word_little_endian(15 downto 8) & 
						   instruction_word_little_endian(23 downto 16) & 
						   instruction_word_little_endian(31 downto 24);
END ARCHITECTURE behav;
