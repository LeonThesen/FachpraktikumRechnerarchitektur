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
        imm := (others => instruction_word(instruction_word'left));
        imm(I_FORMAT_IMMEDIATE_WORD_RANGE) := instruction_word(I_FORMAT_IMMEDIATE_RANGE);
        return imm;
    end function get_i_format_imm;

    pure function get_shift_amount(instruction_word: std_logic_vector) return word is
        variable imm: word;
    begin        
        imm := (others => instruction_word(instruction_word'left));
        imm(I_FORMAT_SHIFT_AMOUNT_WORD_RANGE) := instruction_word(I_FORMAT_SHIFT_AMOUNT_RANGE);
        return imm;
    end function get_shift_amount;
END isa_defines;
