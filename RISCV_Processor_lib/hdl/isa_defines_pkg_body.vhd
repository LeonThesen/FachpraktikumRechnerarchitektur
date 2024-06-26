--
-- VHDL Package Body RISCV_Processor_lib.isa_defines
--
-- Created:
--          by - st161569.st161569 (pc043)
--          at - 16:23:23 05/15/24
--
-- using Mentor Graphics HDL Designer(TM) 2022.3 Built on 14 Jul 2022 at 13:56:12
--
library ieee;
use ieee.std_logic_1164.all;
library RISCV_Processor_lib;
use RISCV_Processor_lib.types.all;

PACKAGE BODY isa_defines IS
    pure function get_i_format_imm(instruction_word: word_t) return word_t is
        variable imm: word_t;
    begin
        imm := (others => instruction_word(31));
        imm(11 downto 0) := instruction_word(31 downto 20);
        return imm;
    end function get_i_format_imm;

    pure function get_s_format_imm(instruction_word: word_t) return word_t is
        variable imm: word_t;
    begin
        imm := (others => instruction_word(31));
        imm(11 downto 5) := instruction_word(31 downto 25);
        imm(4 downto  0) := instruction_word(11 downto 7);
        return imm;
    end function get_s_format_imm;

    pure function get_b_format_imm(instruction_word: word_t) return word_t is
        variable imm: word_t;
    begin
        imm := (others => instruction_word(31));
        imm(12) := instruction_word(31);
        imm(11) := instruction_word(7);
        imm(10 downto 5) := instruction_word(30 downto 25);
        imm(4 downto 1) := instruction_word(11 downto 8);
        imm(0) := '0';
        return imm;
    end function get_b_format_imm;

    pure function get_u_format_imm(instruction_word: word_t) return word_t is
        variable imm: word_t;
    begin
        imm := (others => '0');
        imm(31 downto 12) := instruction_word(31 downto 12);
        return imm;
    end function get_u_format_imm;

    pure function get_j_format_imm(instruction_word: word_t) return word_t is
        variable imm: word_t;
    begin
        imm := (others => instruction_word(31));
        imm(20) := instruction_word(31);
        imm(19 downto 12) := instruction_word(19 downto 12);
        imm(11) := instruction_word(20);
        imm(10 downto 1) := instruction_word(30 downto 21);
        imm(0) := '0';
        return imm;
    end function get_j_format_imm;

    pure function get_shift_amount(instruction_word: word_t) return word_t is
        variable shift_amount: word_t;
    begin
        shift_amount := (others => instruction_word(31));
        shift_amount(4 downto 0) := instruction_word(24 downto 20);
        return shift_amount;
    end function get_shift_amount;

    pure function determine_rs_fwd_signal(rs_addr : in register_file_t; rd_addr_ex : in register_file_t; rd_addr_mem : in register_file_t) return fwd_select_t is
        variable fwd_rs : fwd_select_t;
    begin
        if rs_addr /= X0_REG then
            if rs_addr = rd_addr_ex then
                fwd_rs := FROM_MEM; -- Read register matches write register of previous instruction
            elsif rs_addr = rd_addr_mem then
                fwd_rs := FROM_WB; -- Read register matches write register of pre-previous instruction
            else
                fwd_rs := NO_FORWARDING; -- No forwarding in this case
            end if;
        else
            fwd_rs := NO_FORWARDING;
        end if;
        return fwd_rs; 
    end function determine_rs_fwd_signal;
END isa_defines;

