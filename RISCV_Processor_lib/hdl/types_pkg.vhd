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
    subtype byte is std_logic_vector(7 downto 0);
    subtype half_word is std_logic_vector(15 downto 0);
    subtype word is std_logic_vector(31 downto 0);
    subtype double_word is std_logic_vector(63 downto 0);

    constant ZERO_WORD : word := (others => '0');

    type alu_mode_t is (
        LUI_MODE,
        AUIPC_MODE,
        JAL_MODE,
        BEQ_MODE,
        BNE_MODE,
        BLT_MODE,
        BGE_MODE,
        BLTU_MODE,
        BGEU_MODE,
        ADD_MODE,
        SUB_MODE,
        SLL_MODE,
        SLT_MODE,
        SLTU_MODE,
        XOR_MODE,
        SRL_MODE,
        SRA_MODE,
        OR_MODE,
        AND_MODE,
        LB_MODE,
        LH_MODE,
        LW_MODE,
        LBU_MODE,
        LHU_MODE,
        ADDI_MODE,
        SLTI_MODE,
        SLTIU_MODE,
        XORI_MODE,
        ORI_MODE,
        ANDI_MODE,
        SLLI_MODE,
        SRLI_MODE,
        SRAI_MODE,
        JALR_MODE,
        SB_MODE,
        SH_MODE,
        SW_MODE
    );

    subtype register_file_t is std_logic_vector(4 downto 0);

    constant SMALL_IMMEDIATE_SIZE : positive := 12;
    constant LARGE_IMMEDIATE_SIZE : positive := 20;
    subtype immediate_12_t is std_logic_vector(SMALL_IMMEDIATE_SIZE - 1 downto 0); -- TODO: shorten name
    subtype immediate_20_t is std_logic_vector(LARGE_IMMEDIATE_SIZE - 1 downto 0); -- TODO: shorten name

    constant EXTEND_IMM12_TO_32_BIT: std_logic_vector(31 downto 12) := (others => '0');
END types;

