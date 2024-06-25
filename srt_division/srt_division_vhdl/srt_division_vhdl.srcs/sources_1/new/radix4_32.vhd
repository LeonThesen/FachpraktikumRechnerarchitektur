library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_textio.all; -- debug only
use std.textio.all; -- debug only
use ieee.math_real.all;

-- TODO: we need a 64 bit divisor module 
-- TODO: handle special cases like divide by zero or one look at RISCV manual, also if divisor is greater quotient is zero and remainder is divisor
-- TODO: we currently only handle unsigned numbers determine sign
-- TODO: rename module cause its generic now
-- TODO: resize outputs like quotient and remainder to 64 bit --> continue here, we need an internal quotient signal 

entity radix4_32 is
    generic(
        OP_WIDTH : natural := 64 -- due to the divisor being half the width of the dividend we have to use 64 bits even though we only insert 32 bit numbers
    );
    port (
        clk       : in  std_logic;
        res_n     : in  std_logic;
        start     : in  std_logic;
        done      : out std_logic;
        divisor   : in  std_logic_vector(31 downto 0);
        dividend  : in  std_logic_vector(31 downto 0);
        quotient  : out std_logic_vector(31 downto 0);
        remainder : out std_logic_vector(31 downto 0)
    );
end radix4_32;

architecture behav of radix4_32 is
    type state_type is (init, norm, norm2, divide, finished);
    signal state, next_state : state_type;
    constant width    : integer := OP_WIDTH - 1;
    constant width_h  : integer := OP_WIDTH / 2 - 1;
    signal i, j       : unsigned(integer(floor(log2(real(OP_WIDTH)))) + 1 downto 0);
    signal remainder_r: unsigned(OP_WIDTH + 1 downto 0);
    signal divisor_r  : unsigned(OP_WIDTH / 2 downto 0);
    signal n_divisor  : unsigned(OP_WIDTH / 2 downto 0);
    signal left_half_remainder : unsigned(OP_WIDTH / 2 + 1 downto 0);
    signal remainder_correction: unsigned(OP_WIDTH / 2 + 1 downto 0);
    signal rem_add, rem_sub    : unsigned(OP_WIDTH / 2 + 1 downto 0);
    signal rem_add2, rem_sub2  : unsigned(OP_WIDTH / 2 + 1 downto 0);
    signal quotient_int : std_logic_vector(width downto 0);
begin
    n_divisor <= not(divisor_r) + 1; -- perform twos complement negation
    left_half_remainder <= remainder_r(width + 2 downto (width + 1) / 2);
    remainder_correction <= left_half_remainder + (divisor_r & '0');
    rem_add <= (left_half_remainder sll 1) + ('0' & divisor_r) sll 1;
    rem_sub <= (left_half_remainder sll 1) + ('1' & n_divisor) sll 1;
    rem_add2 <= (left_half_remainder sll 1) + (divisor_r & '0') sll 1;
    rem_sub2 <= (left_half_remainder sll 1) + (n_divisor & '0') sll 1;

    state_reg: process (clk, res_n)
    begin
        if res_n = '0' then
            state <= init;
        elsif rising_edge(clk) then
            state <= next_state;
        end if;
    end process state_reg;

    process (state, start, divisor_r, i)
    begin
        case state is
            when init =>
                if start = '1' then
                    report "Starting Division";
                    report "un-normalized divisor = " & integer'image(to_integer(unsigned(divisor_r))) & ", dividend = " & integer'image(to_integer(unsigned(dividend)));
                    next_state <= norm;
                else
                    next_state <= init;
                end if;
            when norm =>
                if divisor_r(width_h) = '1' or divisor_r(width_h-1) = '1' then
                    next_state <= norm2;
                else
                    next_state <= norm;
                end if;
            when norm2 =>
                report "divisor shifted by " & integer'image(to_integer(j)) & " for normalization. normalized divisor = " & integer'image(to_integer(unsigned(divisor_r)));
                report "iterations necessary for division are (width+amount shifted / 2) = " & integer'image((width_h + to_integer(j)) / 2);
                next_state <= divide;
            when divide =>
                if i = 0 or i(i'left) = '1' then
                    next_state <= finished;
                else
                    next_state <= divide;
                end if;
            when finished =>
                next_state <= init;
        end case;
    end process;

    process (clk, res_n)
        variable shift_amount : integer range 0 to OP_WIDTH;
        variable selected_quotient : integer;
    begin
        if res_n = '0' then
            quotient <= (others => '0');
            quotient_int <= (others => '0');
            remainder <= (others => '0');
            i <= (others => '0');
            done <= '0';
            remainder_r <= (others => '0');
            j <= (others => '0');
        elsif rising_edge(clk) then
            case state is
                when init =>
                    divisor_r <= resize(unsigned('0' & divisor(width_h downto 0)), divisor_r'length);
                    remainder <= (others => '0');
                    remainder_r(OP_WIDTH downto 1) <= resize(unsigned(dividend), remainder_r'length - 2);
                when norm =>
                    case divisor_r(width_h downto width_h-15) is
                        when "1---------------" => divisor_r <= divisor_r sll 0;  j <= j + 0;
                        when "01--------------" => divisor_r <= divisor_r sll 1;  j <= j + 1;
                        when "001-------------" => divisor_r <= divisor_r sll 2;  j <= j + 2;
                        when "0001------------" => divisor_r <= divisor_r sll 3;  j <= j + 3;
                        when "00001-----------" => divisor_r <= divisor_r sll 4;  j <= j + 4;
                        when "000001----------" => divisor_r <= divisor_r sll 5;  j <= j + 5;
                        when "0000001---------" => divisor_r <= divisor_r sll 6;  j <= j + 6;
                        when "00000001--------" => divisor_r <= divisor_r sll 7;  j <= j + 7;
                        when "000000001-------" => divisor_r <= divisor_r sll 8;  j <= j + 8;
                        when "0000000001------" => divisor_r <= divisor_r sll 9;  j <= j + 9;
                        when "00000000001-----" => divisor_r <= divisor_r sll 10; j <= j + 10;
                        when "000000000001----" => divisor_r <= divisor_r sll 11; j <= j + 11;
                        when "0000000000001---" => divisor_r <= divisor_r sll 12; j <= j + 12;
                        when "00000000000001--" => divisor_r <= divisor_r sll 13; j <= j + 13;
                        when "000000000000001-" => divisor_r <= divisor_r sll 14; j <= j + 14;
                        when "0000000000000001" => divisor_r <= divisor_r sll 15; j <= j + 15;
                        when others             => divisor_r <= divisor_r sll 16; j <= j + 16;
                    end case;
                when norm2 =>
                    i <= width_h + j - 2; -- Keep track of how far divisor gets shifted
                    remainder_r <= remainder_r sll to_integer(unsigned(j(0 downto 0)));
                    report "remainder_r gets shifted by " & integer'image(to_integer(j)) & " to align the number";
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
                
                    shift_amount := to_integer(i) + 1 - to_integer(unsigned(j(0 downto 0)));
                    if shift_amount >= 2**i'length then
                        shift_amount := 0;
                    end if;

                    report "shift_amount = " & integer'image(shift_amount);
                    remainder_r((width+1)/2+1 downto 0) <= remainder_r((width-1)/2 downto 0) & "00";

                    case selected_quotient is 
                        when -2 =>
                            remainder_r(width+2 downto (width+1)/2+2) <= rem_add2(width_h+2 downto 2);
                            quotient_int <= std_logic_vector(signed(quotient_int) + (to_signed(-2, OP_WIDTH) sll shift_amount));
                            report "remainder_r is " & to_string(remainder_r) & " <- quotient[" &  to_string(shift_amount) & "] = -2. decision bits are " & to_string(remainder_r(width + 2 downto width - 3));
                            report "        add 2*divisor_r";     
                        when -1 =>
                            remainder_r(width+2 downto (width+1)/2+2) <= rem_add(width_h+2 downto 2);
                            quotient_int <= std_logic_vector(signed(quotient_int) + (to_signed(-1, OP_WIDTH) sll shift_amount));
                            report "remainder_r is " & to_string(remainder_r) & " <- quotient[" &  to_string(shift_amount) & "] = -1. decision bits are " & to_string(remainder_r(width + 2 downto width - 3));
                            report "        add 1*divisor_r";    
                        when 1 =>
                            remainder_r(width+2 downto (width+1)/2+2) <= rem_sub(width_h+2 downto 2);
                            quotient_int <= std_logic_vector(signed(quotient_int) + (to_signed(1, OP_WIDTH) sll shift_amount));
                            report "remainder_r is " & to_string(remainder_r) & " <- quotient[" &  to_string(shift_amount) & "] = 1. decision bits are " & to_string(remainder_r(width + 2 downto width - 3));
                            report "        subtract 1*divisor_r";  
                        when 2 =>
                            remainder_r(width+2 downto (width+1)/2+2) <= rem_sub2(width_h+2 downto 2);
                            quotient_int <= std_logic_vector(signed(quotient_int) + (to_signed(2, OP_WIDTH) sll shift_amount));
                            report "remainder_r is " & to_string(remainder_r) & " <- quotient[" &  to_string(shift_amount) & "] = 2. decision bits are " & to_string(remainder_r(width + 2 downto width - 3));
                            report "        subtract 2*divisor_r";
                        when others =>
                            remainder_r <= remainder_r sll 2;
                            report "remainder_r is " & to_string(remainder_r) & " <- quotient[" &  to_string(shift_amount) & "] = 0. decision bits are " & to_string(remainder_r(width + 2 downto width - 3));
                            report "        just shift";
                    end case;
                    i <= i - to_unsigned(2, i'length); 
                when finished =>
                    -- Correction            
                    if remainder_r(width + 2) = '1' then 
                        remainder <= std_logic_vector(resize(unsigned(remainder_correction) srl (to_integer(j) + 1), remainder'length));
                        quotient <= std_logic_vector(resize(signed(quotient_int) - 1, quotient'length));
                        report "remainder_r is " & to_string(remainder_r);
                        report "remainder is negative so shift remainder add divisor. Also subtract 1 from quotient";
                        report "remainder_r plus divisor is " & integer'image(to_integer(remainder_correction));
                        report "remainder = " & integer'image(to_integer(remainder_correction srl (to_integer(j) + 1))) & ", quotient = " & integer'image(to_integer(signed(quotient) - 1));
                    else -- Shift remainder without correction
                        remainder <= std_logic_vector(resize(remainder_r(width + 1 downto (width + 1) / 2) srl (to_integer(j) + 1), remainder'length));
                        report "remainder_r is " & to_string(remainder_r);
                        report "remainder is positive so shift remainder";
                        report "remainder = " & integer'image(to_integer(remainder_r(width + 1 downto (width + 1) / 2) srl (to_integer(j) + 1))) & ", quotient = " & integer'image(to_integer(unsigned(quotient)));
                    end if;

                    done <= '1';
            end case;
        end if;
    end process;
end behav;