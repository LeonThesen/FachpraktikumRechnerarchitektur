--
-- VHDL Architecture RISCV_Processor_lib.clk_res_gen.behav
--
-- Created:
--          by - st161569.st161569 (pc043)
--          at - 13:48:55 05/08/24
--
-- using Mentor Graphics HDL Designer(TM) 2022.3 Built on 14 Jul 2022 at 13:56:12
--
ARCHITECTURE behav OF clk_res_gen IS
    constant HALF_PERIOD : TIME := 10ns;
    constant RES_DURATION: TIME := 15ns;
BEGIN
    clk_gen: process is 
    begin
        clk <= '0';
        wait for HALF_PERIOD;
        clk <= '1';
        wait for HALF_PERIOD;
    end process clk_gen;
    
    res_gen: process is 
    begin 
        res_n <= '0';
        wait for RES_DURATION;
        res_n <= '1';
        wait;
    end process res_gen;
    
END ARCHITECTURE behav;