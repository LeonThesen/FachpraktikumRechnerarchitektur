--
-- VHDL Architecture RISCV_Processor_lib.bpu.mixed
--
-- Created:
--          by - st161569.st161569 (pc040)
--          at - 17:46:01 07/03/24
--
-- using Mentor Graphics HDL Designer(TM) 2022.3 Built on 14 Jul 2022 at 13:56:12
--
ARCHITECTURE mixed OF bpu IS
signal btc_read_addr : std_logic_vector(BP_K - 1 downto 0);
signal tag : std_logic_vector(XLEN - BP_K downto 0);
signal valid_bit : std_logic_vector(0 downto 0);
signal target_addr : word_t;
BEGIN
    btc_valid_bits: gen_ram
                    generic map(ADDR_WIDTH => BP_K, DATA_WIDTH => 1)
                    port map(clk => clk, raddr => btc_read_addr, waddr => btc_write_addr, wdata => btc_wdata_valid_bit, we => btc_wena_valid, rdata => );
    
    btc_tags: gen_ram
              generic map(ADDR_WIDTH => BP_K, DATA_WIDTH => XLEN - BP_K)
              port map(clk => clk, raddr => btc_read_addr, waddr => btc_write_addr, wdata => btc_wdata_tag, we => btc_wena_tag);
    
    btc_target_addresses: gen_ram
                          generic map(ADDR_WIDTH => BP_K, DATA_WIDTH => XLEN)
                          port map(clk => clk, raddr => btc_read_addr, waddr => btc_write_addr, wdata => btc_wdata_target_addr, we => btc_wena_target_addr);

    bpb: gen_ram
         generic map(ADDR_WIDTH => BP_K, DATA_WIDTH => 2)
         port map(clk => clk, raddr => bpb_raddr, waddr => bpb_waddr, wdata => bpb_wdata, we => bpb_wena);
    

    process(all) is
    begin
        btc_read_addr <= pc(BP_K - 1 downto 0);
    end process;

    make_prediction: process(all) is
    begin
        jump_predicted_if <= false;
        predicted_target_addr <= (others => '0');

        if (tag = pc(pc'left downto BP_K)) and valid_bit = '1' then
            jump_predicted_if <= true;
            predicted_target_addr <= target_addr;
        end if;
    end process make_prediction;
END ARCHITECTURE mixed;

