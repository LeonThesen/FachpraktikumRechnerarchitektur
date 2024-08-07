-- VHDL Entity RISCV_Processor_lib.io_pin_gen.interface
--
-- Created:
--          by - st161569.st161569 (pc043)
--          at - 16:25:42 07/11/24
--
-- Generated by Mentor Graphics' HDL Designer(TM) 2022.3 Built on 14 Jul 2022 at 13:56:12
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;

ENTITY io_pin_gen IS
   PORT( 
      res_n    : IN     std_logic;
      button_1 : OUT    std_logic;
      button_2 : OUT    std_logic;
      button_3 : OUT    std_logic;
      switches : OUT    std_logic_vector (9 DOWNTO 0)
   );

-- Declarations

END io_pin_gen ;

