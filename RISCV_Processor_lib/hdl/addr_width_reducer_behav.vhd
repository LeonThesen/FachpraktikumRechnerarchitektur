--
-- VHDL Architecture RISCV_Processor_lib.addr_width_reducer.behav
--
-- Created:
--          by - st161569.st161569 (pc043)
--          at - 13:14:49 06/19/24
--
-- using Mentor Graphics HDL Designer(TM) 2022.3 Built on 14 Jul 2022 at 13:56:12
--
ARCHITECTURE behav OF addr_width_reducer IS
BEGIN
    process(all) is
    begin
        if stall_dc then
            rom_addr <= pc_pre_if(ADDR_WIDTH + 1 downto 2);
        else
            rom_addr <= pc(ADDR_WIDTH + 1 downto 2);
        end if;
    end process;
END ARCHITECTURE behav;

