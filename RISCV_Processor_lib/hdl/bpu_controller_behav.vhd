--
-- VHDL Architecture RISCV_Processor_lib.bpu_controller.behav
--
-- Created:
--          by - st161569.st161569 (pc040)
--          at - 15:45:03 07/03/24
--
-- using Mentor Graphics HDL Designer(TM) 2022.3 Built on 14 Jul 2022 at 13:56:12
--
ARCHITECTURE behav OF bpu_controller IS
BEGIN
    process(res_n) is
    begin
    -- TODO replace this with correct logi
        if res_n = '0' then
            write_addr <= (others => '0');
            write_enable <= '0';
            wdata_valid_bit <= (ohters => '0');
            wdata_tag <= (ohters => '0');
            wdata_target_addr <= (ohters => '0');
        else
            write_addr <= (others => '0');
            write_enable <= '0';
            wdata_valid_bit <= (ohters => '0');
            wdata_tag <= (ohters => '0');
            wdata_target_addr <= (ohters => '0');
        end if;
    end process;

    process(all) is
    begin
        read_addr <= pc(BP_K - 1 downto 0);
    end process;

    make_prediction: process(all) is
    begin
        jump_predicted_if <= false;
        predicted_target_addr <= (others => '0');

        if (tag = pc(pc'left downto BP_K)) and valid_bit = '1' then
            jump_predicted_if <= true;
            predicted_target_addr <= target_addr;
        end if;
    end process make_prediction;
END ARCHITECTURE behav;

