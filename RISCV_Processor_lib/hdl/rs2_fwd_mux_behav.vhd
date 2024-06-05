--
-- VHDL Architecture RISCV_Processor_lib.rs2_fwd_mux.behav
--
-- Created:
--          by - st161569.st161569 (pc043)
--          at - 12:56:34 05/22/24
--
-- using Mentor Graphics HDL Designer(TM) 2022.3 Built on 14 Jul 2022 at 13:56:12
--
ARCHITECTURE behav OF rs2_fwd_mux IS
BEGIN
    process(all) is
        begin 
            case fwd_rs2_ex is 
                when NO_FORWARDING => 
                    rs2_fwd_mux_out <= rs2_ex;
                when FROM_MEM => 
                    rs2_fwd_mux_out <= ex_out_mem;
                when FROM_WB =>
                    rs2_fwd_mux_out <= mem_result_wb;
            end case;
    end process;
END ARCHITECTURE behav;

