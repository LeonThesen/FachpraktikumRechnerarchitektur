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
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.NUMERIC_STD.ALL;
library RISCV_Processor_lib;
use RISCV_Processor_lib.types.ALL;

ARCHITECTURE behav OF register_file IS
    constant NUM_REGISTERS : positive := 32;
    type register_array is array (0 to NUM_REGISTERS - 1) of word;
    signal x : register_array;
BEGIN
    reset: process(all) is
    begin 
        if res_n = '0' then
            x <= (others => (others => '0'));
            rs1_dc <= (others => '0');
            rs2_dc <= (others => '0');
        else      
            rs1_dc <= x(to_integer(unsigned(rs1_addr)));
            rs2_dc <= x(to_integer(unsigned(rs2_addr)));

            -- Set x0 register to zero by default
            x(0) <= (others => '0');

            -- Protect x0 from being overwritten
            if(unsigned(rd_addr_wb) /= 0) then 
                -- Overwrite register value with write back result
                x(to_integer(unsigned(rd_addr_wb))) <= mem_result_wb;
            end if;
        end if;
    end process reset;

END ARCHITECTURE behav;

