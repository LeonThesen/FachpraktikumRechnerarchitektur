--
-- VHDL Architecture RISCV_Processor_lib.io_pin_gen.behav
--
-- Created:
--          by - st161569.st161569 (pc043)
--          at - 11:38:09 07/11/24
--
-- using Mentor Graphics HDL Designer(TM) 2022.3 Built on 14 Jul 2022 at 13:56:12
--
ARCHITECTURE behav OF io_pin_gen IS
    constant D: TIME := 5000ns;
BEGIN
    process is
    begin
        button_1 <= '1';
        button_2 <= '1';
        button_3 <= '1';
        switches <= "1000100000";
        wait for D;
        button_1 <= '0';
        wait for D;
        button_1 <= '1';
        button_2 <= '0';
        switches <= "0000000011";
        wait for D;
        button_3 <= '0';
        button_2 <= '1';
        wait for D;
        button_3 <= '1';
        wait;
    end process;
END ARCHITECTURE behav;

