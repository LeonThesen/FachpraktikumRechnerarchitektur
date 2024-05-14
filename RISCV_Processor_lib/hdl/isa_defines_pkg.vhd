--
-- VHDL Package Header RISCV_Processor_lib.isa_defines
--
-- Created:
--          by - st161569.st161569 (pc043)
--          at - 14:36:25 05/08/24
--
-- using Mentor Graphics HDL Designer(TM) 2022.3 Built on 14 Jul 2022 at 13:56:12
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
PACKAGE isa_defines IS
    subtype opcode_t is std_logic_vector(6 downto 0);
    -- U-Format: Upper Immediate
    constant U_FORMAT_LUI   : opcode_t := "0110111";
    constant U_FORMAT_AUIPC : opcode_t := "0010111";
    -- J-Format: Jump
    constant J_FORMAT : opcode_t := "1101111";
    -- B-Format: Branch
    constant B_FORMAT : opcode_t := "1100011";
    -- R-Format: Register
    constant R_FORMAT : opcode_t := "0110011";
    -- I-Format: Immediate
    constant I_FORMAT_LOAD : opcode_t := "0000011";   
    constant I_FORMAT_ARITHMETIC : opcode_t := "0010011";   
    constant I_FORMAT_STORE : opcode_t := "1100111";     
    -- S-Format: Store
    constant S_FORMAT : opcode_t := "0100011";

    subtype op_t is std_logic_vector(2 downto 0);

    -- I-Format-Arithmetic
    constant ADDI : op_t := "000";
    
END isa_defines;
