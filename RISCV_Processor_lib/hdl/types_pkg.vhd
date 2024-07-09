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
-- library RISCV_Processor_lib;
-- use RISCV_Processor_lib.isa_defines.all;

PACKAGE types IS
    constant BP_K : positive := 10;
    constant XLEN : positive := 32;
    constant ADDR_WIDTH : positive := 10;  
    constant NUM_BYTES : positive := 4;
    constant BYTE_WIDTH : positive := 8;

    subtype byte_t is std_logic_vector(7 downto 0);
    subtype half_word_t is std_logic_vector(15 downto 0);
    subtype word_t is std_logic_vector(31 downto 0);
    subtype double_word_t is std_logic_vector(63 downto 0);

    subtype bpb_state_t is std_logic_vector(1 downto 0);

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
        AND_MODE,
        MUL_MODE,
        MULH_MODE,
        MULHSU_MODE,
        MULHU_MODE,
        DIV_MODE,
        DIVU_MODE,
        REM_MODE,
        REMU_MODE
    );

    type btc_controls_t is record
        waddr : std_logic_vector(BP_K - 1 downto 0);
        wena_valid_bit : std_logic;
        wena_tag : std_logic;
        wena_target_addr : std_logic;
        wdata_valid_bit : std_logic_vector(0 downto 0);
        wdata_tag : std_logic_vector(XLEN - BP_K - 3 downto 0);
        wdata_target_addr : word_t;
    end record btc_controls_t;

    type bpb_controls_t is record
        waddr : std_logic_vector(BP_K - 1 downto 0);
        wena : std_logic;
        wdata : bpb_state_t;
    end record bpb_controls_t;

    type sbpu_mode_t is (
        NO_BRANCH,
        JAL
    );

    type dbpu_mode_t is (
        NO_BRANCH,
        JAL,
        JALR,
        EQUAL,
        NOT_EQUAL,
        LESS_THAN,
        GREATER_OR_EQUAL,
        LESS_THAN_UNSIGNED,
        GREATER_OR_EQUAL_UNSIGNED
    );

    subtype register_file_t is std_logic_vector(4 downto 0);
    constant X0_REG : register_file_t := (others => '0');
    
    type fwd_select_t is (FROM_WB, FROM_MEM, NO_FORWARDING);

    type flag_t is record
        negative: boolean;
        zero: boolean;
        overflow: boolean;
        carry: boolean;
    end record flag_t;

    type divider_mode_t is (DIV_MODE, REM_MODE);

    type divider_control_t is record
        is_signed : boolean;
        start : std_logic;
        mode : divider_mode_t;
    end record divider_control_t;
END types;

