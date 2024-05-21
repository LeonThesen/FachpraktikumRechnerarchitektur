--
-- VHDL Package Header RISCV_Processor_lib.types
--
-- Created:
--          by - st161569.st161569 (pc029)
--          at - 17:22:12 05/14/24
--
-- using Mentor Graphics HDL Designer(TM) 2022.3 Built on 14 Jul 2022 at 13:56:12
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
PACKAGE types IS
    subtype byte_t is std_logic_vector(7 downto 0);
    subtype half_word_t is std_logic_vector(15 downto 0);
    subtype word_t is std_logic_vector(31 downto 0);
    subtype double_word_t is std_logic_vector(63 downto 0);
    constant ZERO_WORD : word_t := (others => '0');

    type memory_access_t is (LOAD, STORE, IDLE);
    type data_width_t is (BYTE, HALFWORD, WORD);

    type mem_mode_t is record
        memory_access: memory_access_t;
        data_width: data_width_t;
        is_signed: boolean;
    end record mem_mode_t;

    type alu_mode_t is (
        ADD_MODE,
        SUB_MODE,
        SLL_MODE,
        SLT_MODE,
        SLTU_MODE,
        XOR_MODE,
        SRL_MODE,
        SRA_MODE,
        OR_MODE,
        AND_MODE
    );

    subtype register_file_t is std_logic_vector(4 downto 0);

    subtype forward_select_t is std_logic_vector(1 downto 0);
END types;

