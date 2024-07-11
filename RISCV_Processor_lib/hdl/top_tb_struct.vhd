--
-- VHDL Architecture RISCV_Processor_lib.top_tb.struct
--
-- Created:
--          by - st161569.st161569 (pc043)
--          at - 17:58:19 07/11/24
--
-- Generated by Mentor Graphics' HDL Designer(TM) 2022.3 Built on 14 Jul 2022 at 13:56:12
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;

LIBRARY RISCV_Processor_lib;

ARCHITECTURE struct OF top_tb IS

   -- Architecture declarations

   -- Internal signal declarations
   SIGNAL button_1 : std_logic;
   SIGNAL button_2 : std_logic;
   SIGNAL button_3 : std_logic;
   SIGNAL clk      : std_logic;
   SIGNAL res_n    : std_logic;
   SIGNAL switches : std_logic_vector(9 DOWNTO 0);


   -- Component Declarations
   COMPONENT clk_res_gen
   PORT (
      clk   : OUT    std_logic ;
      res_n : OUT    std_logic 
   );
   END COMPONENT;
   COMPONENT io_pin_gen
   PORT (
      res_n    : IN     std_logic ;
      button_1 : OUT    std_logic ;
      button_2 : OUT    std_logic ;
      button_3 : OUT    std_logic ;
      switches : OUT    std_logic_vector (9 DOWNTO 0)
   );
   END COMPONENT;
   COMPONENT top
   PORT (
      button_1    : IN     std_logic ;
      button_2    : IN     std_logic ;
      button_3    : IN     std_logic ;
      clk         : IN     std_logic ;
      res_key     : IN     std_logic ;
      switches    : IN     std_logic_vector (9 DOWNTO 0);
      seven_seg_1 : OUT    std_logic_vector (6 DOWNTO 0);
      seven_seg_2 : OUT    std_logic_vector (6 DOWNTO 0);
      seven_seg_3 : OUT    std_logic_vector (6 DOWNTO 0);
      seven_seg_4 : OUT    std_logic_vector (6 DOWNTO 0)
   );
   END COMPONENT;

   -- Optional embedded configurations
   -- pragma synthesis_off
   FOR ALL : clk_res_gen USE ENTITY RISCV_Processor_lib.clk_res_gen;
   FOR ALL : io_pin_gen USE ENTITY RISCV_Processor_lib.io_pin_gen;
   FOR ALL : top USE ENTITY RISCV_Processor_lib.top;
   -- pragma synthesis_on


BEGIN

   -- Instance port mappings.
   clk_res_gen_i : clk_res_gen
      PORT MAP (
         clk   => clk,
         res_n => res_n
      );
   io_pin_gen_i : io_pin_gen
      PORT MAP (
         res_n    => res_n,
         button_1 => button_1,
         button_2 => button_2,
         button_3 => button_3,
         switches => switches
      );
   top_i : top
      PORT MAP (
         button_1    => button_1,
         button_2    => button_2,
         button_3    => button_3,
         clk         => clk,
         res_key     => res_n,
         switches    => switches,
         seven_seg_1 => OPEN,
         seven_seg_2 => OPEN,
         seven_seg_3 => OPEN,
         seven_seg_4 => OPEN
      );

END struct;
