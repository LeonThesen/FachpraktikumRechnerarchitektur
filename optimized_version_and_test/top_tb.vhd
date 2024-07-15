library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_textio.all; -- debug only
use std.textio.all; -- debug only
use ieee.math_real.all;

entity top_tb is
end top_tb;

architecture sim of top_tb is
    constant CLOCK_PERIOD : time := 20ns;
    constant TEST_BIT_WIDTH : integer := 16;
    constant OPERAND_WIDTH : integer := 32;
    
    constant MOST_POSITIVE_INT : integer := (2**(TEST_BIT_WIDTH - 1)) - 1;
    
    constant MOST_NEGATIVE_INT_SIGNED : signed(TEST_BIT_WIDTH - 1 downto 0) := (TEST_BIT_WIDTH - 1 => '1', others => '0');
    constant MOST_NEGATIVE_INT : integer := to_integer(MOST_NEGATIVE_INT_SIGNED);
    
    constant DIV_OVERFLOW_QUOTIENT_SIGNED : signed(OPERAND_WIDTH - 1 downto 0) := (OPERAND_WIDTH - 1 => '1', others => '0');
    constant DIV_OVERFLOW_QUOTIENT : integer := to_integer(DIV_OVERFLOW_QUOTIENT_SIGNED);
    -- TODO: define biggest uint and zero 
    
    constant NUM_TESTS : unsigned(63 downto 0) := TO_UNSIGNED(2**(TEST_BIT_WIDTH * 2), 64);
    
    signal clk : std_logic;
    signal res_n : std_logic;
    signal start : std_logic;
    signal done : std_logic;
    signal is_signed : boolean;
    signal dividend : std_logic_vector(OPERAND_WIDTH - 1 downto 0);
    signal divisor : std_logic_vector(OPERAND_WIDTH - 1 downto 0);
    signal quotient : std_logic_vector(OPERAND_WIDTH - 1 downto 0);
    signal remainder : std_logic_vector(OPERAND_WIDTH - 1 downto 0);
begin

    -- Component instantiation
    dut_divider_i : entity work.radix4_srt_divider_optimized
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

    -- Clock process definitions
    clk_process :process
    begin
        while true loop
            clk <= '0';
            wait for CLOCK_PERIOD / 2;
            clk <= '1';
            wait for CLOCK_PERIOD / 2;
        end loop;
    end process;

-- IMPORTANT: TODO: track if first 32 bits of remainder are ever non zero for optimization

    -- Stimulus process
    stim_proc: process
        variable expected_quotient : integer;
        variable expected_remainder : integer;
        variable cycle_count : natural := 0;
        variable current_dividend : integer;
        variable current_divisor : integer;
        variable passed_tests: integer := 0;
    begin
        -- Initialize
        res_n <= '0';
        start <= '0';
        dividend <= (others => '0');
        divisor  <= (others => '0');

        wait for CLOCK_PERIOD / 2;
        res_n <= '1';
        wait for CLOCK_PERIOD;
        
        -- Test: Signed Integers
        is_signed <= true;
        
        for current_dividend in MOST_NEGATIVE_INT to MOST_POSITIVE_INT loop
            for current_divisor in MOST_NEGATIVE_INT to MOST_POSITIVE_INT loop
--                current_dividend := -127;
--                current_divisor := -63;
                dividend <= std_logic_vector(to_signed(current_dividend, OPERAND_WIDTH));
                divisor <= std_logic_vector(to_signed(current_divisor, OPERAND_WIDTH));

                -- Calculate expected results

                -- Special case 1: Divide by zero
                if current_divisor = 0 then 
                    expected_quotient := -1;
                    expected_remainder := current_dividend;
                -- Special case 2: Signed division overflow
                elsif current_divisor = -1 and current_dividend = DIV_OVERFLOW_QUOTIENT then
                    expected_quotient := DIV_OVERFLOW_QUOTIENT;
                    expected_remainder := 0;
                -- Special case 3: Divisor greater than zero (thats not really a special case)
                elsif abs(to_signed(current_divisor, OPERAND_WIDTH)) > abs(to_signed(current_dividend, OPERAND_WIDTH)) then
                    expected_quotient := 0;
                    expected_remainder := current_dividend;
                else
                    expected_quotient := current_dividend / current_divisor;
                    expected_remainder := current_dividend - (expected_quotient * current_divisor);
                end if;

                -- Start the division
                start <= '1';
                wait for CLOCK_PERIOD;
                start <= '0';

                wait until done = '1';
                
                -- Check the result
                if to_integer(signed(quotient)) /= expected_quotient or to_integer(signed(remainder)) /= expected_remainder then
                    report "TEST FAILED: Dividend = " & integer'image(current_dividend) & ", Divisor = " & integer'image(current_divisor) & ", Quotient = " & integer'image(to_integer(signed(quotient))) & ", Remainder = " & integer'image(to_integer(signed(remainder))) severity failure;
                    report "Expected Quotient = " & integer'image(expected_quotient) & ", Expected Remainder = " & integer'image(expected_remainder) severity failure;
                else
                    --report "TEST PASSED: Dividend = " & integer'image(current_dividend) & ", Divisor = " & integer'image(current_divisor) & ", Quotient = " & integer'image(to_integer(signed(quotient))) & ", Remainder = " & integer'image(to_integer(signed(remainder))) severity note;
                    passed_tests := passed_tests + 1;
                    if (passed_tests mod 1000) = 1 then
                        report "Passed: " & to_string(passed_tests) & "/ " & integer'image(to_integer(NUM_TESTS));
                    end if;
                end if;
                
                wait for 2 * CLOCK_PERIOD; -- Sync for restart
            end loop;
        end loop;
        
        report "ALL TESTS PASSED" severity note;

        -- Stop the simulation
        wait;
    end process stim_proc;
    
    -- this is wrong as it is only executed once at the end
    count_divide_latency: process(clk) is
        variable cycle_count : integer := 0;
    begin
        if rising_edge(clk) then
            if start = '1' then
                cycle_count := 0;
            elsif done = '1' then 
                -- Print the cycle count
                --report "Cycles taken: " & integer'image(cycle_count);
            else 
                cycle_count := cycle_count + 1;
            end if;
        end if;
    end process count_divide_latency;

end sim;


    