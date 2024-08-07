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

ARCHITECTURE behav OF decoder IS
    signal rs1_addr_int : register_file_t;
    signal rs2_addr_int : register_file_t;
    signal rd_addr_int : register_file_t;
    signal alu_mode_int : alu_mode_t;
    signal imm_to_alu_int : boolean;
    signal imm_int : word_t;
    signal mem_mode_dc_int : mem_mode_t; 
    signal fwd_rs1_dc_int : fwd_select_t;
    signal fwd_rs2_dc_int : fwd_select_t;
    signal fwd_store_data_dc_int : boolean;
    signal is_bta_int : boolean;
    signal sbta_valid_dc_int : boolean;
    signal dbpu_mode_int : dbpu_mode_t;
    signal stall_dc_int : boolean;
    signal sbpu_mode_int : sbpu_mode_t;
    signal divider_control_int : divider_control_t;
BEGIN

    decode: process(instruction_word_dc) is 
    begin
        -- Set defaults
        rs1_addr_int <= (others => '0');
        rs2_addr_int <= (others => '0');
        rd_addr_int <= (others => '0');
        alu_mode_int <= ADD_MODE;
        imm_to_alu_int <= false;
        imm_int <= (others => '0');
        mem_mode_dc_int.memory_access <= IDLE;
        mem_mode_dc_int.data_width <= WORD;
        mem_mode_dc_int.is_signed <= FALSE;
        is_bta_int <= false;
        sbta_valid_dc_int <= false;
        dbpu_mode_int <= NO_BRANCH;
        sbpu_mode_int <= NO_BRANCH;
        divider_control_int.is_signed <= false;
        divider_control_int.start <= '0';
        divider_control_int.mode <= DIV_MODE;

        -- Decode
        case instruction_word_dc(OPCODE_RANGE) is 
            when U_FORMAT_LUI =>
                rd_addr_int <= instruction_word_dc(RD_RANGE);
                imm_to_alu_int <= true;
                imm_int <= get_u_format_imm(instruction_word_dc);
            when U_FORMAT_AUIPC =>
                rd_addr_int <= instruction_word_dc(RD_RANGE);
                imm_to_alu_int <= true;
                imm_int <= get_u_format_imm(instruction_word_dc);
                is_bta_int <= true;
            when J_FORMAT =>
                rd_addr_int <= instruction_word_dc(RD_RANGE);
                imm_int <= get_j_format_imm(instruction_word_dc);
                is_bta_int <= true;
                sbta_valid_dc_int <= true;
                dbpu_mode_int <= JAL;
                sbpu_mode_int <= JAL;
            when B_FORMAT =>
                rs1_addr_int <= instruction_word_dc(RS1_RANGE);
                rs2_addr_int <= instruction_word_dc(RS2_RANGE);
                imm_int <= get_b_format_imm(instruction_word_dc);
                is_bta_int <= true;
                alu_mode_int <= SUB_MODE;
                case instruction_word_dc(FUNCT3_RANGE) is
                    when BEQ_INSTR =>
                        dbpu_mode_int <= EQUAL;
                    when BNE_INSTR =>
                        dbpu_mode_int <= NOT_EQUAL;
                    when BLT_INSTR =>
                        dbpu_mode_int <= LESS_THAN;
                    when BGE_INSTR =>
                        dbpu_mode_int <= GREATER_OR_EQUAL;
                    when BLTU_INSTR =>
                        dbpu_mode_int <= LESS_THAN_UNSIGNED;
                    when BGEU_INSTR =>
                        dbpu_mode_int <= GREATER_OR_EQUAL_UNSIGNED;
                    when others => 
                        dbpu_mode_int <= NO_BRANCH;
                end case;
            when R_FORMAT => 
                rs1_addr_int <= instruction_word_dc(RS1_RANGE);
                rs2_addr_int <= instruction_word_dc(RS2_RANGE);
                rd_addr_int <= instruction_word_dc(RD_RANGE);

                case instruction_word_dc(R_FORMAT_FUNCT7_RANGE) is
                    when M_EXT_INSTR_FUNCT7 => 
                        case instruction_word_dc(FUNCT3_RANGE) is
                            when MUL_INSTR =>
                                alu_mode_int <= MUL_MODE;
                            when MULH_INSTR =>
                                alu_mode_int <= MULH_MODE;
                            when MULHSU_INSTR =>
                                alu_mode_int <= MULHSU_MODE;
                            when MULHU_INSTR =>
                                alu_mode_int <= MULHU_MODE;
                            when DIV_INSTR =>
                                alu_mode_int <= DIV_MODE;
                                divider_control_int.is_signed <= true;
                                divider_control_int.start <= '1';
                                divider_control_int.mode <= DIV_MODE;
                            when DIVU_INSTR =>
                                alu_mode_int <= DIVU_MODE;
                                divider_control_int.is_signed <= false;
                                divider_control_int.start <= '1';
                                divider_control_int.mode <= DIV_MODE;  
                            when REM_INSTR =>
                                alu_mode_int <= REM_MODE;
                                divider_control_int.is_signed <= true;
                                divider_control_int.start <= '1';
                                divider_control_int.mode <= REM_MODE;
                            when REMU_INSTR =>
                                alu_mode_int <= REMU_MODE;
                                divider_control_int.is_signed <= false;
                                divider_control_int.start <= '1';
                                divider_control_int.mode <= REM_MODE;
                            when others =>
                                null;
                        end case;
                    when others =>
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
                            when SR_INSTR =>
                                if instruction_word_dc(R_FORMAT_FUNCT7_RANGE) = SRL_INSTR_FUNCT7 then
                                    alu_mode_int <= SRL_MODE;
                                elsif instruction_word_dc(R_FORMAT_FUNCT7_RANGE) = SRA_INSTR_FUNCT7 then
                                    alu_mode_int <= SRA_MODE;
                                else 
                                    null;
                                end if; 
                            when OR_INSTR =>
                                alu_mode_int <= OR_MODE;
                            when AND_INSTR =>
                                alu_mode_int <= AND_MODE;
                            when others => null;
                        end case;
                end case;
            when I_FORMAT_LOAD =>
                rs1_addr_int <= instruction_word_dc(RS1_RANGE);
                rd_addr_int <= instruction_word_dc(RD_RANGE);
                imm_to_alu_int <= true;
                imm_int <= get_i_format_imm(instruction_word_dc);
                
                case instruction_word_dc(FUNCT3_RANGE) is
                    when LB_INSTR => 
                        alu_mode_int <= ADD_MODE;
                        mem_mode_dc_int.memory_access <= LOAD;
                        mem_mode_dc_int.data_width <= BYTE;
                        mem_mode_dc_int.is_signed <= TRUE;
                    when LBU_INSTR =>
                        alu_mode_int <= ADD_MODE;
                        mem_mode_dc_int.memory_access <= LOAD;
                        mem_mode_dc_int.data_width <= BYTE;
                        mem_mode_dc_int.is_signed <= FALSE;
                    when LH_INSTR =>
                        alu_mode_int <= ADD_MODE;
                        mem_mode_dc_int.memory_access <= LOAD;
                        mem_mode_dc_int.data_width <= HALFWORD;
                        mem_mode_dc_int.is_signed <= TRUE;
                    when LHU_INSTR =>
                        alu_mode_int <= ADD_MODE;
                        mem_mode_dc_int.memory_access <= LOAD;
                        mem_mode_dc_int.data_width <= HALFWORD;
                        mem_mode_dc_int.is_signed <= FALSE;
                    when LW_INSTR =>
                        alu_mode_int <= ADD_MODE;
                        mem_mode_dc_int.memory_access <= LOAD;
                        mem_mode_dc_int.data_width <= WORD;
                    when others => null;
                end case;
            when I_FORMAT_ARITHMETIC => 
                rs1_addr_int <= instruction_word_dc(RS1_RANGE);
                rd_addr_int <= instruction_word_dc(RD_RANGE);
                imm_to_alu_int <= true;
                imm_int <= get_i_format_imm(instruction_word_dc);

                case instruction_word_dc(FUNCT3_RANGE) is 
                    when ADDI_INSTR =>
                        alu_mode_int <= ADD_MODE;
                    when SLTI_INSTR => 
                        alu_mode_int <= SLT_MODE;
                    when SLTIU_INSTR => 
                        alu_mode_int <= SLTU_MODE;
                    when XORI_INSTR => 
                        alu_mode_int <= XOR_MODE;
                    when ORI_INSTR => 
                        alu_mode_int <= OR_MODE;
                    when ANDI_INSTR => 
                        alu_mode_int <= AND_MODE;
                    when SLLI_INSTR => 
                        alu_mode_int <= SLL_MODE;
                        imm_int <= get_shift_amount(instruction_word_dc);
                    when SRI_INSTR =>
                        imm_int <= get_shift_amount(instruction_word_dc);
                        if instruction_word_dc(I_FORMAT_FUNCT7_RANGE) = SRL_INSTR_FUNCT7 then
                            alu_mode_int <= SRL_MODE;
                        elsif instruction_word_dc(I_FORMAT_FUNCT7_RANGE) = SRA_INSTR_FUNCT7 then
                            alu_mode_int <= SRA_MODE;
                        else 
                            null;
                        end if;                        
                    when others => null;
                end case;
            when I_FORMAT_JUMP =>
                rs1_addr_int <= instruction_word_dc(RS1_RANGE);
                rd_addr_int <= instruction_word_dc(RD_RANGE);
                imm_to_alu_int <= true;
                imm_int <= get_i_format_imm(instruction_word_dc);
                dbpu_mode_int <= JALR;
            when S_FORMAT =>
                rs1_addr_int <= instruction_word_dc(RS1_RANGE);
                rs2_addr_int <= instruction_word_dc(RS2_RANGE);
                imm_to_alu_int <= true;
                imm_int <= get_s_format_imm(instruction_word_dc);
                
                case instruction_word_dc(FUNCT3_RANGE) is 
                    when SB_INSTR => 
                        alu_mode_int <= ADD_MODE;
                        mem_mode_dc_int.memory_access <= STORE;
                        mem_mode_dc_int.data_width <= BYTE;
                    when SH_INSTR =>
                        alu_mode_int <= ADD_MODE;
                        mem_mode_dc_int.memory_access <= STORE;
                        mem_mode_dc_int.data_width <= HALFWORD;
                    when SW_INSTR =>
                        alu_mode_int <= ADD_MODE;
                        mem_mode_dc_int.memory_access <= STORE;
                        mem_mode_dc_int.data_width <= WORD;
                    when others => null;
                end case;
            when others => null;
        end case;
    end process decode;

    forwarding: process(all) is
        variable rs1_ral_detected : boolean;
        variable rs2_ral_detected : boolean;
    begin
        stall_dc_int <= false;
        fwd_store_data_dc_int <= false;

        -- RAW        
        fwd_rs1_dc_int <= determine_rs_fwd_signal(rs1_addr_int, rd_addr_ex, rd_addr_mem);
        fwd_rs2_dc_int <= determine_rs_fwd_signal(rs2_addr_int, rd_addr_ex, rd_addr_mem);

        if mem_mode_ex.memory_access = LOAD then
            rs1_ral_detected := (rs1_addr_int /= X0_REG and rs1_addr_int = rd_addr_ex);
            rs2_ral_detected := (rs2_addr_int /= X0_REG and rs2_addr_int = rd_addr_ex and mem_mode_dc_int.memory_access /= STORE);

            if rs1_ral_detected or rs2_ral_detected then
                -- RAL
                stall_dc_int <= true;
                fwd_rs1_dc_int <= NO_FORWARDING;
                fwd_rs2_dc_int <= NO_FORWARDING;
            elsif mem_mode_dc_int.memory_access = STORE then                        
                if rs2_addr_int = rd_addr_ex and rs2_addr_int /= X0_REG then
                    -- SAL
                    fwd_store_data_dc_int <= true;
                    fwd_rs1_dc_int <= NO_FORWARDING;
                    fwd_rs2_dc_int <= NO_FORWARDING;
                end if;
            end if;
        end if;
    end process forwarding;
   
    set_outputs: process(all) is 
    begin
        rs1_addr <= rs1_addr_int;
        rs2_addr <= rs2_addr_int;
        rd_addr_dc <= rd_addr_int;
        alu_mode_dc <= alu_mode_int;
        imm_to_alu_dc <= imm_to_alu_int;
        imm_dc <= imm_int;
        mem_mode_dc <= mem_mode_dc_int;
        fwd_rs1_dc <= fwd_rs1_dc_int;
        fwd_rs2_dc <= fwd_rs2_dc_int;
        fwd_store_data_dc <= fwd_store_data_dc_int;
        is_bta <= is_bta_int;
        sbta_valid_dc <= sbta_valid_dc_int;
        dbpu_mode_dc <= dbpu_mode_int;
        sbpu_mode_dc <= sbpu_mode_int;
        divider_control_dc <= divider_control_int;

        if divider_control_ex.start then
            if division_done then
                stall_rest_dc <= false;
                stall_dc <= stall_dc_int;
            else
                stall_rest_dc <= true;
                stall_dc <= true;
            end if;
        else
            stall_rest_dc <= false;
            stall_dc <= stall_dc_int;
        end if;

        if stall_dc_int or wrong_jump_prediction_dbpu then
            --alu_mode_dc <= ADD_MODE;
            --rs1_addr <= (others => '0');
            rd_addr_dc <= (others => '0');
            --imm_to_alu_dc <= true;
            --imm_dc <= (others => '0');
            --rs2_addr <= (others => '0');
            mem_mode_dc.memory_access <= IDLE;
            --mem_mode_dc.data_width <= WORD;
            --mem_mode_dc.is_signed <= FALSE;
            dbpu_mode_dc <= NO_BRANCH;
        end if;
    end process set_outputs;
END ARCHITECTURE behav;

