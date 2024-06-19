--
-- VHDL Architecture RISCV_Processor_lib.umnudler.behav
--
-- Created:
--          by - st161569.st161569 (pc043)
--          at - 14:44:05 06/19/24
--
-- using Mentor Graphics HDL Designer(TM) 2022.3 Built on 14 Jul 2022 at 13:56:12
--
ARCHITECTURE behav OF umnudler IS
BEGIN
instruction_word_umgenudelt <= instruction_word_rom(7 downto 0) & 
                               instruction_word_rom(15 downto 8) & 
                               instruction_word_rom(23 downto 16) & 
                               instruction_word_rom(31 downto 24);
END ARCHITECTURE behav;

