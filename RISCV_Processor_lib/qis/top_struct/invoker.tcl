package require ::quartus::project
set need_to_close_project 0
set make_assignments 1
# Check that the right project is open
if {[is_project_open]} {
   if {[string compare $quartus(project) "top"]} {
      puts "Project top is not open"
      set make_assignments 0
   }
} else {
   # Only open if not already open
   if {[project_exists top]} {
      project_open -revision top top
   } else {
      project_new -revision top top
   }
   set need_to_close_project 1
}

# Make assignments
if {$make_assignments} {
   set_global_assignment -name COMPILER_SETTINGS top
   set_global_assignment -name SIMULATOR_SETTINGS top
   set_global_assignment -name SOFTWARE_SETTINGS top
   set_global_assignment -name FMAX_REQUIREMENT 50MHz
   set_global_assignment -name FAMILY "cyclone v"
   set_global_assignment -name TOP_LEVEL_ENTITY top
   set_global_assignment -name DEVICE 5cgxfc5c6f27c7
   set_global_assignment -name USE_COMPILER_SETTINGS top
	set_global_assignment -name VHDL_FILE "/u/home/clab/st161569/FachpraktikumRechnerarchitektur/RISCV_Processor_lib/hdl/top_entity.vhd" 
	set_global_assignment -name VHDL_FILE "/u/home/clab/st161569/FachpraktikumRechnerarchitektur/RISCV_Processor_lib/hdl/types_pkg.vhd" 
	set_global_assignment -name VHDL_FILE "/u/home/clab/st161569/FachpraktikumRechnerarchitektur/RISCV_Processor_lib/hdl/cpu_entity.vhd" 
	set_global_assignment -name VHDL_FILE "/u/home/clab/st161569/FachpraktikumRechnerarchitektur/RISCV_Processor_lib/hdl/isa_defines_pkg.vhd" 
	set_global_assignment -name VHDL_FILE "/u/home/clab/st161569/FachpraktikumRechnerarchitektur/RISCV_Processor_lib/hdl/isa_defines_pkg_body.vhd" 
	set_global_assignment -name VHDL_FILE "/u/home/clab/st161569/FachpraktikumRechnerarchitektur/RISCV_Processor_lib/hdl/addr_calc_entity.vhd" 
	set_global_assignment -name VHDL_FILE "/u/home/clab/st161569/FachpraktikumRechnerarchitektur/RISCV_Processor_lib/hdl/addr_calc_behav.vhd" 
	set_global_assignment -name VHDL_FILE "/u/home/clab/st161569/FachpraktikumRechnerarchitektur/RISCV_Processor_lib/hdl/addr_width_reducer_entity.vhd" 
	set_global_assignment -name VHDL_FILE "/u/home/clab/st161569/FachpraktikumRechnerarchitektur/RISCV_Processor_lib/hdl/addr_width_reducer_behav.vhd" 
	set_global_assignment -name VHDL_FILE "/u/home/clab/st161569/FachpraktikumRechnerarchitektur/RISCV_Processor_lib/hdl/alu_entity.vhd" 
	set_global_assignment -name VHDL_FILE "/u/home/clab/st161569/FachpraktikumRechnerarchitektur/RISCV_Processor_lib/hdl/alu_behav.vhd" 
	set_global_assignment -name VHDL_FILE "/u/home/clab/st161569/FachpraktikumRechnerarchitektur/RISCV_Processor_lib/hdl/bpu_entity.vhd" 
	set_global_assignment -name VHDL_FILE "/u/home/clab/st161569/FachpraktikumRechnerarchitektur/RISCV_Processor_lib/hdl/gen_ram_entity.vhd" 
	set_global_assignment -name VHDL_FILE "/u/home/clab/st161569/FachpraktikumRechnerarchitektur/RISCV_Processor_lib/hdl/gen_ram_behav.vhd" 
	set_global_assignment -name VHDL_FILE "/u/home/clab/st161569/FachpraktikumRechnerarchitektur/RISCV_Processor_lib/hdl/bpu_mixed.vhd" 
	set_global_assignment -name VHDL_FILE "/u/home/clab/st161569/FachpraktikumRechnerarchitektur/RISCV_Processor_lib/hdl/bta_adder_entity.vhd" 
	set_global_assignment -name VHDL_FILE "/u/home/clab/st161569/FachpraktikumRechnerarchitektur/RISCV_Processor_lib/hdl/bta_adder_behav.vhd" 
	set_global_assignment -name VHDL_FILE "/u/home/clab/st161569/FachpraktikumRechnerarchitektur/RISCV_Processor_lib/hdl/convert_to_big_endian_entity.vhd" 
	set_global_assignment -name VHDL_FILE "/u/home/clab/st161569/FachpraktikumRechnerarchitektur/RISCV_Processor_lib/hdl/convert_to_big_endian_behav.vhd" 
	set_global_assignment -name VHDL_FILE "/u/home/clab/st161569/FachpraktikumRechnerarchitektur/RISCV_Processor_lib/hdl/data_memory_extractor_entity.vhd" 
	set_global_assignment -name VHDL_FILE "/u/home/clab/st161569/FachpraktikumRechnerarchitektur/RISCV_Processor_lib/hdl/data_memory_extractor_behav.vhd" 
	set_global_assignment -name VHDL_FILE "/u/home/clab/st161569/FachpraktikumRechnerarchitektur/RISCV_Processor_lib/hdl/dbpu_entity.vhd" 
	set_global_assignment -name VHDL_FILE "/u/home/clab/st161569/FachpraktikumRechnerarchitektur/RISCV_Processor_lib/hdl/dbpu_behav.vhd" 
	set_global_assignment -name VHDL_FILE "/u/home/clab/st161569/FachpraktikumRechnerarchitektur/RISCV_Processor_lib/hdl/dc_ex_pipeline_reg_entity.vhd" 
	set_global_assignment -name VHDL_FILE "/u/home/clab/st161569/FachpraktikumRechnerarchitektur/RISCV_Processor_lib/hdl/dec_exe_pipeline_reg_behav.vhd" 
	set_global_assignment -name VHDL_FILE "/u/home/clab/st161569/FachpraktikumRechnerarchitektur/RISCV_Processor_lib/hdl/decoder_entity.vhd" 
	set_global_assignment -name VHDL_FILE "/u/home/clab/st161569/FachpraktikumRechnerarchitektur/RISCV_Processor_lib/hdl/decoder_behav.vhd" 
	set_global_assignment -name VHDL_FILE "/u/home/clab/st161569/FachpraktikumRechnerarchitektur/RISCV_Processor_lib/hdl/divider_entity.vhd" 
	set_global_assignment -name VHDL_FILE "/u/home/clab/st161569/FachpraktikumRechnerarchitektur/RISCV_Processor_lib/hdl/radix4_srt_divider.vhd" 
	set_global_assignment -name VHDL_FILE "/u/home/clab/st161569/FachpraktikumRechnerarchitektur/RISCV_Processor_lib/hdl/divider_behav.vhd" 
	set_global_assignment -name VHDL_FILE "/u/home/clab/st161569/FachpraktikumRechnerarchitektur/RISCV_Processor_lib/hdl/ex_mem_pipeline_reg_entity.vhd" 
	set_global_assignment -name VHDL_FILE "/u/home/clab/st161569/FachpraktikumRechnerarchitektur/RISCV_Processor_lib/hdl/ex_mem_pipeline_reg_behav.vhd" 
	set_global_assignment -name VHDL_FILE "/u/home/clab/st161569/FachpraktikumRechnerarchitektur/RISCV_Processor_lib/hdl/ex_out_mux_entity.vhd" 
	set_global_assignment -name VHDL_FILE "/u/home/clab/st161569/FachpraktikumRechnerarchitektur/RISCV_Processor_lib/hdl/ex_out_mux_behav.vhd" 
	set_global_assignment -name VHDL_FILE "/u/home/clab/st161569/FachpraktikumRechnerarchitektur/RISCV_Processor_lib/hdl/gen_ram_be_entity.vhd" 
	set_global_assignment -name VHDL_FILE "/u/home/clab/st161569/FachpraktikumRechnerarchitektur/RISCV_Processor_lib/hdl/gen_ram_be_behav.vhd" 
	set_global_assignment -name VHDL_FILE "/u/home/clab/st161569/FachpraktikumRechnerarchitektur/RISCV_Processor_lib/hdl/gen_rom.vhd" 
	set_global_assignment -name VHDL_FILE "/u/home/clab/st161569/FachpraktikumRechnerarchitektur/RISCV_Processor_lib/hdl/if_dc_pipeline_reg_entity.vhd" 
	set_global_assignment -name VHDL_FILE "/u/home/clab/st161569/FachpraktikumRechnerarchitektur/RISCV_Processor_lib/hdl/if_dc_pipeline_reg_behav.vhd" 
	set_global_assignment -name VHDL_FILE "/u/home/clab/st161569/FachpraktikumRechnerarchitektur/RISCV_Processor_lib/hdl/imm_bta_mux_entity.vhd" 
	set_global_assignment -name VHDL_FILE "/u/home/clab/st161569/FachpraktikumRechnerarchitektur/RISCV_Processor_lib/hdl/imm_bta_mux_behav.vhd" 
	set_global_assignment -name VHDL_FILE "/u/home/clab/st161569/FachpraktikumRechnerarchitektur/RISCV_Processor_lib/hdl/instruction_word_mux_entity.vhd" 
	set_global_assignment -name VHDL_FILE "/u/home/clab/st161569/FachpraktikumRechnerarchitektur/RISCV_Processor_lib/hdl/instruction_word_mux_behav.vhd" 
	set_global_assignment -name VHDL_FILE "/u/home/clab/st161569/FachpraktikumRechnerarchitektur/RISCV_Processor_lib/hdl/io_ram_mux_entity.vhd" 
	set_global_assignment -name VHDL_FILE "/u/home/clab/st161569/FachpraktikumRechnerarchitektur/RISCV_Processor_lib/hdl/io_ram_mux_behav.vhd" 
	set_global_assignment -name VHDL_FILE "/u/home/clab/st161569/FachpraktikumRechnerarchitektur/RISCV_Processor_lib/hdl/mem_mode_mux_entity.vhd" 
	set_global_assignment -name VHDL_FILE "/u/home/clab/st161569/FachpraktikumRechnerarchitektur/RISCV_Processor_lib/hdl/mem_mode_multiplexer_behav.vhd" 
	set_global_assignment -name VHDL_FILE "/u/home/clab/st161569/FachpraktikumRechnerarchitektur/RISCV_Processor_lib/hdl/mem_wb_pipeline_reg_entity.vhd" 
	set_global_assignment -name VHDL_FILE "/u/home/clab/st161569/FachpraktikumRechnerarchitektur/RISCV_Processor_lib/hdl/mem_wb_pipeline_reg_behav.vhd" 
	set_global_assignment -name VHDL_FILE "/u/home/clab/st161569/FachpraktikumRechnerarchitektur/RISCV_Processor_lib/hdl/pc_ex_inc_entity.vhd" 
	set_global_assignment -name VHDL_FILE "/u/home/clab/st161569/FachpraktikumRechnerarchitektur/RISCV_Processor_lib/hdl/pc_ex_inc_behav.vhd" 
	set_global_assignment -name VHDL_FILE "/u/home/clab/st161569/FachpraktikumRechnerarchitektur/RISCV_Processor_lib/hdl/pc_inc_entity.vhd" 
	set_global_assignment -name VHDL_FILE "/u/home/clab/st161569/FachpraktikumRechnerarchitektur/RISCV_Processor_lib/hdl/pc_inc_behav.vhd" 
	set_global_assignment -name VHDL_FILE "/u/home/clab/st161569/FachpraktikumRechnerarchitektur/RISCV_Processor_lib/hdl/pc_mux_entity.vhd" 
	set_global_assignment -name VHDL_FILE "/u/home/clab/st161569/FachpraktikumRechnerarchitektur/RISCV_Processor_lib/hdl/pc_mux_behav.vhd" 
	set_global_assignment -name VHDL_FILE "/u/home/clab/st161569/FachpraktikumRechnerarchitektur/RISCV_Processor_lib/hdl/pf_if_pipeline_reg_entity.vhd" 
	set_global_assignment -name VHDL_FILE "/u/home/clab/st161569/FachpraktikumRechnerarchitektur/RISCV_Processor_lib/hdl/pc_if_pipeline_reg_behav.vhd" 
	set_global_assignment -name VHDL_FILE "/u/home/clab/st161569/FachpraktikumRechnerarchitektur/RISCV_Processor_lib/hdl/register_file_entity.vhd" 
	set_global_assignment -name VHDL_FILE "/u/home/clab/st161569/FachpraktikumRechnerarchitektur/RISCV_Processor_lib/hdl/register_file_behav.vhd" 
	set_global_assignment -name VHDL_FILE "/u/home/clab/st161569/FachpraktikumRechnerarchitektur/RISCV_Processor_lib/hdl/rs1_fwd_mux_entity.vhd" 
	set_global_assignment -name VHDL_FILE "/u/home/clab/st161569/FachpraktikumRechnerarchitektur/RISCV_Processor_lib/hdl/rs1_fwd_mux_behav.vhd" 
	set_global_assignment -name VHDL_FILE "/u/home/clab/st161569/FachpraktikumRechnerarchitektur/RISCV_Processor_lib/hdl/rs2_fwd_mux_entity.vhd" 
	set_global_assignment -name VHDL_FILE "/u/home/clab/st161569/FachpraktikumRechnerarchitektur/RISCV_Processor_lib/hdl/rs2_fwd_mux_behav.vhd" 
	set_global_assignment -name VHDL_FILE "/u/home/clab/st161569/FachpraktikumRechnerarchitektur/RISCV_Processor_lib/hdl/rs2_mux_entity.vhd" 
	set_global_assignment -name VHDL_FILE "/u/home/clab/st161569/FachpraktikumRechnerarchitektur/RISCV_Processor_lib/hdl/rs2_multiplexer_behav.vhd" 
	set_global_assignment -name VHDL_FILE "/u/home/clab/st161569/FachpraktikumRechnerarchitektur/RISCV_Processor_lib/hdl/sbpu_entity.vhd" 
	set_global_assignment -name VHDL_FILE "/u/home/clab/st161569/FachpraktikumRechnerarchitektur/RISCV_Processor_lib/hdl/sbpu_behav.vhd" 
	set_global_assignment -name VHDL_FILE "/u/home/clab/st161569/FachpraktikumRechnerarchitektur/RISCV_Processor_lib/hdl/store_data_fwd_mux_entity.vhd" 
	set_global_assignment -name VHDL_FILE "/u/home/clab/st161569/FachpraktikumRechnerarchitektur/RISCV_Processor_lib/hdl/store_data_fwd_mux_behav.vhd" 
	set_global_assignment -name VHDL_FILE "/u/home/clab/st161569/FachpraktikumRechnerarchitektur/RISCV_Processor_lib/hdl/cpu_struct.vhd" 
	set_global_assignment -name VHDL_FILE "/u/home/clab/st161569/FachpraktikumRechnerarchitektur/RISCV_Processor_lib/hdl/io_entity.vhd" 
	set_global_assignment -name VHDL_FILE "/u/home/clab/st161569/FachpraktikumRechnerarchitektur/RISCV_Processor_lib/hdl/io_memory_entity.vhd" 
	set_global_assignment -name VHDL_FILE "/u/home/clab/st161569/FachpraktikumRechnerarchitektur/RISCV_Processor_lib/hdl/io_memory_behav.vhd" 
	set_global_assignment -name VHDL_FILE "/u/home/clab/st161569/FachpraktikumRechnerarchitektur/RISCV_Processor_lib/hdl/io_struct.vhd" 
	set_global_assignment -name VHDL_FILE "/u/home/clab/st161569/FachpraktikumRechnerarchitektur/RISCV_Processor_lib/hdl/res_synchronizer_entity.vhd" 
	set_global_assignment -name VHDL_FILE "/u/home/clab/st161569/FachpraktikumRechnerarchitektur/RISCV_Processor_lib/hdl/res_synchronizer_behav.vhd" 
	set_global_assignment -name VHDL_FILE "/u/home/clab/st161569/FachpraktikumRechnerarchitektur/RISCV_Processor_lib/hdl/top_struct.vhd" 


   # Commit assignments
   export_assignments


   # Close project
   if {$need_to_close_project} {
      project_close
   }
}

