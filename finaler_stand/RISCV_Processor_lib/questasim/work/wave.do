onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -divider General
add wave -noupdate /top_tb/clk
add wave -noupdate /top_tb/res_n
add wave -noupdate -radix binary /top_tb/io_i/seven_seg_1
add wave -noupdate -radix binary /top_tb/io_i/seven_seg_2
add wave -noupdate -radix binary /top_tb/io_i/seven_seg_3
add wave -noupdate -radix binary /top_tb/io_i/seven_seg_4
add wave -noupdate -radix binary /top_tb/io_i/switches
add wave -noupdate /top_tb/io_i/button_1
add wave -noupdate /top_tb/io_i/button_2
add wave -noupdate /top_tb/io_i/button_3
TreeUpdate [SetDefaultTree]
quietly WaveActivateNextPane
add wave -noupdate -divider IF
add wave -noupdate /top_tb/cpu_i/instruction_word_mux_i/instruction_word_if
add wave -noupdate -radix decimal /top_tb/cpu_i/if_dc_pipeline_reg_i/pc_pre_if
add wave -noupdate -radix decimal /top_tb/cpu_i/pc_mux_i/pc
add wave -noupdate /top_tb/cpu_i/pc_mux_i/pc_pf
add wave -noupdate /top_tb/cpu_i/bpu_i/jump_predicted_if
add wave -noupdate /top_tb/cpu_i/bpu_i/bpb_state_if
add wave -noupdate /top_tb/cpu_i/bpu_i/predicted_target_addr_if
add wave -noupdate /top_tb/cpu_i/bpu_i/wrong_jump_prediction_sbpu
add wave -noupdate /top_tb/cpu_i/bpu_i/wrong_jump_prediction_dbpu
TreeUpdate [SetDefaultTree]
quietly WaveActivateNextPane
add wave -noupdate -divider DC
add wave -noupdate /top_tb/cpu_i/decoder_i/instruction_word_dc
add wave -noupdate -radix decimal /top_tb/cpu_i/dc_ex_pipeline_reg_i/pc_dc
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
add wave -noupdate -childformat {{/top_tb/cpu_i/bpu_i/btc_controls_sbpu.wdata_target_addr -radix decimal}} -expand -subitemconfig {/top_tb/cpu_i/bpu_i/btc_controls_sbpu.wdata_target_addr {-height 17 -radix decimal}} /top_tb/cpu_i/bpu_i/btc_controls_sbpu
add wave -noupdate -radix decimal -childformat {{/top_tb/cpu_i/register_file_i/register_array(0) -radix decimal} {/top_tb/cpu_i/register_file_i/register_array(1) -radix decimal} {/top_tb/cpu_i/register_file_i/register_array(2) -radix decimal} {/top_tb/cpu_i/register_file_i/register_array(3) -radix decimal} {/top_tb/cpu_i/register_file_i/register_array(4) -radix decimal} {/top_tb/cpu_i/register_file_i/register_array(5) -radix decimal} {/top_tb/cpu_i/register_file_i/register_array(6) -radix decimal} {/top_tb/cpu_i/register_file_i/register_array(7) -radix decimal} {/top_tb/cpu_i/register_file_i/register_array(8) -radix decimal} {/top_tb/cpu_i/register_file_i/register_array(9) -radix decimal} {/top_tb/cpu_i/register_file_i/register_array(10) -radix decimal} {/top_tb/cpu_i/register_file_i/register_array(11) -radix decimal} {/top_tb/cpu_i/register_file_i/register_array(12) -radix decimal} {/top_tb/cpu_i/register_file_i/register_array(13) -radix decimal} {/top_tb/cpu_i/register_file_i/register_array(14) -radix decimal} {/top_tb/cpu_i/register_file_i/register_array(15) -radix decimal} {/top_tb/cpu_i/register_file_i/register_array(16) -radix decimal} {/top_tb/cpu_i/register_file_i/register_array(17) -radix decimal} {/top_tb/cpu_i/register_file_i/register_array(18) -radix decimal} {/top_tb/cpu_i/register_file_i/register_array(19) -radix decimal} {/top_tb/cpu_i/register_file_i/register_array(20) -radix decimal} {/top_tb/cpu_i/register_file_i/register_array(21) -radix decimal} {/top_tb/cpu_i/register_file_i/register_array(22) -radix decimal} {/top_tb/cpu_i/register_file_i/register_array(23) -radix decimal} {/top_tb/cpu_i/register_file_i/register_array(24) -radix decimal} {/top_tb/cpu_i/register_file_i/register_array(25) -radix decimal} {/top_tb/cpu_i/register_file_i/register_array(26) -radix decimal} {/top_tb/cpu_i/register_file_i/register_array(27) -radix decimal} {/top_tb/cpu_i/register_file_i/register_array(28) -radix decimal} {/top_tb/cpu_i/register_file_i/register_array(29) -radix decimal} {/top_tb/cpu_i/register_file_i/register_array(30) -radix decimal} {/top_tb/cpu_i/register_file_i/register_array(31) -radix decimal}} -expand -subitemconfig {/top_tb/cpu_i/register_file_i/register_array(0) {-height 17 -radix decimal} /top_tb/cpu_i/register_file_i/register_array(1) {-height 17 -radix decimal} /top_tb/cpu_i/register_file_i/register_array(2) {-height 17 -radix decimal} /top_tb/cpu_i/register_file_i/register_array(3) {-height 17 -radix decimal} /top_tb/cpu_i/register_file_i/register_array(4) {-height 17 -radix decimal} /top_tb/cpu_i/register_file_i/register_array(5) {-height 17 -radix decimal} /top_tb/cpu_i/register_file_i/register_array(6) {-height 17 -radix decimal} /top_tb/cpu_i/register_file_i/register_array(7) {-height 17 -radix decimal} /top_tb/cpu_i/register_file_i/register_array(8) {-height 17 -radix decimal} /top_tb/cpu_i/register_file_i/register_array(9) {-height 17 -radix decimal} /top_tb/cpu_i/register_file_i/register_array(10) {-height 17 -radix decimal} /top_tb/cpu_i/register_file_i/register_array(11) {-height 17 -radix decimal} /top_tb/cpu_i/register_file_i/register_array(12) {-height 17 -radix decimal} /top_tb/cpu_i/register_file_i/register_array(13) {-height 17 -radix decimal} /top_tb/cpu_i/register_file_i/register_array(14) {-height 17 -radix decimal} /top_tb/cpu_i/register_file_i/register_array(15) {-height 17 -radix decimal} /top_tb/cpu_i/register_file_i/register_array(16) {-height 17 -radix decimal} /top_tb/cpu_i/register_file_i/register_array(17) {-height 17 -radix decimal} /top_tb/cpu_i/register_file_i/register_array(18) {-height 17 -radix decimal} /top_tb/cpu_i/register_file_i/register_array(19) {-height 17 -radix decimal} /top_tb/cpu_i/register_file_i/register_array(20) {-height 17 -radix decimal} /top_tb/cpu_i/register_file_i/register_array(21) {-height 17 -radix decimal} /top_tb/cpu_i/register_file_i/register_array(22) {-height 17 -radix decimal} /top_tb/cpu_i/register_file_i/register_array(23) {-height 17 -radix decimal} /top_tb/cpu_i/register_file_i/register_array(24) {-height 17 -radix decimal} /top_tb/cpu_i/register_file_i/register_array(25) {-height 17 -radix decimal} /top_tb/cpu_i/register_file_i/register_array(26) {-height 17 -radix decimal} /top_tb/cpu_i/register_file_i/register_array(27) {-height 17 -radix decimal} /top_tb/cpu_i/register_file_i/register_array(28) {-height 17 -radix decimal} /top_tb/cpu_i/register_file_i/register_array(29) {-height 17 -radix decimal} /top_tb/cpu_i/register_file_i/register_array(30) {-height 17 -radix decimal} /top_tb/cpu_i/register_file_i/register_array(31) {-height 17 -radix decimal}} /top_tb/cpu_i/register_file_i/register_array
TreeUpdate [SetDefaultTree]
quietly WaveActivateNextPane
add wave -noupdate -divider EX
add wave -noupdate -radix decimal /top_tb/cpu_i/dc_ex_pipeline_reg_i/pc_ex
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
add wave -noupdate /top_tb/cpu_i/dbpu_i/dbta
add wave -noupdate /top_tb/cpu_i/dbpu_i/dbta_valid_ex
add wave -noupdate /top_tb/cpu_i/dbpu_i/is_return_addr
add wave -noupdate /top_tb/cpu_i/ex_out_mux_i/ex_out_ex
add wave -noupdate -childformat {{/top_tb/cpu_i/bpu_i/bpb_controls.wdata -radix binary}} -expand -subitemconfig {/top_tb/cpu_i/bpu_i/bpb_controls.wdata {-height 17 -radix binary}} /top_tb/cpu_i/bpu_i/bpb_controls
add wave -noupdate -expand /top_tb/cpu_i/bpu_i/btc_controls_dbpu
TreeUpdate [SetDefaultTree]
quietly WaveActivateNextPane
add wave -noupdate -divider MEM
add wave -noupdate -radix decimal /top_tb/cpu_i/ex_mem_pipeline_reg_i/ex_out_mem
add wave -noupdate /top_tb/cpu_i/ex_mem_pipeline_reg_i/fwd_store_data_mem
add wave -noupdate /top_tb/cpu_i/ex_mem_pipeline_reg_i/mem_mode_mem
add wave -noupdate /top_tb/cpu_i/ex_mem_pipeline_reg_i/rd_addr_mem
add wave -noupdate /top_tb/cpu_i/ex_mem_pipeline_reg_i/rs2_mem
add wave -noupdate -radix decimal /top_tb/cpu_i/mem_wb_pipeline_reg_i/mem_result_mem
add wave -noupdate /top_tb/io_i/io_wdata_cpu
add wave -noupdate -expand /top_tb/io_i/io_control_cpu
add wave -noupdate /top_tb/io_i/io_rdata
add wave -noupdate /top_tb/cpu_i/io_ram_mux_i/data_memory_result
add wave -noupdate /top_tb/cpu_i/io_ram_mux_i/ram_result
add wave -noupdate /top_tb/cpu_i/io_ram_mux_i/is_io_access
TreeUpdate [SetDefaultTree]
quietly WaveActivateNextPane
add wave -noupdate -divider WB
add wave -noupdate -radix decimal /top_tb/cpu_i/mem_wb_pipeline_reg_i/mem_result_wb
add wave -noupdate /top_tb/cpu_i/mem_wb_pipeline_reg_i/rd_addr_wb
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {1290 ns} 0}
quietly wave cursor active 1
configure wave -namecolwidth 167
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
WaveRestoreZoom {1132 ns} {1312 ns}
