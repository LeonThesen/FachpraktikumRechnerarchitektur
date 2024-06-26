library ieee;
use ieee.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;

entity multiplier is
        generic(
            OP_WIDTH : integer := 32
        );
        port(
            multiply_mode : in multiply_mode_t;
            multiplicand : in std_logic_vector(OP_WIDTH - 1 downto 0); -- rs1
            multiplier : in std_logic_vector(OP_WIDTH - 1 downto 0);   -- rs2
            product : out std_logic_vector(OP_WIDTH - 1 downto 0)      -- rd
        );
end multiplier;
                             --rs1               --rs2
-- MUL    performs   signed OP_WIDTH *   signed OP_WIDTH and places lower OP_WIDTH bits in the result
-- MULH   performs   signed OP_WIDTH *   signed OP_WIDTH and places upper OP_WIDTH bits in the result
-- MULHU  performs unsigned OP_WIDTH * unsigned OP_WIDTH and places upper OP_WIDTH bits in the result
-- MULHSU performs   signed OP_WIDTH * unsigned OP_WIDTH and places upper OP_WIDTH bits in the result

architecture behav of multiplier is
begin
    multiply: process(multiply_mode, multiplicand, multiplier) is
        variable intermediate_product : std_logic_vector(OP_WIDTH * 2 - 1 downto 0);
    begin
        case multiply_mode is 
            when MUL | MULH | MULHSU => 
                intermediate_product := std_logic_vector(signed(multiplicand) * signed(multiplier));
            when MULHU  =>
                intermediate_product := std_logic_vector(unsigned(multiplicand) * unsigned(multiplier));
        end case;
        
        case multiply_mode is 
            when MUL    => 
                product <= intermediate_product(OP_WIDTH - 1 downto 0);
            when MULH | MULHU | MULHSU =>
                product <= intermediate_product(OP_WIDTH * 2 - 1 downto OP_WIDTH);
        end case;
    end process multiply;
end behav;
