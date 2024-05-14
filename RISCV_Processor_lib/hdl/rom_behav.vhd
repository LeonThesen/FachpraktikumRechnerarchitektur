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
        -- Address:  Data
        -- 0000 : 00000000
        "00000000000100001000000010010011", -- add 1 to register 1
        NOP, -- nop
        NOP, -- nop
        "00000000000100001000000010010011", -- add 1 to register 1
        NOP, -- nop
        NOP, -- nop
        "00000000000100001000000010010011", -- add 1 to register 1
        NOP, -- nop
        NOP, -- nop
        "00000000000100001000000010010011", -- add 1 to register 1
        NOP, -- nop
        NOP, -- nop
        "00000000000100001000000010010011", -- add 1 to register 1
        NOP, -- nop
        NOP, -- nop
        "00000000000100001000000010010011", -- add 1 to register 1
        NOP, -- nop
        NOP, -- nop
        "00000000000100001000000010010011", -- add 1 to register 1
        NOP, -- nop
        NOP, -- nop
        "00000000000100001000000010010011", -- add 1 to register 1
        NOP, -- nop
        NOP, -- nop
        "00000000000100001000000010010011", -- add 1 to register 1
        NOP, -- nop
        NOP, -- nop
        "00000000000100001000000010010011", -- add 1 to register 1
        NOP, -- nop
        NOP, -- nop
        "00000000000100001000000010010011", -- add 1 to register 1
        NOP, -- nop
        NOP, -- nop
        "00000000000100001000000010010011", -- add 1 to register 1
        NOP, -- nop
        NOP, -- nop
        "00000000000100001000000010010011", -- add 1 to register 1
        NOP, -- nop
        NOP, -- nop
        "00000000000100001000000010010011", -- add 1 to register 1
        NOP, -- nop
        NOP, -- nop
        "00000000000100001000000010010011", -- add 1 to register 1
        NOP, -- nop
        NOP, -- nop
        "00000000000100001000000010010011", -- add 1 to register 1
        NOP, -- nop
        NOP, -- nop
        "00000000000100001000000010010011", -- add 1 to register 1
        NOP, -- nop
        NOP, -- nop
        "00000000000100001000000010010011", -- add 1 to register 1
        NOP, -- nop
        NOP, -- nop
        "00000000000100001000000010010011", -- add 1 to register 1
        NOP, -- nop
        NOP, -- nop
        "00000000000100001000000010010011", -- add 1 to register 1
        NOP, -- nop
        NOP, -- nop
        -- Continue setting instructions here
        others => ( NOP ) 
    );
BEGIN
    process(clk, res_n)
    begin
        if res_n = '0' then
            instruction_word_if <= (others => '0');
        else 
            if clk'event and clk = '1' then 
                -- Read data from ROM based on the address input (--> pc_if)
                instruction_word_if <= ROM_CONTENTS(to_integer(unsigned(pc_if)));
            end if;
        end if;
    end process;
END ARCHITECTURE behav;
