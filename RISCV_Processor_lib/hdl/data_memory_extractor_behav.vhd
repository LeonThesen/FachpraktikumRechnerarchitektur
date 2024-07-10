--
-- VHDL Architecture RISCV_Processor_lib.data_memory_extractor.behav
--
-- Created:
--          by - st161569.st161569 (pc043)
--          at - 17:55:31 06/12/24
--
-- using Mentor Graphics HDL Designer(TM) 2022.3 Built on 14 Jul 2022 at 13:56:12
--
ARCHITECTURE behav OF data_memory_extractor IS
BEGIN
    -- Memory is byte addressable but we need to able to read word, halfword and byte
    extract: process(all) is
    variable read_halfword: half_word_t;
    variable read_byte: byte_t;
    variable index: integer;
    begin
        ram_result <= (others => '0');
        if mem_mode_mem.memory_access = LOAD then                   
            case mem_mode_mem.data_width is 
                when BYTE =>
                    -- Extract the byte from the word
                    index := to_integer(unsigned(ex_out_mem(1 downto 0))); -- 0, 1, 2, 3
                    read_byte := rdata(31 - (index * 8) downto 24 - (index * 8));
                    -- Sign extension
                    if mem_mode_mem.is_signed then
                        ram_result <= (others => read_byte(read_byte'left));
                        ram_result(7 downto 0) <= read_byte;
                    else
                        ram_result <= (others => '0');
                        ram_result(7 downto 0) <= read_byte;
                    end if;                  
                when HALFWORD =>
                    if to_integer(unsigned(ex_out_mem(0 downto 0))) /= 0 then
                        report "Error: Unaligned memory access[read]: Trying to read halfword from unaligned address";
                    else
                        -- Extract the halfword from the word
                        index := to_integer(unsigned(ex_out_mem(1 downto 1))); -- 0, 1
                        read_halfword := rdata(31 - (16 * index) downto 16 - (16 * index));
                        if mem_mode_mem.is_signed then
                            ram_result <= (others => read_halfword(read_halfword'left));
                            ram_result(7 downto 0) <= read_halfword(15 downto 8);
                            ram_result(15 downto 8) <= read_halfword(7 downto 0);
                        else
                            ram_result <= (others => '0');
                            ram_result(7 downto 0) <= read_halfword(15 downto 8);
                            ram_result(15 downto 8) <= read_halfword(7 downto 0);
                        end if;
                    end if;
                when WORD =>
                    if to_integer(unsigned(ex_out_mem(1 downto 0))) /= 0 then
                        report "Error: Unaligned memory access[read]: Trying to read word from unaligned address";
                    else
                        ram_result <= rdata(7 downto 0) & rdata(15 downto 8) & rdata(23 downto 16) & rdata(31 downto 24);
                    end if;
            end case;
        end if;
    end process extract;
END ARCHITECTURE behav;

