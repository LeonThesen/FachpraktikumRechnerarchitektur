-- VHDL Entity RISCV_Processor_lib.pc_inc.interface
--
-- Created:
--          by - st161569.st161569 (pc029)
--          at - 16:23:37 05/14/24
--
-- Generated by Mentor Graphics' HDL Designer(TM) 2022.3 Built on 14 Jul 2022 at 13:56:12
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;
LIBRARY RISCV_Processor_lib;
USE RISCV_Processor_lib.types.ALL;

ENTITY pc_inc IS
   PORT( 
      pc_if : IN     std_logic_vector (7 DOWNTO 0);
      pc_pf : OUT    std_logic_vector (7 DOWNTO 0)
   );

-- Declarations

END pc_inc ;

