-- VHDL Entity RISCV_Processor_lib.addr_width_reducer.interface
--
-- Created:
--          by - st161569.st161569 (pc043)
--          at - 16:38:03 06/19/24
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

ENTITY addr_width_reducer IS
   PORT( 
      pc       : IN     word_t;
      rom_addr : OUT    std_logic_vector (ADDR_WIDTH - 1 DOWNTO 0)
   );

-- Declarations

END addr_width_reducer ;

