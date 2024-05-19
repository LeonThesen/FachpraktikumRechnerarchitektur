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
library RISCV_Processor_lib;
use RISCV_Processor_lib.types.ALL;

PACKAGE isa_defines IS
    subtype opcode_t is std_logic_vector(6 downto 0);
    subtype funct3_t is std_logic_vector(2 downto 0);
    subtype funct7_t is std_logic_vector(6 downto 0);

-- U-Format: Upper Immediate - does not need funct3_t field
    
    constant U_FORMAT_LUI   : opcode_t := "0110111";
    constant U_FORMAT_AUIPC : opcode_t := "0010111";

-- J-Format: Jump - does not need funct3_t field
    
    constant J_FORMAT : opcode_t := "1101111";

-- B-Format: Branch
    
    constant B_FORMAT : opcode_t := "1100011";
    constant BEQ_INSTR : funct3_t := "000";
    constant BNE_INSTR : funct3_t := "001";
    constant BLT_INSTR : funct3_t := "100";
    constant BGE_INSTR : funct3_t := "101";
    constant BLTU_INSTR : funct3_t := "110";
    constant BGEU_INSTR : funct3_t := "111";

-- R-Format: Register
    
    constant R_FORMAT : opcode_t := "0110011";

    -- ADD and SUB share the same opcode
    constant ADD_SUB_INSTR : funct3_t := "000"; 
    constant ADD_INSTR_FUNCT7 : funct7_t := "0000000";
    constant SUB_INSTR_FUNCT7 : funct7_t := "0100000";
    
    constant SLL_INSTR : funct3_t := "001";
    constant SLT_INSTR : funct3_t := "010";
    constant SLTU_INSTR : funct3_t := "011";
    constant XOR_INSTR : funct3_t := "100";

    -- SRL and SRA share the same opcode
    constant SR_INSTR : funct3_t := "101"; 
    constant SRL_INSTR_FUNCT7 : funct7_t := "0000000";
    constant SRA_INSTR_FUNCT7 : funct7_t := "0100000";

    constant OR_INSTR : funct3_t := "110";
    constant AND_INSTR : funct3_t := "111";

-- I-Format: Immediate

    -- I-Format-Load
    constant I_FORMAT_LOAD : opcode_t := "0000011";
    constant LB_INSTR : funct3_t := "000";
    constant LH_INSTR : funct3_t := "001";
    constant LW_INSTR : funct3_t := "010";
    constant LBU_INSTR : funct3_t := "100";
    constant LHU_INSTR : funct3_t := "101";

    -- I-Format-Arithmetic
    constant I_FORMAT_ARITHMETIC : opcode_t := "0010011"; 
    constant ADDI_INSTR : funct3_t := "000";
    constant SLTI_INSTR : funct3_t := "010";
    constant SLTIU_INSTR : funct3_t := "011";
    constant XORI_INSTR : funct3_t := "100";
    constant ORI_INSTR : funct3_t := "110";
    constant ANDI_INSTR : funct3_t := "111";
    constant SLLI_INSTR : funct3_t := "001";
    
    -- SRLI and SRAI share the same opcode
    constant SRI_INSTR : funct3_t := "101"; 
    constant SRLI_INSTR_FUNCT7 : funct7_t := "0000000";
    constant SRAI_INSTR_FUNCT7 : funct7_t := "0100000";
    
    -- I-Format-Jump
    constant I_FORMAT_JUMP : opcode_t := "1100111";
    constant JALR_INSTR : funct3_t := "000";

-- S-Format: Store
    
    constant S_FORMAT : opcode_t := "0100011";
    constant SB_INSTR : funct3_t := "000";
    constant SH_INSTR : funct3_t := "001";
    constant SW_INSTR : funct3_t := "010";

    -- Pseudo Instructions
    constant NOP_INSTR : word := "00000000000000000000000000010011";

    -- Range defines
    subtype OPCODE_RANGE is natural range 6 downto 0;
    subtype RS2_RANGE is natural range 24 downto 20;
    subtype RS1_RANGE is natural range 19 downto 15;
    subtype RD_RANGE is natural range 11 downto 7;
    subtype FUNCT3_RANGE is natural range 14 downto 12;

    -- R-Format-Ranges
    subtype R_FORMAT_FUNCT7_RANGE is natural range 31 downto 25;
    -- I-Format-Ranges
    subtype I_FORMAT_IMMEDIATE_WORD_RANGE is natural range 11 downto 0;
    subtype I_FORMAT_SHIFT_AMOUNT_WORD_RANGE is natural range 4 downto 0;
    subtype I_FORMAT_IMMEDIATE_RANGE is natural range 31 downto 20;
    subtype I_FORMAT_FUNCT7_RANGE is natural range 31 downto 25;
    subtype I_FORMAT_SHIFT_AMOUNT_RANGE is natural range 24 downto 20;
    -- S-Format-Ranges
    subtype S_FORMAT_UPPER_IMMEDIATE_RANGE is natural range 31 downto 25;
    subtype S_FORMAT_LOWER_IMMEDIATE_RANGE is natural range 11 downto 7;
    -- U-Format-Ranges
    subtype U_FORMAT_IMMEDIATE_RANGE is natural range 31 downto 12;
    subtype U_FORMAT_IMMEDIATE_WORD_RANGE is natural range 31 downto 12;

    pure function get_i_format_imm(instruction_word: std_logic_vector) return word;
    pure function get_u_format_imm(instruction_word: std_logic_vector) return word;
    pure function get_shift_amount(instruction_word: std_logic_vector) return word;
END isa_defines;
