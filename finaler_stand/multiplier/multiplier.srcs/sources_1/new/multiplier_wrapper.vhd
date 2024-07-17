library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.types.all;

entity multiplier_wrapper is
    port (
        correct : out std_logic
    );
end entity multiplier_wrapper;

architecture behav of multiplier_wrapper is
    signal multiplicand : std_logic_vector(31 downto 0);
    signal multiplier : std_logic_vector(31 downto 0);
    signal product : std_logic_vector(31 downto 0);
    type multiply_mode_t is (MUL, MULH, MULHU, MULHSU);
    signal multiply_mode : multiply_mode_t;
begin

    correct <= '1' when signed(product) = to_signed(100, multiplicand'length) else '0';
    
    multiply_mode <= MUL;
    multiplicand <= std_logic_vector(to_signed(-10, 32)); 
    multiplier <= std_logic_vector(to_signed(-10, 32));
    
    divider_i : entity work.multiplier
        port map (
            multiply_mode => multiply_mode,
            multiplicand => multiplicand,
            multiplier => multiplier,
            product => product
        );

end architecture behav;
