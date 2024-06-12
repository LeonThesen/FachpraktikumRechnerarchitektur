--
-- VHDL Architecture RISCV_Processor_lib.addr_calc.behav
--
-- Created:
--          by - st161569.st161569 (pc043)
--          at - 17:55:43 06/12/24
--
-- using Mentor Graphics HDL Designer(TM) 2022.3 Built on 14 Jul 2022 at 13:56:12
--
ARCHITECTURE behav OF addr_calc IS
BEGIN
-- Inputs: ex_out_ex, ex_out_mem, mem_mode_mem     type memory_access_t is (LOAD, STORE, IDLE);
    --type data_width_t is (BYTE, HALFWORD, WORD);
    
    prepare_write: process (all) is
    begin
        be <= (others => '0');
        wdata <= (others => '0');
        waddr <= ex_out_mem(ADDR_WIDTH - 1 downto 2) & "00"; -- Alignment on word boundary
        if mem_mode_mem.memory_access = STORE then
            case mem_mode_mem.data_width is
                when BYTE =>
                    wdata <= store_data(7 downto 0) & store_data(7 downto 0) & store_data(7 downto 0) & store_data(7 downto 0);
                    be <= ((3 - to_integer(unsigned(ex_out_mem(1 downto 0)))) => '1', others => '0');
                when HALFWORD =>
                    if to_integer(unsigned(ex_out_mem(0 downto 0))) /= 0 then
                        report "Error: Unaligned memory access[write]: Trying to write halfword into unaligned address";
                    else
                        wdata <= store_data(7 downto 0) & store_data(15 downto 8) & store_data(7 downto 0) & store_data(15 downto 8);
                        if to_integer(unsigned(ex_out_mem(1 downto 1))) = 1 then
                            be <= (1 downto 0 => '1', others => '0');
                        else
                            be <= (3 downto 2 => '1', others => '0');
                        end if;
                    end if;
                when WORD =>
                    if to_integer(unsigned(ex_out_mem(1 downto 0))) /= 0 then
                        report "Error: Unaligned memory access[write]: Trying to write word into unaligned address";
                    else
                        wdata <= store_data(7 downto 0) & store_data(15 downto 8) & store_data(23 downto 16) & store_data(31 downto 24);
                        be <= (others => '1');
                    end if;
            end case;
        end if;
    end process prepare_write;

    raddr <= ex_out_ex(ADDR_WIDTH - 1 downto 2) & "00";

END ARCHITECTURE behav;

