--
-- VHDL Architecture RISCV_Processor_lib.ex_out_mux.behav
--
-- Created:
--          by - st161569.st161569 (pc043)
--          at - 17:30:28 05/29/24
--
-- using Mentor Graphics HDL Designer(TM) 2022.3 Built on 14 Jul 2022 at 13:56:12
--
ARCHITECTURE behav OF ex_out_mux IS
BEGIN
    process(all) is
    begin
        if division_done then
            ex_out_ex <= divider_result;
        elsif is_return_addr then
            ex_out_ex <= return_addr;
        else 
            ex_out_ex <= alu_result_ex;
        end if;
    end process;
END ARCHITECTURE behav;

