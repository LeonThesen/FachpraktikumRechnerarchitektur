library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_textio.all; -- debug only
use std.textio.all; -- debug only
use ieee.math_real.all;
--library RISCV_Processor_lib; TODO: remove comments
--use RISCV_Processor_lib.types.all; TODO: remove comments

-- Operations of RISCV "M"-Extension are DIV, DIVU, REM, REMU
entity radix4_srt_divider_optimized is
    generic(
        XLEN : natural := 32;
        REMAINDER_WIDTH : natural := 36 -- Due to the divisor being half the width of the dividend we have to use 64 bits even though we only insert 32 bit numbers
    );
    port (
        clk       : in  std_logic;
        res_n     : in  std_logic;
        start     : in  std_logic;
        done      : out std_logic;
        is_signed : in  boolean;
        divisor   : in  std_logic_vector(XLEN - 1 downto 0); 
        dividend  : in  std_logic_vector(XLEN - 1 downto 0); 
        quotient  : out std_logic_vector(XLEN - 1 downto 0); 
        remainder : out std_logic_vector(XLEN - 1 downto 0)  
    );
end radix4_srt_divider_optimized;

architecture behav of radix4_srt_divider_optimized is
    type state_type is (init, norm, norm2, divide, finished_normal, finished_error, result_available);
    signal state, next_state : state_type;
    signal iteration, normalization_shift: unsigned(integer(floor(log2(real(XLEN)))) + 1 downto 0);
    signal remainder_r: unsigned(REMAINDER_WIDTH - 1 downto 0);
    signal divisor_r  : unsigned(XLEN downto 0);
    signal remainder_correction : unsigned(XLEN downto 0);
    signal quotient_int : std_logic_vector(XLEN - 1 downto 0);
    signal is_div_by_zero : boolean;
    signal is_div_overflow: boolean;
    signal is_divisor_greater_than_dividend : boolean;
    constant MOST_NEGATIVE_INT : signed(dividend'range) := (dividend'left => '1', others => '0');
    
    -- Define a function to count leading zeros
    function count_leading_zeros(signal vector : unsigned) return integer is
        variable iteration : integer := 0;
    begin
        for idx in vector'length - 1 downto 0 loop
            if vector(idx) = '1' then
                return iteration;
            end if;
            iteration := iteration + 1;
        end loop;
        return iteration; -- If all are zeros, return the length of the vector
    end function;
begin
    remainder_correction <= remainder_r(remainder_r'left downto remainder_r'left - XLEN) + divisor_r;

    -- state_reg: process (clk, res_n)
    -- begin
    --     if res_n = '0' then
    --         state <= init;
    --     elsif rising_edge(clk) then
    --         state <= next_state;
    --     end if;
    -- end process state_reg;

    state_transition: process (state, start, divisor_r, iteration, is_div_by_zero, is_div_overflow, is_divisor_greater_than_dividend)
    begin
        case state is
            when init =>
                if start = '1' then
                    --report "Starting Division:" &  " un-normalized divisor = " & to_string(unsigned(divisor)) & ", dividend = " & to_string(unsigned(dividend));
                    next_state <= norm;
                else
                    next_state <= init;
                end if;
            when norm =>
                if is_div_by_zero or is_div_overflow or is_divisor_greater_than_dividend then
                    next_state <= finished_error;
                else
                    next_state <= norm2;
                end if;
            when norm2 =>
                --report "iterations necessary for division are (width+amount shifted / 2) = " & to_string((XLEN / 2 - 1  + to_integer(normalization_shift)) / 2);
                --report "divisor shifted by " & to_string(to_integer(normalization_shift)) & " for normalization. normalized divisor = " & to_string(unsigned(divisor_r));
                next_state <= divide;
            when divide =>
                if iteration <= 0 then
                    next_state <= finished_normal;
                else
                    next_state <= divide;
                end if;
            when finished_normal | finished_error =>
                next_state <= result_available;
            when result_available =>
                next_state <= init;
        end case;
    end process state_transition;

    process (clk, res_n)
        variable shift_amount : integer;
        variable selected_quotient : integer;
        variable dividend_int : std_logic_vector(dividend'range);
        variable divisor_int : std_logic_vector(divisor'range);
        variable is_dividend_negative : boolean;
        variable is_divisor_negative : boolean;
        variable is_quotient_negative : boolean;
        variable is_remainder_negative : boolean;
        variable leading_zeros : integer;
        variable leading_zeros_dividend : integer;
        variable remainder_r_temp : unsigned(remainder_r'range);
    begin
        if res_n = '0' then
            quotient <= (others => '0');
            quotient_int <= (others => '0');
            remainder <= (others => '0');
            divisor_r <= (others => '0');
            iteration <= (others => '0');
            done <= '0';
            remainder_r <= (others => '0');
            normalization_shift <= (others => '0');
            is_div_by_zero <= false;
            is_div_overflow <= false;
            is_divisor_greater_than_dividend <= false;
            remainder_r_temp := (others => '0');
            is_dividend_negative := false;
            is_divisor_negative := false;
            is_quotient_negative := false;
            is_remainder_negative := false;


            state <= init;
            leading_zeros_dividend := 0;

        elsif rising_edge(clk) then
            state <= next_state; -- FIXME
            case next_state is
                when init =>
                    quotient <= (others => '0');
                    quotient_int <= (others => '0');
                    remainder <= (others => '0');
                    divisor_r <= (others => '0');
                    iteration <= (others => '0');
                    done <= '0';
                    remainder_r <= (others => '0');
                    normalization_shift <= (others => '0');
                    is_div_by_zero <= false;
                    is_div_overflow <= false;
                    is_divisor_greater_than_dividend <= false;
                    remainder_r_temp := (others => '0');

                    is_dividend_negative := false;
                    is_divisor_negative := false;
                    is_quotient_negative := false;
                    is_remainder_negative := false;
                    
                    leading_zeros_dividend := 0;

                    -- Check for division by zero
                    if signed(divisor) = 0 then
                        is_div_by_zero <= true;
                    end if;
                    
                    -- Check for division overflow
                    if is_signed then
                        if signed(dividend) = MOST_NEGATIVE_INT and signed(divisor) = -1 then
                            is_div_overflow <= true;
                        end if;
                    end if;
                    
                    -- Optimization
                    if abs(signed(divisor)) > abs(signed(dividend)) then
                        is_divisor_greater_than_dividend <= true;
                    end if;
                    
                    -- Determine sign of divisor and dividend and convert them to unsigned if negative
                    dividend_int := dividend;
                    divisor_int := divisor;
                    
                    if is_signed then
                        if signed(dividend) < 0 then
                            is_dividend_negative := true;
                            -- Convert to unsigned
                            dividend_int := std_logic_vector(-signed(dividend));
                        end if; 
                        
                        
                        if signed(divisor) < 0 then
                            is_divisor_negative := true;
                            -- Convert to unsigned
                            divisor_int := std_logic_vector(-signed(divisor));
                        end if;
                        
                        -- Determine signs of quotient and remainder:
                        -- Case 1: +a/+b => +q, +r 
                        -- Case 2: -a/+b => -q, -r 
                        -- Case 3: +a/-b => -q, +r 
                        -- Case 4: -a/-b => +q, -r 
                        -- In all cases the remainder sign follows the dividends sign
                        is_remainder_negative := is_dividend_negative;
                        is_quotient_negative := is_dividend_negative xor is_divisor_negative;
                    end if;
        
                    divisor_r <= unsigned('0' & divisor_int);
                    remainder_r <= resize(unsigned(dividend_int), remainder_r'length);
                when norm =>
                    -- Check for leading zeros in divisor and remove them
                    leading_zeros := count_leading_zeros(divisor_r);
                    divisor_r <= divisor_r sll (leading_zeros - 1);
                    if leading_zeros > 0 then
                        normalization_shift <= normalization_shift + (leading_zeros - 1);
                    end if;
                    leading_zeros_dividend := count_leading_zeros(remainder_r) - 4;
                    remainder_r <= remainder_r sll leading_zeros_dividend;
                    --report "normalization_shift = " & integer'image(to_integer(normalization_shift));
                when norm2 =>
                    --iteration <= (normalization_shift srl 1) + to_unsigned(1, iteration'length); -- Keep track of how far divisor gets shifted
                    --iteration <= (normalization_shift srl 1) + to_unsigned(1, iteration'length) - (to_unsigned(leading_zeros_dividend, iteration'length) srl 1); -- Keep track of how far divisor gets shifted
                    --remainder_r <= remainder_r sll (1 + to_integer(unsigned(normalization_shift(0 downto 0))));
                    
                    iteration <= ((normalization_shift srl 1) + to_unsigned(2, iteration'length)) - (to_unsigned(leading_zeros_dividend, iteration'length) srl 1);
                    
                    if (leading_zeros_dividend mod 2) = to_integer(unsigned(normalization_shift(0 downto 0))) then
                        remainder_r <= remainder_r srl 1;
                    end if;
                    
                    if to_integer(unsigned(normalization_shift(0 downto 0))) = 0 and (leading_zeros_dividend mod 2) = 1 then 
                        iteration <= ((normalization_shift srl 1) + to_unsigned(1, iteration'length)) - (to_unsigned(leading_zeros_dividend, iteration'length) srl 1);
                    end if;

                    
                when divide =>
                    -- Lookup Table for Quotient Selection
                    case divisor_r(divisor_r'left - 1 downto divisor_r'left - 4) is
                        when "1000" =>
                            if remainder_r(remainder_r'left) = '0' then -- positive
                                if remainder_r(remainder_r'left - 1 downto remainder_r'left - 5) >= "0110" then
                                    selected_quotient := 2;
                                elsif remainder_r(remainder_r'left - 1 downto remainder_r'left - 5) >= "0010" and remainder_r(remainder_r'left - 1 downto remainder_r'left - 5) < "0110" then
                                    selected_quotient := 1;
                                else
                                    selected_quotient := 0;
                                end if;
                            else -- negative
                                if remainder_r(remainder_r'left - 1 downto remainder_r'left - 5) < "11010" then --more negative than cutoff
                                    selected_quotient := -2;
                                elsif remainder_r(remainder_r'left - 1 downto remainder_r'left - 5) < "11110" and remainder_r(remainder_r'left - 1 downto remainder_r'left - 5) >= "11010" then
                                    selected_quotient := -1;
                                else
                                    selected_quotient := 0;
                                end if;
                            end if;
                        when "1001" =>
                            if remainder_r(remainder_r'left) = '0' then -- positive
                                if remainder_r(remainder_r'left - 1 downto remainder_r'left - 5) >= "0111" then
                                    selected_quotient := 2;
                                elsif remainder_r(remainder_r'left - 1 downto remainder_r'left - 5) >= "0010" and remainder_r(remainder_r'left - 1 downto remainder_r'left - 5) < "0111" then
                                    selected_quotient := 1;
                                else
                                    selected_quotient := 0;
                                end if;
                            else -- negative
                                if remainder_r(remainder_r'left - 1 downto remainder_r'left - 5) < "11001" then -- more negative than cutoff
                                    selected_quotient := -2;
                                elsif remainder_r(remainder_r'left - 1 downto remainder_r'left - 5) < "11110" and remainder_r(remainder_r'left - 1 downto remainder_r'left - 5) >= "11001" then
                                    selected_quotient := -1;                             
                                else
                                    selected_quotient := 0; 
                                end if;
                            end if;  
                        when "1010" =>
                            if remainder_r(remainder_r'left) = '0' then -- positive
                                if remainder_r(remainder_r'left - 1 downto remainder_r'left - 5) >= "1000" then
                                    selected_quotient := 2;
                                elsif remainder_r(remainder_r'left - 1 downto remainder_r'left - 5) >= "0011" and remainder_r(remainder_r'left - 1 downto remainder_r'left - 5) < "1000" then
                                    selected_quotient := 1;
                                else
                                    selected_quotient := 0; 
                                end if;
                            else -- negative
                                if remainder_r(remainder_r'left - 1 downto remainder_r'left - 5) < "11000" then -- more negative than cutoff
                                    selected_quotient := -2;
                                elsif remainder_r(remainder_r'left - 1 downto remainder_r'left - 5) < "11101" and remainder_r(remainder_r'left - 1 downto remainder_r'left - 5) >= "11000" then
                                    selected_quotient := -1;                        
                                else
                                    selected_quotient := 0; 
                                end if;
                            end if;  
                        when "1011" =>
                            if remainder_r(remainder_r'left) = '0' then -- positive
                                if remainder_r(remainder_r'left - 1 downto remainder_r'left - 5) >= "1001" then
                                    selected_quotient := 2;
                                elsif remainder_r(remainder_r'left - 1 downto remainder_r'left - 5) >= "0011" and remainder_r(remainder_r'left - 1 downto remainder_r'left - 5) < "1001" then
                                    selected_quotient := 1;
                                else
                                    selected_quotient := 0;
                                end if;
                            else -- negative
                                if remainder_r(remainder_r'left - 1 downto remainder_r'left - 5) < "10111" then -- more negative than cutoff
                                    selected_quotient := -2;
                                elsif remainder_r(remainder_r'left - 1 downto remainder_r'left - 5) < "11101" and remainder_r(remainder_r'left - 1 downto remainder_r'left - 5) >= "10111" then
                                    selected_quotient := -1;
                                else
                                    selected_quotient := 0;
                                end if;
                            end if;
                        when "1100" =>
                            if remainder_r(remainder_r'left) = '0' then -- positive
                                if remainder_r(remainder_r'left - 1 downto remainder_r'left - 5) >= "1010" then
                                    selected_quotient := 2;
                                elsif remainder_r(remainder_r'left - 1 downto remainder_r'left - 5) >= "0011" and remainder_r(remainder_r'left - 1 downto remainder_r'left - 5) < "1010" then
                                    selected_quotient := 1;
                                else
                                    selected_quotient := 0;
                                end if;
                            else -- negative
                                if remainder_r(remainder_r'left - 1 downto remainder_r'left - 5) < "10110" then -- more negative than cutoff
                                    selected_quotient := -2;
                                elsif remainder_r(remainder_r'left - 1 downto remainder_r'left - 5) < "11101" and remainder_r(remainder_r'left - 1 downto remainder_r'left - 5) >= "10110" then
                                    selected_quotient := -1;        
                                else
                                    selected_quotient := 0;
                                end if;
                            end if;
                        when "1101" =>
                            if remainder_r(remainder_r'left) = '0' then -- positive
                                if remainder_r(remainder_r'left - 1 downto remainder_r'left - 5) >= "1010" then
                                    selected_quotient := 2;
                                elsif remainder_r(remainder_r'left - 1 downto remainder_r'left - 5) >= "0011" and remainder_r(remainder_r'left - 1 downto remainder_r'left - 5) < "1010" then
                                    selected_quotient := 1;
                                else
                                    selected_quotient := 0;
                                end if;
                            else -- negative
                                if remainder_r(remainder_r'left - 1 downto remainder_r'left - 5) < "10110" then -- more negative than cutoff
                                    selected_quotient := -2;
                                elsif remainder_r(remainder_r'left - 1 downto remainder_r'left - 5) < "11101" and remainder_r(remainder_r'left - 1 downto remainder_r'left - 5) >= "10110" then
                                    selected_quotient := -1;                     
                                else
                                    selected_quotient := 0;
                                end if;
                            end if;
                        when others => 
                            if remainder_r(remainder_r'left) = '0' then -- positive
                                if remainder_r(remainder_r'left - 1 downto remainder_r'left - 5) >= "1011" then
                                    selected_quotient := 2;
                                elsif remainder_r(remainder_r'left - 1 downto remainder_r'left - 5) >= "0011" and remainder_r(remainder_r'left - 1 downto remainder_r'left - 5) < "1011" then
                                    selected_quotient := 1;
                                else
                                    selected_quotient := 0;
                                end if;
                            else -- negative
                                if remainder_r(remainder_r'left - 1 downto remainder_r'left - 5) < "10101" then -- more negative than cutoff
                                    selected_quotient := -2;
                                elsif remainder_r(remainder_r'left - 1 downto remainder_r'left - 5) < "11101" and remainder_r(remainder_r'left - 1 downto remainder_r'left - 5) >= "10101" then
                                    selected_quotient := -1;                 
                                else
                                    selected_quotient := 0;
                                end if;
                            end if;
                    end case;
                
                    shift_amount := to_integer(iteration sll 1) - 2;

                    --report "iteration = " & integer'image(to_integer(iteration));  
                    --report "shift_amount = " & integer'image(shift_amount);

                case selected_quotient is 
                    when -2 =>
                        remainder_r_temp := remainder_r sll 2;
                        remainder_r <= remainder_r_temp + ((divisor_r sll 1) & "000");
                        quotient_int <= std_logic_vector(signed(quotient_int) + (to_signed(-2, quotient_int'length) sll shift_amount));
                        --report "remainder_r is " & to_string(remainder_r) & " <- quotient[" &  to_string(shift_amount) & "] = -2. decision bits are " & to_string(remainder_r(remainder_r'left downto remainder_r'left - 5));
                        --report "        add 2*divisor_r"; 
                    when -1 =>
                        remainder_r_temp := remainder_r sll 2;
                        remainder_r <= remainder_r_temp + (divisor_r & "000");
                        quotient_int <= std_logic_vector(signed(quotient_int) + (to_signed(-1, quotient_int'length) sll shift_amount));
                        --report "remainder_r is " & to_string(remainder_r) & " <- quotient[" &  to_string(shift_amount) & "] = -1. decision bits are " & to_string(remainder_r(remainder_r'left downto remainder_r'left - 5));
                        --report "        add 1*divisor_r";  
                    when 1 =>
                        remainder_r_temp := remainder_r sll 2;
                        remainder_r <= remainder_r_temp + ((not(divisor_r) + 1) & "000");
                        quotient_int <= std_logic_vector(signed(quotient_int) + (to_signed(1, quotient_int'length) sll shift_amount));
                        --report "remainder_r is " & to_string(remainder_r) & " <- quotient[" &  to_string(shift_amount) & "] = 1. decision bits are " & to_string(remainder_r(remainder_r'left downto remainder_r'left - 5));
                        --report "        subtract 1*divisor_r"; 
                    when 2 =>
                        remainder_r_temp := remainder_r sll 2;
                        remainder_r <= remainder_r_temp + (((not(divisor_r) + 1) sll 1) & "000");
                        quotient_int <= std_logic_vector(signed(quotient_int) + (to_signed(2, quotient_int'length) sll shift_amount));
                        --report "remainder_r is " & to_string(remainder_r) & " <- quotient[" &  to_string(shift_amount) & "] = 2. decision bits are " & to_string(remainder_r(remainder_r'left downto remainder_r'left - 5));
                        --report "        subtract 2*divisor_r";
                    when others =>
                        remainder_r <= remainder_r sll 2;
                        --report "remainder_r is " & to_string(remainder_r) & " <- quotient[" &  to_string(shift_amount) & "] = 0. decision bits are " & to_string(remainder_r(remainder_r'left downto remainder_r'left - 5));
                        --report "        just shift";
                end case;

                    iteration <= iteration - to_unsigned(1, iteration'length); 
                when finished_normal =>
                    -- Correction step  
                    --report "remainder_r = " & to_string(remainder_r); 
                    if remainder_r(remainder_r'left) = '1' then 
                        if is_remainder_negative then
                            remainder <= std_logic_vector(resize(-signed(unsigned(remainder_correction) srl (to_integer(normalization_shift))), remainder'length));
                        else
                            remainder <= std_logic_vector(resize(unsigned(remainder_correction) srl (to_integer(normalization_shift)), remainder'length));
                        end if;
                        
                        if is_quotient_negative then
                            quotient <= std_logic_vector(resize(-(signed(quotient_int) - 1), quotient'length));
                        else 
                            quotient <= std_logic_vector(resize(signed(quotient_int) - 1, quotient'length));
                        end if;
                    else -- Shift remainder without correction
                        if is_quotient_negative then
                            quotient <= std_logic_vector(resize(-signed(quotient_int), quotient'length));
                        else
                            quotient <= quotient_int(quotient'range);
                        end if;
                        
                        if is_remainder_negative then
                            remainder <= std_logic_vector(resize(-signed(remainder_r(remainder_r'left downto remainder_r'left - XLEN) srl (to_integer(normalization_shift))), remainder'length));
                        else
                            remainder <= std_logic_vector(resize(remainder_r(remainder_r'left downto remainder_r'left - XLEN) srl (to_integer(normalization_shift)), remainder'length));
                        end if;
                    end if;
                    done <= '1';
                when finished_error =>
                
                    if is_div_by_zero then
                        quotient <= (others => '1');
                        remainder <= dividend;
                    elsif is_div_overflow then
                        -- Assign the most negative value to quotient
                        quotient <= std_logic_vector(MOST_NEGATIVE_INT);
                        remainder <= (others => '0');
                    elsif is_divisor_greater_than_dividend then
                        quotient <= (others => '0');
                        remainder <= dividend;
                    end if;
                    
                    done <= '1';
                when result_available =>
                    --report "remainder is " & to_string(remainder) & ", quotient" & to_string(quotient);
                    done <= '0';
            end case;
        end if;
    end process;
end behav;
