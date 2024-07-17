--
-- VHDL Architecture RISCV_Processor_lib.dbpu.behav
--
-- Created:
--          by - st161569.st161569 (pc043)
--          at - 17:26:57 05/29/24
--
-- using Mentor Graphics HDL Designer(TM) 2022.3 Built on 14 Jul 2022 at 13:56:12
--
library RISCV_Processor_lib;
use RISCV_Processor_lib.types.all;
use RISCV_Processor_lib.isa_defines.all;

ARCHITECTURE behav OF dbpu IS
    signal dbta_int : word_t;
    signal add_sub_result_int : word_t;
    signal dbta_flags: flag_t;
BEGIN
    add_sub: process(all) is 
        variable intermediate_low: word_t;
        variable intermediate_high: std_logic_vector(word_t'left + 1 downto word_t'left);
    begin
        case dbpu_mode_ex is
            when JALR => 
                intermediate_low := std_logic_vector(unsigned('0' & operand_a(operand_a'left - 1 downto operand_a'right)) +  unsigned('0' & operand_b(operand_b'left - 1 downto operand_b'right)));
                intermediate_high := std_logic_vector(unsigned('0' & operand_a(operand_a'left downto operand_a'left)) + unsigned('0' & operand_b(operand_b'left downto operand_b'left)) + unsigned('0' & intermediate_low(intermediate_low'left downto intermediate_low'left)));
            when others =>
                intermediate_low := std_logic_vector(unsigned('0' & operand_a(operand_a'left - 1 downto operand_a'right)) -  unsigned('0' & operand_b(operand_b'left - 1 downto operand_b'right)));
                intermediate_high := std_logic_vector(unsigned('0' & operand_a(operand_a'left downto operand_a'left)) - unsigned('0' & operand_b(operand_b'left downto operand_b'left)) - unsigned('0' & intermediate_low(intermediate_low'left downto intermediate_low'left)));
        end case;
        add_sub_result_int <= intermediate_high(intermediate_high'right) & intermediate_low(intermediate_low'left - 1 downto intermediate_low'right);
        dbta_flags.carry <= intermediate_high(intermediate_high'left) = '1';
        dbta_flags.overflow <= (intermediate_high(intermediate_high'left) xor intermediate_low(intermediate_low'left)) = '1';
        dbta_flags.negative <= add_sub_result_int(add_sub_result_int'left) = '1';
        if add_sub_result_int = ZERO_WORD then
            dbta_flags.zero <= true;
        else
            dbta_flags.zero <= false;
        end if;
    end process add_sub;

    process(all) is 
    begin
        is_return_addr <= false;
        dbta_int <= (others => '0');
        dbta_valid_ex <= false;

        case dbpu_mode_ex is
            when NO_BRANCH =>
                null;
            when JAL =>
                is_return_addr <= true;
            when JALR =>
                is_return_addr <= true;
                dbta_int <= add_sub_result_int;
                dbta_valid_ex <= true;
            when EQUAL =>
                if dbta_flags.zero then
                    dbta_int <= imm_or_bta_ex;
                    dbta_valid_ex <= true;
                end if;
            when NOT_EQUAL =>
                if not dbta_flags.zero then
                    dbta_int <= imm_or_bta_ex;
                    dbta_valid_ex <= true;
                end if;
            when LESS_THAN =>
                if dbta_flags.negative xor dbta_flags.overflow then
                    dbta_int <= imm_or_bta_ex;
                    dbta_valid_ex <= true;
                end if;
            when GREATER_OR_EQUAL =>
                if dbta_flags.negative = dbta_flags.overflow then
                    dbta_int <= imm_or_bta_ex;
                    dbta_valid_ex <= true;
                end if;
            when LESS_THAN_UNSIGNED =>
                if dbta_flags.carry then
                    dbta_int <= imm_or_bta_ex;
                    dbta_valid_ex <= true;
                end if;
            when GREATER_OR_EQUAL_UNSIGNED =>
                if not dbta_flags.carry then
                    dbta_int <= imm_or_bta_ex;
                    dbta_valid_ex <= true;
                end if;
        end case;
    end process;

    validate_prediction: process(all) is
    begin
        btc_controls_dbpu.wena_valid_bit <= '0';
        btc_controls_dbpu.wena_tag <= '0';
        btc_controls_dbpu.wena_target_addr <= '0';
        btc_controls_dbpu.wdata_valid_bit <= (others => '0');
        btc_controls_dbpu.wdata_tag <= (others => '0');
        btc_controls_dbpu.wdata_target_addr <= (others => '0');
        bpb_controls.wena <= '0';
        bpb_controls.wdata <= (others => '0');
        wrong_jump_prediction_dbpu <= false;

        bpb_controls.waddr <= pc_ex(BP_K + 1 downto 2);
        btc_controls_dbpu.waddr <= pc_ex(BP_K + 1 downto 2);

        if dbpu_mode_ex = JALR then
            if (jump_predicted_ex and predicted_target_addr_ex /= dbta_int) or not jump_predicted_ex then
                btc_controls_dbpu.wena_tag <= '1';
                btc_controls_dbpu.wena_valid_bit <= '1';
                btc_controls_dbpu.wena_target_addr <= '1';
                btc_controls_dbpu.wdata_target_addr <= dbta_int;
                btc_controls_dbpu.wdata_valid_bit <= "1";
                btc_controls_dbpu.wdata_tag <= pc_ex(pc_ex'left downto BP_K + 2);
                wrong_jump_prediction_dbpu <= true;
            end if;
        elsif dbpu_mode_ex /= NO_BRANCH and dbpu_mode_ex /= JAL then
            if dbta_valid_ex xor jump_predicted_ex then
                wrong_jump_prediction_dbpu <= true;
            end if;

            case bpb_state_ex is
                when "00" =>
                    if wrong_jump_prediction_dbpu then
                        bpb_controls.wdata <= "01";
                        bpb_controls.wena <= '1';
                    else
                        bpb_controls.wdata <= "00";
                    end if;
                when "01" =>
                    bpb_controls.wena <= '1';

                    if wrong_jump_prediction_dbpu then
                        btc_controls_dbpu.wena_tag <= '1';
                        btc_controls_dbpu.wena_valid_bit <= '1';
                        btc_controls_dbpu.wena_target_addr <= '1';
                        btc_controls_dbpu.wdata_target_addr <= dbta_int;
                        btc_controls_dbpu.wdata_valid_bit <= "1";
                        btc_controls_dbpu.wdata_tag <= pc_ex(pc_ex'left downto BP_K + 2);
                        bpb_controls.wdata <= "11";
                    else
                        bpb_controls.wdata <= "00";
                    end if;
                when "10" =>
                    bpb_controls.wena <= '1';

                    if wrong_jump_prediction_dbpu then
                        btc_controls_dbpu.wena_valid_bit <= '1';
                        btc_controls_dbpu.wdata_valid_bit <= "0";
                        bpb_controls.wdata <= "00";
                    else
                        bpb_controls.wdata <= "11";
                    end if;
                when "11" =>
                    if wrong_jump_prediction_dbpu then
                        bpb_controls.wdata <= "10";
                        bpb_controls.wena <= '1';
                    else
                        bpb_controls.wdata <= "11";
                    end if;
                when others =>
                    bpb_controls.wdata <= "XX";
            end case;
        end if;
    end process validate_prediction;

    dbta <= dbta_int;
END ARCHITECTURE behav;
