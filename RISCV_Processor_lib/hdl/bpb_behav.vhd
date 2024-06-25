--
-- VHDL Architecture RISCV_Processor_lib.bpb.behav
--
-- Created:
--          by - st161569.st161569 (pc028)
--          at - 15:22:30 06/25/24
--
-- using Mentor Graphics HDL Designer(TM) 2022.3 Built on 14 Jul 2022 at 13:56:12
--
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.NUMERIC_STD.ALL;

ARCHITECTURE behav OF bpb IS
    constant K : positive := 8;
    subtype PC_RANGE is natural range (K - 1) downto 0;
    constant BUFF_SIZE : integer := 2**K;
    type bpb_t is array (0 to BUFF_SIZE - 1) of boolean;
    signal branch_prediction_buffer : bpb_t;
    signal jump_predicted_dc_int : boolean;
    signal wrong_jump_prediction_int : boolean;
BEGIN
    bpb_predict: process(all) is
    begin
        if jump_relevant_for_bpb_dc then
            jump_predicted_dc_int <= branch_prediction_buffer(to_integer(unsigned(pc_dc(PC_RANGE))));
        else
            jump_predicted_dc_int <= false;
        end if;
    end process bpb_predict;

    bpb_update: process(clk, res_n) is
    begin
        if res_n = '0' then
            branch_prediction_buffer <= (others => false);
        else
            if clk'event and clk = '1' then
                if jump_relevant_for_bpb_ex then
                    branch_prediction_buffer(to_integer(unsigned(pc_ex(PC_RANGE)))) <= dbta_valid_ex;
                end if;
            end if;
        end if;
    end process bpb_update;

    validate_prediction: process(all) is
    begin
        wrong_jump_prediction_int <= false;
        if jump_relevant_for_bpb_ex then
            if (dbta_valid_ex and not jump_predicted_ex) or (not dbta_valid_ex and jump_predicted_ex) then
                wrong_jump_prediction_int <= true;
            end if;
        end if;
    end process validate_prediction;

    jump_predicted_dc <= jump_predicted_dc_int;
    wrong_jump_prediction <= wrong_jump_prediction_int;
END ARCHITECTURE behav;

