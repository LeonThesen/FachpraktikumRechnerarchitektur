-- VHDL Entity RISCV_Processor_lib.rom.interface
--
-- Created:
--          by - st161569.st161569 (pc043)
--          at - 15:37:05 05/29/24
--
-- Generated by Mentor Graphics' HDL Designer(TM) 2022.3 Built on 14 Jul 2022 at 13:56:12
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;
LIBRARY RISCV_Processor_lib;
USE RISCV_Processor_lib.types.ALL;

ENTITY rom IS
   PORT( 
      clk                  : IN     std_logic;
      pc_if                : IN     word_t;
      res_n                : IN     std_logic;
      instruction_word_rom : OUT    word_t
   );

-- Declarations

END rom ;

