-- VHDL Entity RISCV_Processor_lib.rs2_mux.interface
--
-- Created:
--          by - st161569.st161569 (pc043)
--          at - 17:46:24 05/29/24
--
-- Generated by Mentor Graphics' HDL Designer(TM) 2022.3 Built on 14 Jul 2022 at 13:56:12
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;
LIBRARY RISCV_Processor_lib;
USE RISCV_Processor_lib.types.ALL;

ENTITY rs2_mux IS
   PORT( 
      imm_or_bta_ex   : IN     word_t;
      imm_to_alu_ex   : IN     boolean;
      rs2_fwd_mux_out : IN     word_t;
      operand_b       : OUT    word_t
   );

-- Declarations

END rs2_mux ;

