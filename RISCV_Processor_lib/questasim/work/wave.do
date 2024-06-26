onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -divider General
add wave -noupdate /top_tb/clk
add wave -noupdate /top_tb/res_n
TreeUpdate [SetDefaultTree]
quietly WaveActivateNextPane
add wave -noupdate -divider IF
add wave -noupdate /top_tb/cpu_i/instruction_word_mux_i/instruction_word_if
add wave -noupdate /top_tb/cpu_i/if_dc_pipeline_reg_i/pc_pre_if
add wave -noupdate /top_tb/cpu_i/pc_mux_i/pc
add wave -noupdate /top_tb/cpu_i/pc_mux_i/pc_pf
TreeUpdate [SetDefaultTree]
quietly WaveActivateNextPane
add wave -noupdate -divider DC
add wave -noupdate /top_tb/cpu_i/dc_ex_pipeline_reg_i/pc_dc
add wave -noupdate /top_tb/cpu_i/decoder_i/instruction_word_dc
add wave -noupdate /top_tb/cpu_i/decoder_i/alu_mode_dc
add wave -noupdate /top_tb/cpu_i/decoder_i/dbpu_mode_dc
add wave -noupdate /top_tb/cpu_i/decoder_i/fwd_rs1_dc
add wave -noupdate /top_tb/cpu_i/decoder_i/fwd_rs2_dc
add wave -noupdate /top_tb/cpu_i/decoder_i/fwd_store_data_dc
add wave -noupdate /top_tb/cpu_i/decoder_i/imm_dc
add wave -noupdate /top_tb/cpu_i/decoder_i/imm_to_alu_dc
add wave -noupdate /top_tb/cpu_i/decoder_i/is_bta
add wave -noupdate /top_tb/cpu_i/decoder_i/mem_mode_dc
add wave -noupdate /top_tb/cpu_i/decoder_i/rd_addr_dc
add wave -noupdate /top_tb/cpu_i/decoder_i/rs1_addr
add wave -noupdate /top_tb/cpu_i/decoder_i/rs2_addr
add wave -noupdate /top_tb/cpu_i/decoder_i/sbta_valid_dc
add wave -noupdate /top_tb/cpu_i/decoder_i/stall_dc
add wave -noupdate /top_tb/cpu_i/dc_ex_pipeline_reg_i/imm_or_bta_dc
add wave -noupdate /top_tb/cpu_i/bpb_i/wrong_jump_prediction
add wave -noupdate -expand /top_tb/cpu_i/bpb_i/branch_prediction_buffer
add wave -noupdate /top_tb/cpu_i/register_file_i/register_array
TreeUpdate [SetDefaultTree]
quietly WaveActivateNextPane
add wave -noupdate -divider EX
add wave -noupdate /top_tb/cpu_i/dc_ex_pipeline_reg_i/pc_ex
add wave -noupdate /top_tb/cpu_i/dc_ex_pipeline_reg_i/alu_mode_ex
add wave -noupdate /top_tb/cpu_i/dc_ex_pipeline_reg_i/dbpu_mode_ex
add wave -noupdate /top_tb/cpu_i/dc_ex_pipeline_reg_i/fwd_rs1_ex
add wave -noupdate /top_tb/cpu_i/dc_ex_pipeline_reg_i/fwd_rs2_ex
add wave -noupdate /top_tb/cpu_i/dc_ex_pipeline_reg_i/fwd_store_data_ex
add wave -noupdate /top_tb/cpu_i/dc_ex_pipeline_reg_i/imm_or_bta_ex
add wave -noupdate /top_tb/cpu_i/dc_ex_pipeline_reg_i/imm_to_alu_ex
add wave -noupdate /top_tb/cpu_i/dc_ex_pipeline_reg_i/mem_mode_ex
add wave -noupdate /top_tb/cpu_i/dc_ex_pipeline_reg_i/rd_addr_ex
add wave -noupdate /top_tb/cpu_i/dc_ex_pipeline_reg_i/rs1_ex
add wave -noupdate /top_tb/cpu_i/dc_ex_pipeline_reg_i/rs2_ex
add wave -noupdate /top_tb/cpu_i/alu_i/operand_a
add wave -noupdate /top_tb/cpu_i/alu_i/operand_b
add wave -noupdate /top_tb/cpu_i/rs2_fwd_mux_i/rs2_fwd_mux_out
add wave -noupdate /top_tb/cpu_i/alu_i/alu_flags
add wave -noupdate /top_tb/cpu_i/dbpu_i/alu_result_ex
add wave -noupdate /top_tb/cpu_i/dbpu_i/dbta
add wave -noupdate /top_tb/cpu_i/dbpu_i/dbta_valid_ex
add wave -noupdate /top_tb/cpu_i/dbpu_i/is_return_addr
add wave -noupdate /top_tb/cpu_i/ex_out_mux_i/ex_out_ex
add wave -noupdate /top_tb/cpu_i/bpb_i/jump_predicted_ex
TreeUpdate [SetDefaultTree]
quietly WaveActivateNextPane
add wave -noupdate -divider MEM
add wave -noupdate /top_tb/cpu_i/ex_mem_pipeline_reg_i/ex_out_mem
add wave -noupdate /top_tb/cpu_i/ex_mem_pipeline_reg_i/fwd_store_data_mem
add wave -noupdate /top_tb/cpu_i/ex_mem_pipeline_reg_i/mem_mode_mem
add wave -noupdate /top_tb/cpu_i/ex_mem_pipeline_reg_i/rd_addr_mem
add wave -noupdate /top_tb/cpu_i/ex_mem_pipeline_reg_i/rs2_mem
add wave -noupdate /top_tb/cpu_i/mem_wb_pipeline_reg_i/mem_result_mem
TreeUpdate [SetDefaultTree]
quietly WaveActivateNextPane
add wave -noupdate -divider WB
add wave -noupdate /top_tb/cpu_i/mem_wb_pipeline_reg_i/mem_result_wb
add wave -noupdate /top_tb/cpu_i/mem_wb_pipeline_reg_i/rd_addr_wb
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {508 ns} 0}
quietly wave cursor active 1
configure wave -namecolwidth 168
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 1
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ns
update
WaveRestoreZoom {1746 ns} {1803 ns}
