-- VHDL Entity RISCV_Processor_lib.umnudler.interface
--
-- Created:
--          by - st161569.st161569 (pc043)
--          at - 14:44:05 06/19/24
--
-- Generated by Mentor Graphics' HDL Designer(TM) 2022.3 Built on 14 Jul 2022 at 13:56:12
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;
LIBRARY RISCV_Processor_lib;
USE RISCV_Processor_lib.types.ALL;
USE RISCV_Processor_lib.isa_defines.ALL;
LIBRARY altera_mf;
USE altera_mf.altera_mf_components.all;

ENTITY umnudler IS
   PORT( 
      instruction_word_rom        : IN     word_t;
      instruction_word_umgenudelt : OUT    word_t
   );

-- Declarations

END umnudler ;
