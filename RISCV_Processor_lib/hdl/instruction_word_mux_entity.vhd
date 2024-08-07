-- VHDL Entity RISCV_Processor_lib.instruction_word_mux.interface
--
-- Created:
--          by - st161569.st161569 (pc043)
--          at - 16:23:10 07/11/24
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

ENTITY instruction_word_mux IS
   PORT( 
      instruction_word_big_endian : IN     word_t;
      wrong_jump_prediction_dbpu  : IN     boolean;
      wrong_jump_prediction_sbpu  : IN     boolean;
      instruction_word_if         : OUT    word_t
   );

-- Declarations

END instruction_word_mux ;

