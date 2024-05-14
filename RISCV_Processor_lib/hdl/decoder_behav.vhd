--
-- VHDL Architecture RISCV_Processor_lib.decoder.behav
--
-- Created:
--          by - st161569.st161569 (pc043)
--          at - 16:20:02 05/08/24
--
-- using Mentor Graphics HDL Designer(TM) 2022.3 Built on 14 Jul 2022 at 13:56:12
--
library RISCV_Processor_lib;
use RISCV_Processor_lib.types.all;
use RISCV_Processor_lib.isa_defines.all;

-- RISCV RV32I Instruction Words: 31 downto 0, Opcode: 6 downto 0
-- Notes: NOP => ADDI x0 := x0, x0

ARCHITECTURE behav OF decoder IS
    signal rs1_addr_int : register_file_t;
    signal rs2_addr_int : register_file_t;
    signal rd_addr_int : register_file_t;
    signal alu_mode_int : alu_mode_t;
    signal imm_to_alu_int : std_logic;
    signal imm_int : word;
BEGIN
    process(all) is 
    begin
        -- Set defaults
        rs1_addr_int <= (others => '0');
        rs2_addr_int <= (others => '0');
        rd_addr_int <= (others => '0');
        alu_mode_int <= NOP_MODE;
        imm_to_alu_int <= '0';
        imm_int <= (others => '0');

        -- Decode; TODO: continue here
        case instruction_word_dc(6 downto 0) is 
            when U_FORMAT_LUI =>
            when U_FORMAT_AUIPC => 
            when J_FORMAT => 
            when B_FORMAT =>
            when R_FORMAT => 
            when I_FORMAT_LOAD => 
            when I_FORMAT_ARITHMETIC => 
                rs1_addr_int <= instruction_word_dc(19 downto 15);
                rd_addr_int <= instruction_word_dc(11 downto 7);
                imm_int <= EXTEND_IMM12_TO_32_BIT & instruction_word_dc(31 downto 20);
                case instruction_word_dc(14 downto 12) is 
                    when ADDI => 
                        alu_mode_int <= ADDI_MODE;
                        imm_to_alu_int <= '1';
                    when others => null;
                end case;
            when I_FORMAT_STORE =>
            when S_FORMAT =>
            when others => null;
        end case;
    end process;

    rs1_addr <= rs1_addr_int;
    rs2_addr <= rs2_addr_int;
    rd_addr_dc <= rd_addr_int;
    alu_mode_dc <= alu_mode_int;
    imm_to_alu_dc <= imm_to_alu_int;
    imm_dc <= imm_int;
END ARCHITECTURE behav;

