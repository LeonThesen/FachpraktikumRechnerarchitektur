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
    variable rs1_address_int : register_file_t;
    variable rs2_address_int : register_file_t;
    variable rd_address_int : register_file_t
    variable alu_mode_int : alu_mode_t;
    variable imm_to_alu_dc : immediate_11_t;
BEGIN
    process(all) is 
    begin
        -- Set defaults
        rs1_address_int <= (others => '0');
        rs2_address_int <= (others => '0');
        rd_address_int <= (others => '0');
        alu_mode_int <= NOP_MODE;
        imm_to_alu_dc <= (others => '0');

        -- Decode; TODO: continue here
        case opcode_dc(6 downto 0) is 
            when U_FORMAT_LUI =>
            when U_FORMAT_AUIPC => 
            when J_FORMAT => 
            when B_FORMAT =>
            when R_FORMAT => 
            when I_FORMAT_LOAD => 
            when I_FORMAT_ARITHMETIC => 
                rs1_address_int <= opcode_dc(19 downto 15);
                rd_address_int <= opcode_dc(11 downto 7);
                imm_to_alu_dc <= opcode_dc(31 downto 20);
                case opcode_dc(14 downto 12) is 
                    when ADDI => alu_mode_int <= ADDI_MODE;
                end case;
            when I_FORMAT_STORE =>
            when S_FORMAT => 
        end case;
    end process;

    rs1_address <= rs1_address_int;
    rs2_address <= rs2_address_int;
    rd_address_dc <= rd_address_int;
    alu_mode_dc <= alu_mode_int;
END ARCHITECTURE behav;

