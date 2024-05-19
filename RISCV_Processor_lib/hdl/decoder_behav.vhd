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
            when U_FORMAT_LUI | U_FORMAT_AUIPC =>
                rd_addr_int <= instruction_word_dc(RD_RANGE);
                rf_wena_dc <= '1';
                imm_to_alu_int <= '1';
                imm_int <= get_u_format_imm(instruction_word_dc);
                alu_mode_int <= LUI_MODE;
            when U_FORMAT_AUIPC =>
                rd_addr_int <= instruction_word_dc(RD_RANGE);
                rf_wena_dc <= '1';
                imm_to_alu_int <= '1';
                imm_int <= get_u_format_imm(instruction_word_dc);
                alu_mode_int <= AUIPC_MODE; 
            when J_FORMAT =>
                rd_addr_int <= instruction_word_dc(RD_RANGE);
                rf_wena_dc <= '1';
                imm_to_alu_int <= '1';
                imm_int <= get_j_format_imm(instruction_word_dc);
                alu_mode_int <= JAL_MODE;  
            when B_FORMAT =>
                rs1_addr_int <= instruction_word_dc(RS1_RANGE);
                rs2_addr_int <= instruction_word_dc(RS2_RANGE);
                imm_to_alu_int <= '1';
                imm_int <= get_b_format_imm(instruction_word_dc);
                case instruction_word_dc(FUNCT3_RANGE) is
                    when BEQ_INSTR =>
                        alu_mode_int <= BEQ_MODE;
                    when BNE_INSTR =>
                        alu_mode_int <= BNE_MODE;
                    when BLT_INSTR =>
                        alu_mode_int <= BLT_MODE;
                    when BGE_INSTR =>
                        alu_mode_int <= BGE_MODE;
                    when BLTU_INSTR =>
                        alu_mode_int <= BLTU_MODE;
                    when BGEU_INSTR =>
                        alu_mode_int <= BGEU_MODE;
                end case;
            when R_FORMAT => 
                rs1_addr_int <= instruction_word_dc(RS1_RANGE);
                rs2_addr_int <= instruction_word_dc(RS2_RANGE);
                rd_addr_int <= instruction_word_dc(RD_RANGE);
                rf_wena_dc <= '1';
                case instruction_word_dc(FUNCT3_RANGE) is
                    when ADD_SUB_INSTR => 
                        if instruction_word_dc(R_FORMAT_FUNCT7_RANGE) = ADD_INSTR_FUNCT7 then
                            alu_mode_int <= ADD_MODE;
                        elsif instruction_word_dc(R_FORMAT_FUNCT7_RANGE) = SUB_INSTR_FUNCT7 then
                            alu_mode_int <= SUB_MODE;
                        else 
                            null;
                        end if; 
                    when SLL_INSTR =>
                        alu_mode_int <= SLL_MODE;
                    when SLT_INSTR =>
                        alu_mode_int <= SLT_MODE;
                    when SLTU_INSTR =>
                        alu_mode_int <= SLTU_MODE;
                    when XOR_INSTR =>
                        alu_mode_int <= XOR_MODE;
                    when SRL_INSTR =>
                        alu_mode_int <= SRL_MODE;
                    when SRA_INSTR =>
                        alu_mode_int <= SRA_MODE;
                    when OR_INSTR =>
                        alu_mode_int <= OR_MODE;
                    when AND_INSTR =>
                        alu_mode_int <= AND_MODE;
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
                        alu_mode_int <= LB_MODE;
                    when LH_INSTR =>
                        alu_mode_int <= LH_MODE;
                    when LW_INSTR =>
                        alu_mode_int <= LW_MODE;
                    when LBU_INSTR =>
                        alu_mode_int <= LBU_MODE;
                    when LHU_INSTR =>
                        alu_mode_int <= LHU_MODE;
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
                        if instruction_word_dc(I_FORMAT_FUNCT7_RANGE) = SRL_INSTR_FUNCT7 then
                            alu_mode_int <= SRLI_MODE;
                        elsif instruction_word_dc(I_FORMAT_FUNCT7_RANGE) = SRA_INSTR_FUNCT7 then
                            alu_mode_int <= SRAI_MODE;
                        else 
                            null;
                        end if;                        
                    when others => null;
                end case;
            when I_FORMAT_JUMP =>
                rs1_addr_int <= instruction_word_dc(RS1_RANGE);
                rs2_addr_int <= instruction_word_dc(RS2_RANGE);
                rd_addr_int <= instruction_word_dc(RD_RANGE);
                rf_wena_dc <= '1';
                imm_to_alu_int <= '1';
                imm_int <= get_i_format_imm(instruction_word_dc);
                alu_mode_int <= JALR_MODE;   
            when S_FORMAT =>
                rs1_addr_int <= instruction_word_dc(RS1_RANGE);
                rs2_addr_int <= instruction_word_dc(RS2_RANGE);
                imm_to_alu_int <= '1';
                imm_int <= get_s_format_imm(instruction_word_dc);
                case instruction_word_dc(FUNCT3_RANGE) is 
                    when SB_INSTR => 
                        alu_mode_int <= SB_MODE;
                    when SH_INSTR =>
                        alu_mode_int <= SH_MODE;
                    when SW_INSTR =>
                        alu_mode_int <= SW_MODE;
                    when others => null;
                end case;
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

