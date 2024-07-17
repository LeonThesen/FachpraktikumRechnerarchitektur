--
-- VHDL Architecture RISCV_Processor_lib.res_synchronizer.behav
--
-- Created:
--          by - st161569.st161569 (pc043)
--          at - 17:54:03 07/11/24
--
-- using Mentor Graphics HDL Designer(TM) 2022.3 Built on 14 Jul 2022 at 13:56:12
--
ARCHITECTURE behav OF res_synchronizer IS
    signal res_sync: std_logic;
BEGIN
    process(clk) is
    begin
        if clk'event and clk = '1' then
            res_sync <= res_key;
            res_n <= res_sync;
        end if;
    end process;
END ARCHITECTURE behav;

