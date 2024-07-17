-- VHDL Entity RISCV_Processor_lib.cpu.interface
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

ENTITY cpu IS
   PORT( 
      clk            : IN     std_logic;
      io_rdata       : IN     word_t;
      res_n          : IN     std_logic;
      io_control_cpu : OUT    io_control_t;
      io_wdata_cpu   : OUT    word_t
   );

-- Declarations

END cpu ;

