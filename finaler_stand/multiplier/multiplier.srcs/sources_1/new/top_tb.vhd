library ieee;
use ieee.std_logic_1164.all;

entity top_tb is
end top_tb;

architecture sim of top_tb is
    constant CLOCK_PERIOD : time := 10ns;
    signal correct : std_logic;
    
    component multiplier_wrapper is 
        port (
            correct : out std_logic
        );
    end component multiplier_wrapper;
begin

    -- Component instantiation
    dut: multiplier_wrapper
        port map (
            correct => correct
        );

    -- Stimulus process
    stim_proc: process
    begin
        wait until correct = '1';
    end process stim_proc;

end sim;