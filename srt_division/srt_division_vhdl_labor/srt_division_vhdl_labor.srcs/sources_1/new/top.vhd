----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 07/13/2024 02:01:06 PM
-- Design Name: 
-- Module Name: top - behav
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity top is
  port (clk : in std_logic;
        led : out std_logic_vector(15 downto 0);
        btnC: in std_logic;
        btnD: in std_logic
  );
end top;

architecture behav of top is
    constant OPERAND_WIDTH : integer := 32;

    signal res_n : std_logic;
    signal start : std_logic;
    signal done : std_logic;
    signal is_signed : boolean;
    signal dividend : std_logic_vector(OPERAND_WIDTH - 1 downto 0);
    signal divisor : std_logic_vector(OPERAND_WIDTH - 1 downto 0);
    signal quotient : std_logic_vector(OPERAND_WIDTH - 1 downto 0);
    signal remainder : std_logic_vector(OPERAND_WIDTH - 1 downto 0);
begin
    res_n <= btnD;
    start <= '1' when btnC = '0' else '0';
    
    process(all) is begin 
        -- Initialize
        dividend <= (others => '1');
        divisor  <= (others => '0');
        is_signed <= true;
    end process;
    
    -- Component instantiation
    divider_i : entity work.radix4_srt_divider_optimized
    port map (
        clk => clk,
        res_n => res_n,
        start => start,
        done => done,
        is_signed => is_signed,
        divisor => divisor,
        dividend => dividend,
        quotient => quotient,
        remainder => remainder
    );
    
    output: process(all) is
    begin
        if signed(quotient) = to_signed(-1, quotient'length) then 
            led(0) <= '1';
        else
            led(0) <= '0';
        end if;
        
        if signed(remainder) = to_signed(-1, remainder'length) then 
            led(1) <= '1';
        else
            led(1) <= '0';
        end if;
        led(2) <= done;
        led(led'left downto 3) <= (others => '0');
    end process output;

end behav;
