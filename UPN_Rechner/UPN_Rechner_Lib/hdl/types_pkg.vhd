--
-- VHDL Package Header UPN_Rechner_Lib.types
--
-- Created:
--          by - st161569.st161569 (pc043)
--          at - 17:46:07 04/24/24
--
-- using Mentor Graphics HDL Designer(TM) 2022.3 Built on 14 Jul 2022 at 13:56:12
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
PACKAGE types IS
    type operation_type is (NOP, PLUS, MINUS, RESET, ENTER); 
END types;
