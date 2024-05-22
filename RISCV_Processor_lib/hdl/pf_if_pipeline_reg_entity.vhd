-- VHDL Entity RISCV_Processor_lib.pf_if_pipeline_reg.interface
--
-- Created:
--          by - st161569.st161569 (pc043)
--          at - 17:06:55 05/22/24
--
-- Generated by Mentor Graphics' HDL Designer(TM) 2022.3 Built on 14 Jul 2022 at 13:56:12
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;
LIBRARY RISCV_Processor_lib;
USE RISCV_Processor_lib.types.ALL;

ENTITY pf_if_pipeline_reg IS
   PORT( 
      clk      : IN     std_logic;
      pc_pf    : IN     std_logic_vector (7 DOWNTO 0);
      res_n    : IN     std_logic;
      stall_dc : IN     std_logic;
      pc_if    : OUT    std_logic_vector (7 DOWNTO 0)
   );

-- Declarations

END pf_if_pipeline_reg ;

