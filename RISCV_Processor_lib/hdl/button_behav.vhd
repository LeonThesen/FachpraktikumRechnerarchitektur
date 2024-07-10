--
-- VHDL Architecture UPN_Rechner_Lib.button.behav
--
-- Created:
--          by - st161569.st161569 (pc043)
--          at - 16:38:02 04/24/24
--
-- using Mentor Graphics HDL Designer(TM) 2022.3 Built on 14 Jul 2022 at 13:56:12
--
ARCHITECTURE behav OF button IS
    type state_type is (IDLE_ST, PULSE_ST, HOLD_OFF_ST);
    signal current_state, next_state: state_type; 
    signal tx_sync: std_logic;
    signal tx_1st: std_logic;
    signal shortened_pulse: std_logic;
BEGIN
    dual_rank_synchronizer: process(clk, res_n) is
    begin 
        if res_n = '0' then
            tx_1st <= '0';
            tx_sync <= '0';
        else 
            if clk'event and clk = '1' then
                tx_1st <= not tx_n;
                tx_sync <= tx_1st;
            end if;
        end if;
    end process dual_rank_synchronizer;


    state: process(clk, res_n) is
    begin
        if res_n = '0' then
            current_state <= IDLE_ST;
        else
            if clk'event and clk = '1' then
                current_state <= next_state;
            end if;
        end if;
    end process state;

    output: process(current_state) is
    begin
        case current_state is
            when IDLE_ST | HOLD_OFF_ST =>
                key <= '0';
            when PULSE_ST =>
                key <= '1';
        end case;
    end process output;

    state_transition: process(current_state, tx_sync) is
    begin
        case current_state is
            when IDLE_ST =>
                if tx_sync = '1' then
                    next_state <= PULSE_ST;
                else
                    next_state <= IDLE_ST;
                end if;
            when PULSE_ST =>
                if tx_sync = '1' then
                    next_state <= HOLD_OFF_ST;
                else
                    next_state <= IDLE_ST;
                end if;
            when HOLD_OFF_ST =>
                if tx_sync = '1' then
                    next_state <= HOLD_OFF_ST;
                else
                    next_state <= IDLE_ST;
                end if;
        end case;
    end process state_transition;
    
END ARCHITECTURE behav;

