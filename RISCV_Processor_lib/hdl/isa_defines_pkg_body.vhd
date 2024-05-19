--
-- VHDL Package Body RISCV_Processor_lib.isa_defines
--
-- Created:
--          by - st161569.st161569 (pc043)
--          at - 16:23:23 05/15/24
--
-- using Mentor Graphics HDL Designer(TM) 2022.3 Built on 14 Jul 2022 at 13:56:12
--
PACKAGE BODY isa_defines IS
    pure function get_i_format_imm(instruction_word: std_logic_vector) return word is
        variable imm: word;
    begin        
        imm := (11 downto 0 => instruction_word(31 downto 20),
                others => instruction_word(31));
        return imm;
    end function get_i_format_imm;

    pure function get_s_format_imm(instruction_word: std_logic_vector) return word is
        variable imm: word;
    begin
        imm := (11 downto 5 => instruction_word(31 downto 25),
                4 downto  0 => instruction_word(11 downto 7),
                others => insturction_word(31));
        return imm;
    end function get_s_format_imm;

    pure function get_b_format_imm(instruction_word: std_logic_vector) return word is
        variable imm: word;
    begin        
        imm := (12 => instruction_word(31),
                11 => instruction_word(7),
                10 downto 5 => instruction_word(30 downto 25),
                4 downto 1 => instruction_word(11 downto 8),
                0 => '0'
                others => instruction_word(31));
        return imm;
    end function get_b_format_imm;

    pure function get_u_format_imm(instruction_word: std_logic_vector) return word is
        variable imm: word;
    begin
        imm := (31 downto 12 => instruction_word(31 downto 12),
                11 downto 0 => '0'
                others => instruction_word(31));
        return imm;
    end function get_u_format_imm;

    pure function get_j_format_imm(instruction_word: std_logic_vector) return word is
        variable imm: word;
    begin        
        imm := (20 => instruction_word(31),
                19 downto 12 => instruction_word(19 downto 12),
                11 => insturction_word(20),
                10 downto 1 => instruction_word(30 downto 21),
                0 => '0',
                others => instruction_word(31));
        return imm;
    end function get_j_format_imm;

    pure function get_shift_amount(instruction_word: std_logic_vector) return word is
        variable shift_amount: word;
    begin        
    shift_amount := (4 downto 0 => instruction_word(24 downto 20),
                     others => instruction_word(31));
        return shift_amount;
    end function get_shift_amount;
END isa_defines;
