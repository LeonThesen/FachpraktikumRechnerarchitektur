--
-- VHDL Package Header RISCV_Processor_lib.riscv_types
--
-- Created:
--          by - st161569.st161569 (pc043)
--          at - 14:28:29 05/08/24
--
-- using Mentor Graphics HDL Designer(TM) 2022.3 Built on 14 Jul 2022 at 13:56:12
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
PACKAGE types IS
    subtype byte is std_logic_vector(7 downto 0);
    subtype half_word is std_logic_vector(15 downto 0);
    subtype word is std_logic_vector(31 downto 0);
    subtype double_word is std_logic_vector(63 downto 0);

    constant ZERO_WORD : word := (others => '0');

    type alu_mode_t is (NOP_MODE, ADD_MODE, ADDI_MODE, SUB_MODE, AND_MODE, ANDI_MODE, OR_MODE, ORI_MODE, XOR_MODE, XORI_MODE);
    subtype register_file_t is std_logic_vector(4 downto 0);

    constant SMALL_IMMEDIATE_SIZE : positive := 11;
    constant LARGE_IMMEDIATE_SIZE : positive := 20;
    subtype immediate_11_t is std_logic_vector(SMALL_IMMEDIATE_SIZE - 1 downto 0);
    subtype immediate_20_t is std_logic_vector(LARGE_IMMEDIATE_SIZE - 1 downto 0);
END types;
