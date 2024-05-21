-- VHDL Entity RISCV_Processor_lib.alu.interface
--
-- Created:
--          by - st161569.st161569 (pc029)
--          at - 16:48:37 05/21/24
--
-- Generated by Mentor Graphics' HDL Designer(TM) 2022.3 Built on 14 Jul 2022 at 13:56:12
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;
LIBRARY RISCV_Processor_lib;
USE RISCV_Processor_lib.types.ALL;

ENTITY alu IS
   PORT( 
      alu_mode_ex   : IN     alu_mode_t;
      operand_a     : IN     word_t;
      operand_b     : IN     word_t;
      alu_result_ex : OUT    word_t
   );

-- Declarations

END alu ;

