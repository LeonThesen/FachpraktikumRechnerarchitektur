--
-- VHDL Architecture RISCV_Processor_lib.io_thing.behav
--
-- Created:
--          by - st161569.st161569 (pc043)
--          at - 16:58:09 07/10/24
--
-- using Mentor Graphics HDL Designer(TM) 2022.3 Built on 14 Jul 2022 at 13:56:12
--
library RISCV_Processor_lib;
use RISCV_Processor_lib.types.all;

ARCHITECTURE behav OF io_memory IS
    constant MEMORY_WORD_COUNT : integer := 2**IO_MEM_WIDTH;
    type memory_array_t is array (0 to MEMORY_WORD_COUNT - 1) of word_t;
    signal io_memory : memory_array_t;
BEGIN

    write: process(clk, res_n) is begin
        if res_n = '0' then
            io_memory <= (others => (others => '0'));
        else
            if clk'event and clk = '1' then
                -- buttons
                io_memory(0) <= (others => '0');
                io_memory(0)(0) <= not button_1_out;
                io_memory(1) <= (others => '0');
                io_memory(1)(0) <= not button_2;
                io_memory(2) <= (others => '0');
                io_memory(2)(0) <= not button_3;

                -- switches
                io_memory(3) <= (others => '0');
                io_memory(3)(9 downto 0) <= switches;

                if io_control_cpu.wena then
                    io_memory(to_integer(unsigned(io_control_cpu.waddr))) <= io_wdata_cpu;
                end if;
            end if;
        end if;
    end process write;

    read: process(all) is begin
        io_rdata <= io_memory(to_integer(unsigned(io_control_cpu.raddr)));
    end process read;

    seven_seg_control: process(all) is
    begin
        seven_seg_1 <= not io_memory(4)(6 downto 0);
        seven_seg_2 <= not io_memory(5)(6 downto 0);
        seven_seg_3 <= not io_memory(6)(6 downto 0);
        seven_seg_4 <= not io_memory(7)(6 downto 0);
    end process seven_seg_control;
END ARCHITECTURE behav;

