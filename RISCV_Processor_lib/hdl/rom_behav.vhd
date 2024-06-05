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
		1 => X"1301d000",
		2 => X"93010000",
		3 => X"63d82100",
		4 => X"b3801000",
		5 => X"93811100",
		6 => X"6ff05fff",
		7 => X"6f000000",
		others => X"00000000");
BEGIN
	-- Read data from ROM based on the address input (--> pc_if)
	instruction_word_little_endian <= ROM_CONTENTS(to_integer(unsigned(pc_if(ROM_RANGE))));                

	instruction_word_rom <= instruction_word_little_endian(7 downto 0) & 
						   instruction_word_little_endian(15 downto 8) & 
						   instruction_word_little_endian(23 downto 16) & 
						   instruction_word_little_endian(31 downto 24);
END ARCHITECTURE behav;
