--
-- VHDL Architecture RISCV_Processor_lib.dec_exe_pipeline_reg.behav
--
-- Created:
--          by - st161569.st161569 (pc043)
--          at - 15:02:16 05/08/24
--
-- using Mentor Graphics HDL Designer(TM) 2022.3 Built on 14 Jul 2022 at 13:56:12
--
library RISCV_Processor_lib;
use RISCV_Processor_lib.types.ALL;

ARCHITECTURE behav OF dc_ex_pipeline_reg IS
BEGIN
    process(clk, res_n) is
    begin
        if res_n = '0' then
            rs1_ex <= (others => '0');
            rs2_ex <= (others => '0');
            alu_mode_ex <= ADD_MODE;
            rd_addr_ex <= (others => '0');
            imm_to_alu_ex <= false;
            imm_or_bta_ex <= (others => '0');
            mem_mode_ex.memory_access <= IDLE;
            mem_mode_ex.data_width <= WORD;
            mem_mode_ex.is_signed <= FALSE;
            fwd_rs1_ex <= NO_FORWARDING;
            fwd_rs2_ex <= NO_FORWARDING;
            fwd_store_data_ex <= false;
            pc_ex <= (others => '0');
            dbpu_mode_ex <= NO_BRANCH;
            jump_predicted_ex <= false;
            bpb_state_ex <= (others => '0');
            predicted_target_addr_ex <= (others => '0');
            divider_control_ex.is_signed <= false;
            divider_control_ex.start <= '0';
            divider_control_ex.mode <= DIV_MODE;
        else 
            if clk'event and clk = '1' then
                if not stall_rest_dc then
                    rs1_ex <= rs1_dc;
                    rs2_ex <= rs2_dc;
                    alu_mode_ex <= alu_mode_dc;
                    rd_addr_ex <= rd_addr_dc;
                    imm_to_alu_ex <= imm_to_alu_dc;
                    imm_or_bta_ex <= imm_or_bta_dc;
                    mem_mode_ex <= mem_mode_dc;
                    fwd_rs1_ex <= fwd_rs1_dc;
                    fwd_rs2_ex <= fwd_rs2_dc;
                    fwd_store_data_ex <= fwd_store_data_dc;
                    pc_ex <= pc_dc;
                    dbpu_mode_ex <= dbpu_mode_dc;
                    jump_predicted_ex <= jump_predicted_dc;
                    bpb_state_ex <= bpb_state_dc;
                    predicted_target_addr_ex <= predicted_target_addr_dc;
                    divider_control_ex <= divider_control_dc;
                end if;
            end if;
        end if;
    end process;
END ARCHITECTURE behav;

