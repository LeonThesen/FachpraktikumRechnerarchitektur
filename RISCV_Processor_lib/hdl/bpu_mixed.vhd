--
-- VHDL Architecture RISCV_Processor_lib.bpu.mixed
--
-- Created:
--          by - st161569.st161569 (pc040)
--          at - 17:46:01 07/03/24
--
-- using Mentor Graphics HDL Designer(TM) 2022.3 Built on 14 Jul 2022 at 13:56:12
--
library ieee;
use ieee.std_logic_1164;
library RISCV_Processor_lib;
use RISCV_Processor_lib.types.all;

ARCHITECTURE mixed OF bpu IS
signal btc_raddr : std_logic_vector(BP_K - 1 downto 0);
signal bpb_raddr : std_logic_vector(BP_K - 1 downto 0);
signal tag : std_logic_vector(XLEN - BP_K - 3 downto 0);
signal valid_bit : std_logic_vector(0 downto 0);
signal target_addr : word_t;
signal btc_controls : btc_controls_t;

BEGIN
    btc_valid_bits: entity work.gen_ram
                    generic map(ADDR_WIDTH => BP_K, DATA_WIDTH => 1)
                    port map(clk => clk, raddr => btc_raddr, waddr => btc_controls.waddr, wdata => btc_controls.wdata_valid_bit, we => btc_controls.wena_valid_bit, rdata => valid_bit);
    
    btc_tags: entity work.gen_ram
              generic map(ADDR_WIDTH => BP_K, DATA_WIDTH => XLEN - BP_K - 2)
              port map(clk => clk, raddr => btc_raddr, waddr => btc_controls.waddr, wdata => btc_controls.wdata_tag, we => btc_controls.wena_tag, rdata => tag);
    
    btc_target_addresses: entity work.gen_ram
                          generic map(ADDR_WIDTH => BP_K, DATA_WIDTH => XLEN)
                          port map(clk => clk, raddr => btc_raddr, waddr => btc_controls.waddr, wdata => btc_controls.wdata_target_addr, we => btc_controls.wena_target_addr, rdata => target_addr);

    bpb: entity work.gen_ram
         generic map(ADDR_WIDTH => BP_K, DATA_WIDTH => 2)
         port map(clk => clk, raddr => bpb_raddr, waddr => bpb_controls.waddr, wdata => bpb_controls.wdata, we => bpb_controls.wena, rdata => bpb_state_if);
    

    process(all) is
    begin
        if stall_dc then
            btc_raddr <= pc_pre_if(BP_K + 1 downto 2);
            bpb_raddr <= pc_pre_if(BP_K + 1 downto 2);
        else
            btc_raddr <= pc(BP_K + 1 downto 2);
            bpb_raddr <= pc(BP_K + 1 downto 2);
        end if;
    end process;

    make_prediction: process(all) is
    begin
        jump_predicted_if <= false;
        predicted_target_addr_if <= (others => '0');

        if (tag = pc_pre_if(pc_pre_if'left downto BP_K + 2)) and valid_bit = "1" then
            jump_predicted_if <= true;
            predicted_target_addr_if <= target_addr;
        end if;
    end process make_prediction;

    btc_mux: process(all) is
    begin
        if wrong_jump_prediction_dbpu then
            btc_controls <= btc_controls_dbpu;
        else
            btc_controls <= btc_controls_sbpu;
        end if;
    end process btc_mux;
END ARCHITECTURE mixed;

