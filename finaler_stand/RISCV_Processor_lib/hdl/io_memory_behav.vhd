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
                io_memory(0)(0) <= not button_1;
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
        case to_integer(unsigned(io_memory(4)(6 downto 0))) is
            when 0 => seven_seg_1 <= "1000000"; -- 0
            when 1 => seven_seg_1 <= "1111001"; -- 1
            when 2 => seven_seg_1 <= "0100100"; -- 2
            when 3 => seven_seg_1 <= "0110000"; -- 3
            when 4 => seven_seg_1 <= "0011001"; -- 4
            when 5 => seven_seg_1 <= "0010010"; -- 5
            when 6 => seven_seg_1 <= "0000010"; -- 6
            when 7 => seven_seg_1 <= "1111000"; -- 7
            when 8 => seven_seg_1 <= "0000000"; -- 8
            when 9 => seven_seg_1 <= "0010000"; -- 9
            when 10 => seven_seg_1 <= "0001000"; -- A
            when 11 => seven_seg_1 <= "0000110"; -- B
            when 12 => seven_seg_1 <= "1000110"; -- C
            when 13 => seven_seg_1 <= "0100001"; -- D
            when 14 => seven_seg_1 <= "0000110"; -- E
            when 15 => seven_seg_1 <= "0000111"; -- F
            when 16 => seven_seg_1 <= "0111111"; -- -
            when 17 => seven_seg_1 <= "0001100"; -- P
            when others => seven_seg_1 <= "1111111"; -- Display off (all segments off)
        end case;

        case to_integer(unsigned(io_memory(5)(6 downto 0))) is
            when 0 => seven_seg_2 <= "1000000"; -- 0
            when 1 => seven_seg_2 <= "1111001"; -- 1
            when 2 => seven_seg_2 <= "0100100"; -- 2
            when 3 => seven_seg_2 <= "0110000"; -- 3
            when 4 => seven_seg_2 <= "0011001"; -- 4
            when 5 => seven_seg_2 <= "0010010"; -- 5
            when 6 => seven_seg_2 <= "0000010"; -- 6
            when 7 => seven_seg_2 <= "1111000"; -- 7
            when 8 => seven_seg_2 <= "0000000"; -- 8
            when 9 => seven_seg_2 <= "0010000"; -- 9
            when 10 => seven_seg_2 <= "0001000"; -- A
            when 11 => seven_seg_2 <= "0000110"; -- B
            when 12 => seven_seg_2 <= "1000110"; -- C
            when 13 => seven_seg_2 <= "0100001"; -- D
            when 14 => seven_seg_2 <= "0000110"; -- E
            when 15 => seven_seg_2 <= "0000111"; -- F
            when 16 => seven_seg_2 <= "0111111"; -- -
            when 17 => seven_seg_2 <= "0001100"; -- P
            when others => seven_seg_2 <= "1111111"; -- Display off (all segments off)
        end case;

        case to_integer(unsigned(io_memory(6)(6 downto 0))) is
            when 0 => seven_seg_3 <= "1000000"; -- 0
            when 1 => seven_seg_3 <= "1111001"; -- 1
            when 2 => seven_seg_3 <= "0100100"; -- 2
            when 3 => seven_seg_3 <= "0110000"; -- 3
            when 4 => seven_seg_3 <= "0011001"; -- 4
            when 5 => seven_seg_3 <= "0010010"; -- 5
            when 6 => seven_seg_3 <= "0000010"; -- 6
            when 7 => seven_seg_3 <= "1111000"; -- 7
            when 8 => seven_seg_3 <= "0000000"; -- 8
            when 9 => seven_seg_3 <= "0010000"; -- 9
            when 10 => seven_seg_3 <= "0001000"; -- A
            when 11 => seven_seg_3 <= "0000110"; -- B
            when 12 => seven_seg_3 <= "1000110"; -- C
            when 13 => seven_seg_3 <= "0100001"; -- D
            when 14 => seven_seg_3 <= "0000110"; -- E
            when 15 => seven_seg_3 <= "0000111"; -- F
            when 16 => seven_seg_3 <= "0111111"; -- -
            when 17 => seven_seg_3 <= "0001100"; -- P
            when others => seven_seg_3 <= "1111111"; -- Display off (all segments off)
        end case;

        case to_integer(unsigned(io_memory(7)(6 downto 0))) is
            when 0 => seven_seg_4 <= "1000000"; -- 0
            when 1 => seven_seg_4 <= "1111001"; -- 1
            when 2 => seven_seg_4 <= "0100100"; -- 2
            when 3 => seven_seg_4 <= "0110000"; -- 3
            when 4 => seven_seg_4 <= "0011001"; -- 4
            when 5 => seven_seg_4 <= "0010010"; -- 5
            when 6 => seven_seg_4 <= "0000010"; -- 6
            when 7 => seven_seg_4 <= "1111000"; -- 7
            when 8 => seven_seg_4 <= "0000000"; -- 8
            when 9 => seven_seg_4 <= "0010000"; -- 9
            when 10 => seven_seg_4 <= "0001000"; -- A
            when 11 => seven_seg_4 <= "0000110"; -- B
            when 12 => seven_seg_4 <= "1000110"; -- C
            when 13 => seven_seg_4 <= "0100001"; -- D
            when 14 => seven_seg_4 <= "0000110"; -- E
            when 15 => seven_seg_4 <= "0000111"; -- F
            when 16 => seven_seg_4 <= "0111111"; -- -
            when 17 => seven_seg_4 <= "0001100"; -- P
            when others => seven_seg_4 <= "1111111"; -- Display off (all segments off)
        end case;

        end process seven_seg_control;
END ARCHITECTURE behav;

