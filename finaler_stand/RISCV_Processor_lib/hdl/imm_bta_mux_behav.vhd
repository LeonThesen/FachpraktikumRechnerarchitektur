--
-- VHDL Architecture RISCV_Processor_lib.imm_bta_mux.behav
--
-- Created:
--          by - st161569.st161569 (pc043)
--          at - 17:26:31 05/29/24
--
-- using Mentor Graphics HDL Designer(TM) 2022.3 Built on 14 Jul 2022 at 13:56:12
--
ARCHITECTURE behav OF imm_bta_mux IS
BEGIN
    imm_or_bta_dc <= bta when is_bta else imm_dc;
END ARCHITECTURE behav;

