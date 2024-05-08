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

ARCHITECTURE behav OF alu IS
    variable carry_in: std_logic := '0'; -- Currently set to default value --> TODO: change this
    variable carry_word: word;
    variable intermediate_low, alu_result_ex: word;
    variable intermediate_high: std_logic_vector(word'left + 1 downto word'left);
    variable carry_flag, overflow_flag: std_logic;
    variable negative_flag, zero_flag, overflow_flag, carry_flag: std_logic;
    variable internal_result: word;
BEGIN
    process(all) is 
    begin
        carry_word := (0 => carry_in, others => '0');

        if alu_mode = ADDI_MODE then
            intermediate_low := std_logic_vector(unsigned('0' & operand_a(operand_a'left - 1 downto operand_a'right)) +  unsigned('0' & operand_b(operand_b'left - 1 downto operand_b'right)) + unsigned(carry_word));
            intermediate_high := std_logic_vector(unsigned('0' & operand_a(operand_a'left downto operand_a'left)) + unsigned('0' & operand_b(operand_b'left downto operand_b'left)) + unsigned('0' & intermediate_low(intermediate_low'left downto intermediate_low'left)));
        else
            intermediate_low := std_logic_vector(unsigned('0' & operand_a(operand_a'left - 1 downto operand_a'right)) - unsigned('0' & operand_b(operand_b'left - 1 downto operand_b'right)) - unsigned(carry_word));
            intermediate_high := std_logic_vector(unsigned('0' & operand_a(operand_a'left downto operand_a'left)) - unsigned('0' & operand_b(operand_b'left downto operand_b'left)) - unsigned('0' & intermediate_low(intermediate_low'left downto intermediate_low'left)));
        end if;

        -- Flags C, V
        carry_flag := intermediate_high(intermediate_high'left);
        overflow_flag := intermediate_high(intermediate_high'left) xor intermediate_low(intermediate_low'left);

        -- Result 
        internal_result := intermediate_high(intermediate_high'right) & intermediate_low(intermediate_low'left - 1 downto intermediate_low'right);

        -- Flags N, Z
        negative_flag := internal_result(internal_result'left);

        if internal_result = ZERO_WORD then
            zero_flag := '1';
        else
            zero_flag := '0';
        end if;

        alu_result_ex <= internal_result;
    end process;
END ARCHITECTURE behav;