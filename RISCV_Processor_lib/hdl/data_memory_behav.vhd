--
-- VHDL Architecture RISCV_Processor_lib.data_memory.behav
--
-- Created:
--          by - st161569.st161569 (pc029)
--          at - 13:19:15 05/21/24
--
-- using Mentor Graphics HDL Designer(TM) 2022.3 Built on 14 Jul 2022 at 13:56:12
--
ARCHITECTURE behav OF data_memory IS
    constant MEMORY_WORD_COUNT : positive := 2**10;
    type memory_array_t is array (0 to MEMORY_WORD_COUNT - 1) of byte_t;
    signal memory_array : memory_array_t;
BEGIN
    write: process (clk, res_n) is 
    begin
        if res_n = '0' then
            memory_array <= (others => (others => '0'));
        else
            if clk'event and clk = '1' then 
                -- Store datum
                if to_integer(unsigned(alu_result_mem)) < MEMORY_WORD_COUNT and to_integer(unsigned(alu_result_mem)) > -1 and mem_mode_mem.memory_access = STORE then
                    case mem_mode_mem.data_width is 
                        when BYTE =>
                            memory_array(to_integer(unsigned(alu_result_mem))) <= store_data(7 downto 0);
                        when HALFWORD => 
                            memory_array(to_integer(unsigned(alu_result_mem)) + 0) <= store_data(7 downto 0);
                            memory_array(to_integer(unsigned(alu_result_mem)) + 1) <= store_data(15 downto 8);
                        when WORD =>
                            memory_array(to_integer(unsigned(alu_result_mem)) + 0) <= store_data(7 downto 0);
                            memory_array(to_integer(unsigned(alu_result_mem)) + 1) <= store_data(15 downto 8);
                            memory_array(to_integer(unsigned(alu_result_mem)) + 2) <= store_data(23 downto 16);
                            memory_array(to_integer(unsigned(alu_result_mem)) + 3) <= store_data(31 downto 24); 
                        when others => null;
                    end case;
                else
                    null;
                end if;
            end if;
        end if;
    end process write;

    read: process(mem_mode_mem, alu_result_mem, memory_array) is
    variable read_byte: byte_t;
    variable read_halfword: half_word_t;
    begin
        if to_integer(unsigned(alu_result_mem)) < MEMORY_WORD_COUNT and to_integer(unsigned(alu_result_mem)) > -1 and mem_mode_mem.memory_access = LOAD then
            case mem_mode_mem.data_width is 
                when BYTE =>
                    read_byte := memory_array(to_integer(unsigned(alu_result_mem)));
                    if mem_mode_mem.is_signed then
                        data_memory_result <= (7 downto 0 => read_byte, others => read_byte(read_byte'left));
                    else
                        data_memory_result <= (7 downto 0 => read_byte, others => '0');
                    end if;
                when HALFWORD =>
                    read_halfword := memory_array(to_integer(unsigned(alu_result_mem)) + 1) & memory_array(to_integer(unsigned(alu_result_mem)));
                    if mem_mode_mem.is_signed then
                        data_memory_result <= (15 downto 0 => read_halfword, others => read_halfword(read_halfword'left));
                    else
                        data_memory_result <= (15 downto 0 => read_halfword, others => '0');
                    end if;
                when WORD =>
                    data_memory_result <= memory_array(to_integer(unsigned(alu_result_mem)) + 3) &
                                          memory_array(to_integer(unsigned(alu_result_mem)) + 2) &
                                          memory_array(to_integer(unsigned(alu_result_mem)) + 1) &
                                          memory_array(to_integer(unsigned(alu_result_mem)) + 0);
                when others =>
                    data_memory_result <= (others => '1'); -- TODO: Change this, this is an error case
            end case;
        else
            data_memory_result <= (others => '1'); -- TODO: Change this, this is an error case
        end if;
    end process read;
END ARCHITECTURE behav;

