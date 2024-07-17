-- VHDL Entity RISCV_Processor_lib.store_data_fwd_mux.interface
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

ENTITY store_data_fwd_mux IS
   PORT( 
      fwd_store_data_mem : IN     boolean;
      mem_result_wb      : IN     word_t;
      rs2_mem            : IN     word_t;
      store_data         : OUT    word_t
   );

-- Declarations

END store_data_fwd_mux ;
