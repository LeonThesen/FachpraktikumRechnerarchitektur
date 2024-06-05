-- VHDL Entity RISCV_Processor_lib.decoder.interface
--
-- Created:
--          by - st161569.st161569 (pc043)
--          at - 15:56:54 06/05/24
--
-- Generated by Mentor Graphics' HDL Designer(TM) 2022.3 Built on 14 Jul 2022 at 13:56:12
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;
LIBRARY RISCV_Processor_lib;
USE RISCV_Processor_lib.types.ALL;

ENTITY decoder IS
   PORT( 
      dbta_valid_ex       : IN     boolean;
      instruction_word_dc : IN     word_t;
      mem_mode_ex         : IN     mem_mode_t;
      rd_addr_ex          : IN     register_file_t;
      rd_addr_mem         : IN     register_file_t;
      alu_mode_dc         : OUT    alu_mode_t;
      dbpu_mode_dc        : OUT    dbpu_mode_t;
      fwd_rs1_dc          : OUT    fwd_select_t;
      fwd_rs2_dc          : OUT    fwd_select_t;
      fwd_store_data_dc   : OUT    boolean;
      imm_dc              : OUT    word_t;
      imm_to_alu_dc       : OUT    boolean;
      is_bta              : OUT    boolean;
      mem_mode_dc         : OUT    mem_mode_t;
      rd_addr_dc          : OUT    register_file_t;
      rs1_addr            : OUT    register_file_t;
      rs2_addr            : OUT    register_file_t;
      sbta_valid_dc       : OUT    boolean;
      stall_dc            : OUT    boolean
   );

-- Declarations

END decoder ;

