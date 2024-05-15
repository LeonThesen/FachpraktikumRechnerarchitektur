--
-- VHDL Architecture RISCV_Processor_lib.alu.behav
--
-- Created:
--          by - st161569.st161569 (pc043)
--          at - 15:05:26 05/08/24
--
-- using Mentor Graphics HDL Designer(TM) 2022.3 Built on 14 Jul 2022 at 13:56:12
--
library RISCV_Processor_lib;
use RISCV_Processor_lib.types.ALL;
library IEEE;
use IEEE.NUMERIC_STD.ALL;

ARCHITECTURE behav OF alu IS
    signal alu_result_int: word;
    signal add_sub_result_int: word;
    signal substract_result_int: word;
    signal negative_flag, zero_flag, overflow_flag, carry_flag: std_logic;
BEGIN

    add_sub: process(all) is 
        variable intermediate_low: word;
        variable intermediate_high: std_logic_vector(word'left + 1 downto word'left);
    begin
        case alu_mode_ex is
            when ADDI_MODE => 
                intermediate_low := std_logic_vector(unsigned('0' & operand_a(operand_a'left - 1 downto operand_a'right)) +  unsigned('0' & operand_b(operand_b'left - 1 downto operand_b'right)));
                intermediate_high := std_logic_vector(unsigned('0' & operand_a(operand_a'left downto operand_a'left)) + unsigned('0' & operand_b(operand_b'left downto operand_b'left)) + unsigned('0' & intermediate_low(intermediate_low'left downto intermediate_low'left)));
            when others =>
                intermediate_low := std_logic_vector(unsigned('0' & operand_a(operand_a'left - 1 downto operand_a'right)) -  unsigned('0' & operand_b(operand_b'left - 1 downto operand_b'right)));
                intermediate_high := std_logic_vector(unsigned('0' & operand_a(operand_a'left downto operand_a'left)) - unsigned('0' & operand_b(operand_b'left downto operand_b'left)) - unsigned('0' & intermediate_low(intermediate_low'left downto intermediate_low'left)));
        end case;
        add_sub_result_int <= intermediate_high(intermediate_high'right) & intermediate_low(intermediate_low'left - 1 downto intermediate_low'right);
        carry_flag <= intermediate_high(intermediate_high'left);
        overflow_flag <= intermediate_high(intermediate_high'left) xor intermediate_low(intermediate_low'left);
        negative_flag <= add_sub_result_int(add_sub_result_int'left);
        if add_sub_result_int = ZERO_WORD then
            zero_flag <= '1';
        else
            zero_flag <= '0';
        end if;
    end process add_sub;

    process(all) is 
    begin
        case alu_mode_ex is
            when ADDI_MODE =>
                alu_result_int <= add_sub_result_int;
            when SLTI_MODE =>
                -- SLTI (set less than immediate) places the value 1 in register rd if register rs1 is less than the sign-
                -- extended immediate when both are treated as signed numbers, else 0 is written to rd.
                if (negative_flag xor overflow_flag) = '1' then
                    alu_result_int <= (0 => '1', others => '0');
                else 
                    alu_result_int <= (others => '0');
                end if;
            when SLTIU_MODE =>
                -- SLTIU is similar but compares the values as unsigned numbers (i.e., the immediate is first sign-extended to
                -- XLEN bits then treated as an unsigned number). Note, SLTIU rd, rs1, 1 sets rd to 1 if rs1 equals
                -- zero, otherwise sets rd to 0 (assembler pseudo-op SEQZ rd, rs).
                if carry_flag = '1' then
                    alu_result_int <= (0 => '1', others => '0');
                else 
                    alu_result_int <= (others => '0');
                end if; 
            when XORI_MODE =>
                alu_result_int <= operand_a xor operand_b;
            when ORI_MODE =>
                alu_result_int <= operand_a or operand_b;
            when ANDI_MODE =>
                alu_result_int <= operand_a and operand_b;
            when SLLI_MODE =>
                alu_result_int <= word(shift_left(unsigned(operand_a), to_integer(unsigned(operand_b))));
            when SRLI_MODE => 
                alu_result_int <= word(shift_right(unsigned(operand_a), to_integer(unsigned(operand_b))));
            when SRAI_MODE => 
                alu_result_int <= word(shift_right(signed(operand_a), to_integer(unsigned(operand_b))));
            when others =>
                null;
        end case;
    end process;

    alu_result_ex <= alu_result_int;
END ARCHITECTURE behav;
