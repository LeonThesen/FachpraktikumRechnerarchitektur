-- VHDL Entity RISCV_Processor_lib.ex_mem_pipeline_reg.interface
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

ENTITY ex_mem_pipeline_reg IS
   PORT( 
      clk                : IN     std_logic;
      ex_out_ex          : IN     word_t;
      fwd_store_data_ex  : IN     boolean;
      mem_mode_ex        : IN     mem_mode_t;
      rd_addr_ex         : IN     register_file_t;
      res_n              : IN     std_logic;
      rs2_fwd_mux_out    : IN     word_t;
      ex_out_mem         : OUT    word_t;
      fwd_store_data_mem : OUT    boolean;
      mem_mode_mem       : OUT    mem_mode_t;
      rd_addr_mem        : OUT    register_file_t;
      rs2_mem            : OUT    word_t
   );

-- Declarations

END ex_mem_pipeline_reg ;

