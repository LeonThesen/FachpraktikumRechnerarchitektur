-- VHDL Entity RISCV_Processor_lib.addr_calc.interface
--
-- Created:
--          by - st161569.st161569 (pc043)
--          at - 18:34:21 06/12/24
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

ENTITY addr_calc IS
   PORT( 
      ex_out_ex    : IN     word_t;
      ex_out_mem   : IN     word_t;
      mem_mode_mem : IN     mem_mode_t;
      store_data   : IN     word_t;
      be           : OUT    std_logic_vector (NUM_BYTES - 1 DOWNTO 0);
      raddr        : OUT    std_logic_vector (ADDR_WIDTH - 1 DOWNTO 0);
      waddr        : OUT    std_logic_vector (ADDR_WIDTH - 1 DOWNTO 0);
      wdata        : OUT    std_logic_vector ((NUM_BYTES * BYTE_WIDTH) - 1 DOWNTO 0)
   );

-- Declarations

END addr_calc ;

