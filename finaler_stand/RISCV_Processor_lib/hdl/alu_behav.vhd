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
use RISCV_Processor_lib.types.all;
use RISCV_Processor_lib.isa_defines.all;
library IEEE;
use IEEE.NUMERIC_STD.all;

ARCHITECTURE behav OF alu IS
    signal alu_result_int: word_t;
    signal add_sub_result_int: word_t;
    signal alu_flags_int: flag_t;
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
        alu_flags_int.carry <= intermediate_high(intermediate_high'left) = '1';
        alu_flags_int.overflow <= (intermediate_high(intermediate_high'left) xor intermediate_low(intermediate_low'left)) = '1';
        alu_flags_int.negative <= add_sub_result_int(add_sub_result_int'left) = '1';
        if add_sub_result_int = ZERO_WORD then
            alu_flags_int.zero <= true;
        else
            alu_flags_int.zero <= false;
        end if;
    end process add_sub;

    process(all) is
        variable intermediate_product : std_logic_vector(XLEN * 2 - 1 downto 0); 
    begin
        intermediate_product := (others => '0');

        case alu_mode_ex is            
            when ADD_MODE =>
                alu_result_int <= add_sub_result_int;
            when SUB_MODE =>
                alu_result_int <= add_sub_result_int;
            when SLT_MODE =>
                if alu_flags_int.negative xor alu_flags_int.overflow then
                    alu_result_int <= (0 => '1', others => '0');
                else 
                    alu_result_int <= (others => '0');
                end if;
            when SLTU_MODE=>
                if alu_flags_int.carry then
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
            when MUL_MODE =>
                intermediate_product := std_logic_vector(signed(operand_a) * signed(operand_b));
                alu_result_int <= intermediate_product(XLEN - 1 downto 0); 
            when MULH_MODE =>
                intermediate_product := std_logic_vector(signed(operand_a) * signed(operand_b));
                alu_result_int <= intermediate_product(XLEN * 2 - 1 downto XLEN);
            when MULHSU_MODE =>
                intermediate_product := std_logic_vector(signed(operand_a) * signed(operand_b));
                alu_result_int <= intermediate_product(XLEN * 2 - 1 downto XLEN);
            when MULHU_MODE =>
                intermediate_product := std_logic_vector(unsigned(operand_a) * unsigned(operand_b));
                alu_result_int <= intermediate_product(XLEN * 2 - 1 downto XLEN);            
            when others =>
                alu_result_int <= (others => '0');
        end case;
        
    end process;

    alu_result_ex <= alu_result_int;
END ARCHITECTURE behav;
