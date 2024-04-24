--
-- VHDL Architecture UPN_Rechner_Lib.tester.behav
--
-- Created:
--          by - st161569.st161569 (pc043)
--          at - 17:30:04 04/24/24
--
-- using Mentor Graphics HDL Designer(TM) 2022.3 Built on 14 Jul 2022 at 13:56:12
--
ARCHITECTURE behav OF tester IS
BEGIN
    process is 
    begin 
        tx_n <= '1';
        wait for 30ns;
        tx_n <= '0';
        wait for 200ns;
        tx_n <= '1';
        wait;
    end process;
END ARCHITECTURE behav;

