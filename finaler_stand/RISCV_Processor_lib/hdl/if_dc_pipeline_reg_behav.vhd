--
-- VHDL Architecture RISCV_Processor_lib.if_dc_pipeline_reg.behav
--
-- Created:
--          by - st161569.st161569 (pc043)
--          at - 16:28:48 05/08/24
--
-- using Mentor Graphics HDL Designer(TM) 2022.3 Built on 14 Jul 2022 at 13:56:12
--

library RISCV_Processor_lib;
use RISCV_Processor_lib.types.ALL;

ARCHITECTURE behav OF if_dc_pipeline_reg IS
BEGIN
    process(clk, res_n) is
    variable is_startup : boolean;
    begin
        if res_n = '0' then
            instruction_word_dc <= (others => '0');
            pc_dc <= (others => '0');
            jump_predicted_dc <= false;
            bpb_state_dc <= (others => '0');
            predicted_target_addr_dc <= (others => '0');
        else
            if clk'event and clk = '1' then
                if not stall_dc then
                    instruction_word_dc <= instruction_word_if;
                    pc_dc <= pc_pre_if;
                    jump_predicted_dc <= jump_predicted_if;
                    bpb_state_dc <= bpb_state_if;
                    predicted_target_addr_dc <= predicted_target_addr_if;
                end if;
            end if;
        end if;
    end process;
END ARCHITECTURE behav;
