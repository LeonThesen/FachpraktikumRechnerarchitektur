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
    type register_array_t is array (0 to NUM_REGISTERS - 1) of word_t;
    signal register_array : register_array_t;
BEGIN
    write_port_array: process(clk, res_n) is
    begin 
        if res_n = '0' then
            register_array <= (others => (others => '0'));
        else
            if clk'event and clk = '1' then 
                -- Overwrite register value with write back result;
                if rf_wena_wb = '1' then
                    register_array(to_integer(unsigned(rd_addr_wb))) <= mem_result_wb;
                end if;
            end if;
        end if;

        -- Protect register_array0 from being overwritten    
        register_array(0) <= (others => '0');
    end process write_port_array;

    read_port_1: process(register_array, rs1_addr, rd_addr_wb, rf_wena_wb, mem_result_wb) is
    begin
        if rf_wena_wb = '1' then
            if rs1_addr = rd_addr_wb then
                rs1_dc <= mem_result_wb;
            else
                rs1_dc <= register_array(to_integer(unsigned(rs1_addr)));
            end if;
        else 
            rs1_dc <= register_array(to_integer(unsigned(rs1_addr)));
        end if;
    end process read_port_1;

    read_port_2: process(register_array, rs2_addr, rd_addr_wb, rf_wena_wb, mem_result_wb) is
    begin
        if rf_wena_wb = '1' then
            if rs2_addr = rd_addr_wb then
                rs2_dc <= mem_result_wb;
            else
                rs2_dc <= register_array(to_integer(unsigned(rs2_addr)));
            end if;
        else 
            rs2_dc <= register_array(to_integer(unsigned(rs2_addr)));
        end if;
    end process read_port_2;

END ARCHITECTURE behav;

