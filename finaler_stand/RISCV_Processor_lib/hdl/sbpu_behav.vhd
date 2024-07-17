--
-- VHDL Architecture RISCV_Processor_lib.sbpu.behav
--
-- Created:
--          by - st161569.st161569 (pc043)
--          at - 14:51:24 07/09/24
--
-- using Mentor Graphics HDL Designer(TM) 2022.3 Built on 14 Jul 2022 at 13:56:12
--

library RISCV_Processor_lib;
use RISCV_Processor_lib.types.all;

ARCHITECTURE behav OF sbpu IS
BEGIN
    process (all) is 
    begin
        btc_controls_sbpu.wena_valid_bit <= '0';
        btc_controls_sbpu.wena_tag <= '0';
        btc_controls_sbpu.wena_target_addr <= '0';
        btc_controls_sbpu.wdata_valid_bit <= (others => '0');
        btc_controls_sbpu.wdata_tag <= (others => '0');
        btc_controls_sbpu.wdata_target_addr <= (others => '0');
        wrong_jump_prediction_sbpu <= false;

        btc_controls_sbpu.waddr <= pc_dc(BP_K + 1 downto 2);

        if sbpu_mode_dc = JAL and not jump_predicted_dc then
            btc_controls_sbpu.wena_tag <= '1';
            btc_controls_sbpu.wena_valid_bit <= '1';
            btc_controls_sbpu.wena_target_addr <= '1';
            btc_controls_sbpu.wdata_target_addr <= imm_or_bta_dc;
            btc_controls_sbpu.wdata_valid_bit <= "1";
            btc_controls_sbpu.wdata_tag <= pc_dc(pc_dc'left downto BP_K + 2);
            wrong_jump_prediction_sbpu <= true;
        end if;
    end process;
END ARCHITECTURE behav;

