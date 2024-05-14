--
-- VHDL Architecture RISCV_Processor_lib.address_gen.sim
--
-- Created:
--          by - st161569.st161569 (pc029)
--          at - 14:24:22 05/14/24
--
-- using Mentor Graphics HDL Designer(TM) 2022.3 Built on 14 Jul 2022 at 13:56:12
--
ARCHITECTURE sim OF address_gen IS
    constant HALF_PERIOD : TIME := 10ns;
    constant RES_DURATION: TIME := 15ns;
BEGIN
    process is
    begin
        address <= (others => '0');
        wait;
    end process;
END ARCHITECTURE sim;

