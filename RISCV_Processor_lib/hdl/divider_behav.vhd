--
-- VHDL Architecture RISCV_Processor_lib.divider.behav
--
-- Created:
--          by - st161569.st161569 (pc043)
--          at - 17:02:32 07/09/24
--
-- using Mentor Graphics HDL Designer(TM) 2022.3 Built on 14 Jul 2022 at 13:56:12
--
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
library RISCV_Processor_lib;
use RISCV_Processor_lib.types.all;

architecture behav of divider is
    signal mode_int : divider_mode_t;
    signal quotient_int : std_logic_vector(XLEN - 1 downto 0);
    signal remainder_int : std_logic_vector(XLEN - 1 downto 0);
    signal divider_result_int : std_logic_vector(XLEN - 1 downto 0);
    signal done_int : std_logic;
begin

    divider_i : entity work.radix4_srt_divider
        port map (
            clk => clk,
            res_n => res_n,
            start => divider_control_ex.start,
            is_signed => divider_control_ex.is_signed,
            divisor => operand_b,
            dividend => operand_a,
            quotient => quotient_int,
            remainder => remainder_int,
            done => done_int
        ); 

    mode_reg: process(clk, res_n) is
    begin
        if res_n = '0' then
            mode_int <= DIV_MODE;
        else
            if clk'event and clk = '1' then
                if divider_control_ex.start = '1' then
                    mode_int <= divider_control_ex.mode;
                end if;
            end if;
        end if;
    end process;

    result_mux: process(all) is
    begin 
        divider_result <= (others => '0');
        case mode_int is
            when DIV_MODE =>
                divider_result <= quotient_int;
            when REM_MODE =>
                divider_result <= remainder_int;
        end case;
    end process;

    division_done <= true when done_int = '1' else false;
end architecture behav;