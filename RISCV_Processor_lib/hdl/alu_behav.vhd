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
    signal alu_result_int: word_t;
    signal add_sub_result_int: word_t;
    signal negative_flag, zero_flag, overflow_flag, carry_flag: std_logic;
BEGIN

    add_sub: process(all) is 
        variable intermediate_low: word_t;
        variable intermediate_high: std_logic_vector(word_t'left + 1 downto word_t'left);
    begin
        case alu_mode_ex is
            when ADD_MODE => 
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
            when SUB_MODE =>
                alu_result_int <= add_sub_result_int;
            when ADD_MODE =>
                alu_result_int <= add_sub_result_int;
            when SLT_MODE =>
                if (negative_flag xor overflow_flag) = '1' then
                    alu_result_int <= (0 => '1', others => '0');
                else 
                    alu_result_int <= (others => '0');
                end if;
            when SLTU_MODE=>
                if carry_flag = '1' then
                    alu_result_int <= (0 => '1', others => '0');
                else 
                    alu_result_int <= (others => '0');
                end if; 
            when XOR_MODE =>
                alu_result_int <= operand_a xor operand_b;
            when OR_MODE =>
                alu_result_int <= operand_a or operand_b;
            when AND_MODE =>
                alu_result_int <= operand_a and operand_b;
            when SLL_MODE =>
                alu_result_int <= word_t(shift_left(unsigned(operand_a), to_integer(unsigned(operand_b))));
            when SRL_MODE => 
                alu_result_int <= word_t(shift_right(unsigned(operand_a), to_integer(unsigned(operand_b))));
            when SRA_MODE => 
                alu_result_int <= word_t(shift_right(signed(operand_a), to_integer(unsigned(operand_b))));
            when others =>
                alu_result_int <= (others => '0');
        end case;
    end process;

    alu_result_ex <= alu_result_int;
END ARCHITECTURE behav;
