-- VHDL Entity RISCV_Processor_lib.io.interface
--
-- Created:
--          by - st161569.st161569 (pc043)
--          at - 16:21:05 07/11/24
--
-- Generated by Mentor Graphics' HDL Designer(TM) 2022.3 Built on 14 Jul 2022 at 13:56:12
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;
LIBRARY RISCV_Processor_lib;
USE RISCV_Processor_lib.types.ALL;

ENTITY io IS
   PORT( 
      button_1       : IN     std_logic;
      button_2       : IN     std_logic;
      button_3       : IN     std_logic;
      clk            : IN     std_logic;
      io_control_cpu : IN     io_control_t;
      io_wdata_cpu   : IN     word_t;
      res_n          : IN     std_logic;
      switches       : IN     std_logic_vector (9 DOWNTO 0);
      io_rdata       : OUT    word_t;
      seven_seg_1    : OUT    std_logic_vector (6 DOWNTO 0);
      seven_seg_2    : OUT    std_logic_vector (6 DOWNTO 0);
      seven_seg_3    : OUT    std_logic_vector (6 DOWNTO 0);
      seven_seg_4    : OUT    std_logic_vector (6 DOWNTO 0)
   );

-- Declarations

END io ;

