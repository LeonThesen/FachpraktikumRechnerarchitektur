----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 07/09/2024 03:00:45 PM
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity top is
--  Port ( );
end top;

architecture behav of top is
signal clk : std_logic;
    signal res_n : std_logic;
    signal start : std_logic;
    signal done : std_logic;
    signal correct : std_logic;
    component divider_wrapper is 
        port (
            clk : in std_logic;
            res_n : in std_logic;
            start : in std_logic;
            done : out std_logic;
            correct : out std_logic
        );
    end component divider_wrapper;
begin
    -- Component instantiation
    dut: divider_wrapper
        port map (
            clk => clk,
            res_n => res_n,
            start => start,
            done => done,
            correct => correct
        );
end behav;
