--
-- VHDL Architecture RISCV_Processor_lib.latency.behav
--
-- Created:
--          by - st161569.st161569 (pc043)
--          at - 17:34:52 07/15/24
--
-- using Mentor Graphics HDL Designer(TM) 2022.3 Built on 14 Jul 2022 at 13:56:12
--
ARCHITECTURE behav OF latency IS
    signal start_counting : boolean;
    signal stop_counting : boolean;
BEGIN

    process(all) is
    begin
        if not start_counting and divider_control_ex.start then
            start_counting <= true;
            stop_counting <= false;
        end if;

        if not stop_counting and division_done then
            start_counting <= false;
            stop_counting <= true;
        end if;
    end process;

    process(clk) is
        variable count : positive := 0;
        variable divide_count : positive := 0;
    begin
        if rising_edge(clk) then
            if start_counting then
                count := count + 1;
            end if;
            if stop_counting then
                report "Num: " integer'image(divide_count) & "Latency: " & integer'image(count);
                count := 0;
            end if;
        end if;
    end process;

END ARCHITECTURE behav;

