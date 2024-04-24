--
-- VHDL Architecture UPN_Rechner_Lib.op_arbiter.behav
--
-- Created:
--          by - st161569.st161569 (pc043)
--          at - 18:09:40 04/24/24
--
-- using Mentor Graphics HDL Designer(TM) 2022.3 Built on 14 Jul 2022 at 13:56:12
--

LIBRARY UPN_Rechner_Lib;
USE UPN_Rechner_Lib.types.ALL;

ARCHITECTURE behav OF op_arbiter IS
    signal op_reg : operation_type;
    signal determined_op: operation_type;
BEGIN
    determine_operation: process(enter, reset, plus, minus) is 
    begin  
        if reset = '1' then
            determined_op <= RESET;
        elsif enter = '1' then
            determined_op <= ENTER;
        elsif plus = '1' then
            determined_op <= PLUS;
        elsif minus = '1' then
            determined_op <= MINUS;
        else
            determined_op <= NOP;
        end if;
    end process determine_operation;

    save_op: process(clk, res_n) is
    begin 
        if res_n = '0' then
            op_reg <= NOP;
        else
            if clk'event and clk = '1' then
                op_reg <= determined_op;
            end if;
        end if;
    end process save_op;

    operation <= op_reg;
END ARCHITECTURE behav;

