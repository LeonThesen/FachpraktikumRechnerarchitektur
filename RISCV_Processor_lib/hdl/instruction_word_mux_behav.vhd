--
-- VHDL Architecture RISCV_Processor_lib.instruction_word_mux.behav
--
-- Created:
--          by - st161569.st161569 (pc043)
--          at - 17:24:12 05/29/24
--
-- using Mentor Graphics HDL Designer(TM) 2022.3 Built on 14 Jul 2022 at 13:56:12
--
library RISCV_Processor_lib;
use RISCV_Processor_lib.isa_defines.ALL;

ARCHITECTURE behav OF instruction_word_mux IS
BEGIN
    instruction_word_if <= NOP_INSTR when (sbta_valid_dc or dbta_valid_ex) else instruction_word_umgenudelt;
END ARCHITECTURE behav;

