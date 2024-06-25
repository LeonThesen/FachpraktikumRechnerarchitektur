library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity divider_wrapper is
    port (
        clk : in std_logic;
        rst : in std_logic;
        start : in std_logic;
        done : out std_logic;
        correct : out std_logic
    );
end entity divider_wrapper;

architecture rtl of divider_wrapper is
    signal divisor : std_logic_vector(31 downto 0) := (others => '0');
    signal dividend : std_logic_vector(31 downto 0) := (others => '0');
    signal quotient : std_logic_vector(31 downto 0);
    signal remainder : std_logic_vector(31 downto 0);
begin

    correct <= '1' when (signed(quotient) = to_signed(3, 32) and signed(remainder) = to_signed(1, 32)) else '0';

    divisor <= std_logic_vector(to_signed(10, 32));
    dividend <= std_logic_vector(to_signed(3, 32));

    div_inst : entity work.radix4_32
        port map (
            clk => clk,
            rst => rst,
            start => start,
            done => done,
            divisor => divisor,
            dividend => dividend,
            quotient => quotient,
            remainder => remainder
        );

end architecture rtl;
