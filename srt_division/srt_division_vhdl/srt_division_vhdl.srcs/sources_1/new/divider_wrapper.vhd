library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity divider_wrapper is
    port (
        clk : in std_logic;
        res_n : in std_logic;
        start : in std_logic;
        done : out std_logic;
        correct : out std_logic
    );
end entity divider_wrapper;

architecture behav of divider_wrapper is
    signal divisor : std_logic_vector(31 downto 0) := (others => '0');
    signal dividend : std_logic_vector(31 downto 0) := (others => '0');
    signal quotient : std_logic_vector(31 downto 0);
    signal remainder : std_logic_vector(31 downto 0);
begin

    correct <= '1' when (signed(quotient) = to_signed(2, 32) and signed(remainder) = to_signed(940, 32)) else '0';

    dividend <= std_logic_vector(to_signed(18300, 32)); 
    divisor <= std_logic_vector(to_signed(8680, 32));

    div_inst : entity work.radix4_32
        port map (
            clk => clk,
            res_n => res_n,
            start => start,
            done => done,
            divisor => divisor,
            dividend => dividend,
            quotient => quotient,
            remainder => remainder
        );

end architecture behav;
