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
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
library RISCV_Processor_lib;
use RISCV_Processor_lib.types.ALL;

ARCHITECTURE behav OF rom IS

    constant ROM_SIZE : integer := 256;
    type rom_array is array (0 to ROM_SIZE - 1) of word;

    -- Define ROM contents
    constant ROM_CONTENTS : rom_array := (
        -- Address:  Data
        -- 0000 : 00000000
        "00000000000000000000000000000000",
        -- 0001 : 00000001
        "00000000000000000000000000000000",
        -- continue setting opcodes here
        others => ( others => '0' ) 
    );
BEGIN
    process(clk, res_n)
    begin
        if res_n = '0' then
            address <= (others => '0');
        else 
            if clk'event and clk = '1' then 
                -- Read data from ROM based on the address input
                instruction_word <= ROM_CONTENTS(to_integer(unsigned(address)));
            end if;
        end if;
    end process;
END ARCHITECTURE behav;
