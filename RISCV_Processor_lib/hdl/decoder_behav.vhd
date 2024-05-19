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
        alu_mode_int <= ADDI_MODE;
        imm_to_alu_int <= '0';
        imm_int <= (others => '0');
        rf_wena_dc <= '0';

        -- Decode
        case instruction_word_dc(OPCODE_RANGE) is 
            when U_FORMAT_LUI =>
                rd_addr_int <= instruction_word_dc(RD_RANGE);
                rf_wena_dc <= '1';
                imm_to_alu_int <= '1';
                imm_int <= get_u_format_imm(instruction_word_dc);
            when U_FORMAT_AUIPC => 
            when J_FORMAT => 
            when B_FORMAT =>
            when R_FORMAT => 
                rs1_addr_int <= instruction_word_dc(RS1_RANGE);
                rs2_addr_int <= instruction_word_dc(RS2_RANGE);
                rd_addr_int <= instruction_word_dc(RD_RANGE);
                case instruction_word_dc(FUNCT3_RANGE) is
                    when ADD_INSTR => 
                        alu_mode_int <= ADDI_MODE;
                    when SUB_INSTR =>
                        alu_mode_int <= ADDI_MODE;
                    when SLL_INSTR =>
                        alu_mode_int <= ADDI_MODE;
                    when SLT_INSTR =>
                        alu_mode_int <= ADDI_MODE;
                    when SLTU_INSTR =>
                        alu_mode_int <= ADDI_MODE;
                    when XOR_INSTR =>
                        alu_mode_int <= ADDI_MODE;
                    when SRL_INSTR =>
                        alu_mode_int <= ADDI_MODE;
                    when SRA_INSTR =>
                        alu_mode_int <= ADDI_MODE;
                    when OR_INSTR =>
                        alu_mode_int <= ADDI_MODE;
                    when AND_INSTR =>
                        alu_mode_int <= ADDI_MODE;
                    when others => null;
                end case;
            when I_FORMAT_LOAD =>
                rs1_addr_int <= instruction_word_dc(RS1_RANGE);
                rd_addr_int <= instruction_word_dc(RD_RANGE);
                rf_wena_dc <= '1';
                imm_to_alu_int <= '1';
                imm_int <= get_i_format_imm(instruction_word_dc); 
                case instruction_word_dc(FUNCT3_RANGE) is
                    when LB_INSTR => 
                        alu_mode_int <= ADDI_MODE;
                    when LH_INSTR =>
                        alu_mode_int <= ADDI_MODE;
                    when LW_INSTR =>
                        alu_mode_int <= ADDI_MODE;
                    when LBU_INSTR =>
                        alu_mode_int <= ADDI_MODE;
                    when LHU_INSTR =>
                        alu_mode_int <= ADDI_MODE;
                    when others => null;
                end case;
            when I_FORMAT_ARITHMETIC => 
                rs1_addr_int <= instruction_word_dc(RS1_RANGE);
                rd_addr_int <= instruction_word_dc(RD_RANGE);
                rf_wena_dc <= '1';
                imm_to_alu_int <= '1';
                imm_int <= get_i_format_imm(instruction_word_dc);                
                
                case instruction_word_dc(FUNCT3_RANGE) is 
                    when ADDI_INSTR => 
                        alu_mode_int <= ADDI_MODE;
                    when SLTI_INSTR => 
                        alu_mode_int <= SLTI_MODE;
                    when SLTIU_INSTR => 
                        alu_mode_int <= SLTIU_MODE;
                    when XORI_INSTR => 
                        alu_mode_int <= XORI_MODE;
                    when ORI_INSTR => 
                        alu_mode_int <= ORI_MODE;
                    when ANDI_INSTR => 
                        alu_mode_int <= ANDI_MODE;
                    when SLLI_INSTR => 
                        alu_mode_int <= SLLI_MODE;
                        imm_int <= get_shift_amount(instruction_word_dc);
                    when SRI_INSTR =>
                        imm_int <= get_shift_amount(instruction_word_dc);
                        if instruction_word_dc(I_FORMAT_FUNCT7_RANGE) = "0000000" then
                            alu_mode_int <= SRLI_MODE;
                        elsif instruction_word_dc(I_FORMAT_FUNCT7_RANGE) = "0100000" then
                            alu_mode_int <= SRAI_MODE;
                        else 
                            null; -- TODO: Change me
                        end if;                        
                    when others => null;
                end case;
            when I_FORMAT_JUMP =>
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

