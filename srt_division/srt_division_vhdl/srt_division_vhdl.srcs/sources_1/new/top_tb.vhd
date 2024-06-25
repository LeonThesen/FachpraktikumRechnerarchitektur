----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 06/21/2024 11:16:49 PM
-- Design Name: 
-- Module Name: top_tb - sim
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

library ieee;
use ieee.std_logic_1164.all;

entity top_tb is
--  Port ( );
end top_tb;

architecture sim of top_tb is
    constant CLOCK_PERIOD : time := 10ns;

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

    -- Clock process definitions
    clk_process :process
    begin
        while true loop
            clk <= '0';
            wait for CLOCK_PERIOD;
            clk <= '1';
            wait for CLOCK_PERIOD;
        end loop;
    end process;

    -- Stimulus process
    stim_proc: process
    begin
        -- Initialize
        res_n <= '0';
        start <= '0';
        
        wait for CLOCK_PERIOD;
        res_n <= '1';
        wait for CLOCK_PERIOD;
        
        -- Start the divider
        start <= '1';
        wait for CLOCK_PERIOD;
        start <= '0';
        
        -- Wait for the done signal
        wait until done = '1';
        
        -- Check the result
        if correct /= '1' then
         report "Division incorrect!" severity error;
        end if;
        wait;
    end process stim_proc;

end sim;
