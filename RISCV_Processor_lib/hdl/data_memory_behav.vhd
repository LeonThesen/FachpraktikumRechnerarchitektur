--
-- VHDL Architecture RISCV_Processor_lib.data_memory.behav
--
-- Created:
--          by - st161569.st161569 (pc029)
--          at - 13:19:15 05/21/24
--
-- using Mentor Graphics HDL Designer(TM) 2022.3 Built on 14 Jul 2022 at 13:56:12
--
library ieee;
use ieee.numeric_std.all;
library RISCV_Processor_lib;
use RISCV_Processor_lib.types.ALL;

ARCHITECTURE behav OF data_memory IS
    constant MEMORY_WIDTH : integer := 10;
	subtype MEMORY_RANGE is natural range (MEMORY_WIDTH + 1) downto 2;
    constant MEMORY_WORD_COUNT : integer := 2**MEMORY_WIDTH;
    type memory_array_t is array (0 to MEMORY_WORD_COUNT - 1) of word_t;
    signal memory_array : memory_array_t;

    signal data_to_be_written: word_t;
    signal write_enable: std_logic_vector(0 to 3);
BEGIN
    prepare_write: process (ex_out_mem, store_data) is
    begin
        write_enable <= (others => '0');

        if mem_mode_mem.memory_access = STORE then
            case mem_mode_mem.data_width is
                when BYTE =>
                    data_to_be_written <= store_data(7 downto 0) & store_data(7 downto 0) & store_data(7 downto 0) & store_data(7 downto 0);
                    write_enable <= (to_integer(unsigned(ex_out_mem(1 downto 0))) => '1', others => '0');
                when HALFWORD =>
                    if to_integer(unsigned(ex_out_mem(0 downto 0))) = 0 then
                        data_to_be_written <= store_data(7 downto 0) & store_data(15 downto 8) & store_data(7 downto 0) & store_data(15 downto 8);
                        if to_integer(unsigned(ex_out_mem(1 downto 1))) = 1 then
                            write_enable <= (2 to 3 => '1', others => '0');
                        else
                            write_enable <= (0 to 1 => '1', others => '0');
                        end if;
                    end if;
                when WORD =>
                    if to_integer(unsigned(ex_out_mem(1 downto 0))) = 0 then
                        data_to_be_written <= store_data(7 downto 0) & store_data(15 downto 8) & store_data(23 downto 16) & store_data(31 downto 24);
                        write_enable <= (others => '1');
                    end if;
            end case;
        end if;
    end process prepare_write;


    write: process (clk, res_n) is
    begin
        if res_n = '0' then
            memory_array <= (others => (others => '0'));
        else
            if clk'event and clk = '1' then 
                -- Store datum
                for(i in write_enable'range) loop
                    if(write_enable(i) = '1') then
                        memory_array(ex_out_mem(MEMORY_RANGE))(i * 8 + 7 downto i * 8) <= data_to_be_written(i * 8 + 7 downto i * 8);
                    end if;
                end loop;
            end if;
        end if;
    end process write;

    -- Memory is byte addressable but we need to able to read word, halfword and byte
    read: process(mem_mode_mem, ex_out_mem, memory_array) is
    variable read_word: word_t;
    variable read_halfword: half_word_t;
    variable read_byte: byte_t;
    variable index: integer;
    begin
        if mem_mode_mem.memory_access = LOAD then
            read_word := memory_array(to_integer(unsigned(ex_out_mem(MEMORY_RANGE)))); -- Access is word-aligned
            case mem_mode_mem.data_width is 
                when BYTE =>                    
                    -- Extract the byte from the word
                    index := to_integer(unsigned(ex_out_mem(1 downto 0))); -- 0, 1, 2, 3
                    read_byte := read_word(index * 8 + 7 downto index * 8);
                    -- Sign extension
                    if mem_mode_mem.is_signed then
                        data_memory_result <= (7 downto 0 => read_byte, others => read_byte(read_byte'left));
                    else
                        data_memory_result <= (7 downto 0 => read_byte, others => '0');
                    end if;
                    
                when HALFWORD =>
                    if to_integer(unsigned(ex_out_mem(0 downto 0))) /= 0 then
                        report "Error: Unaligned memory access[read]: Trying to read halfword from unaligned address";
                    end if;

                    -- Extract the halfword from the word
                    index := to_integer(unsigned(ex_out_mem(1 downto 1))); -- 0, 1
                    read_halfword := memory_array(16 * index + 15 downto 16*index);
                    if mem_mode_mem.is_signed then
                        data_memory_result <= (15 downto 0 => read_halfword, others => read_halfword(read_halfword'left));
                    else
                        data_memory_result <= (15 downto 0 => read_halfword, others => '0');
                    end if;

                when WORD =>
                    -- TODO: fix this, what is this for?
                    if to_integer(unsigned(ex_out_mem(1 downto 0))) /= 0 then
                        report "Error: Unaligned memory access[read]: Trying to read word from unaligned address";
                    end if;

                    data_memory_result <= read_word;

                when others =>
                    data_memory_result <= (others => '1'); -- TODO: Change this, this is an error case
            end case;
        else
            data_memory_result <= (others => '1'); -- TODO: Change this, this is an error case
        end if;
    end process read;
END ARCHITECTURE behav
