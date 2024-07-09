--
-- VHDL Architecture RISCV_Processor_lib.cpu.struct
--
-- Created:
--          by - st161569.st161569 (pc043)
--          at - 18:42:02 07/09/24
--
-- Generated by Mentor Graphics' HDL Designer(TM) 2022.3 Built on 14 Jul 2022 at 13:56:12
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;
LIBRARY RISCV_Processor_lib;
USE RISCV_Processor_lib.types.ALL;
USE RISCV_Processor_lib.isa_defines.ALL;
LIBRARY altera_mf;
USE altera_mf.altera_mf_components.all;


ARCHITECTURE struct OF cpu IS

   -- Architecture declarations

   -- Internal signal declarations
   SIGNAL alu_flags                   : flag_t;
   SIGNAL alu_mode_dc                 : alu_mode_t;
   SIGNAL alu_mode_ex                 : alu_mode_t;
   SIGNAL be                          : std_logic_vector(NUM_BYTES - 1 DOWNTO 0);
   SIGNAL bpb_controls                : bpb_controls_t;
   SIGNAL bpb_state_dc                : bpb_state_t;
   SIGNAL bpb_state_ex                : bpb_state_t;
   SIGNAL bpb_state_if                : std_logic_vector(1 DOWNTO 0);
   SIGNAL bta                         : word_t;
   SIGNAL btc_controls_dbpu           : btc_controls_t;
   SIGNAL btc_controls_sbpu           : btc_controls_t;
   SIGNAL data_memory_result          : word_t;
   SIGNAL dbpu_mode_dc                : dbpu_mode_t;
   SIGNAL dbpu_mode_ex                : dbpu_mode_t;
   SIGNAL dbta                        : word_t;
   SIGNAL dbta_valid_ex               : boolean;
   SIGNAL divider_control_dc          : divider_control_t;
   SIGNAL divider_control_ex          : divider_control_t;
   SIGNAL divider_result              : word_t;
   SIGNAL division_done               : boolean;
   SIGNAL ex_out_ex                   : word_t;
   SIGNAL ex_out_mem                  : word_t;
   SIGNAL fwd_rs1_dc                  : fwd_select_t;
   SIGNAL fwd_rs1_ex                  : fwd_select_t;
   SIGNAL fwd_rs2_dc                  : fwd_select_t;
   SIGNAL fwd_rs2_ex                  : fwd_select_t;
   SIGNAL fwd_store_data_dc           : boolean;
   SIGNAL fwd_store_data_ex           : boolean;
   SIGNAL fwd_store_data_mem          : boolean;
   SIGNAL imm_dc                      : word_t;
   SIGNAL imm_or_bta_dc               : word_t;
   SIGNAL imm_or_bta_ex               : word_t;
   SIGNAL imm_to_alu_dc               : boolean;
   SIGNAL imm_to_alu_ex               : boolean;
   SIGNAL instruction_word_dc         : word_t;
   SIGNAL instruction_word_if         : word_t;
   SIGNAL instruction_word_rom        : word_t;
   SIGNAL instruction_word_umgenudelt : word_t;
   SIGNAL is_bta                      : boolean;
   SIGNAL is_return_addr              : boolean;
   SIGNAL jump_predicted_dc           : boolean;
   SIGNAL jump_predicted_ex           : boolean;
   SIGNAL jump_predicted_if           : boolean;
   SIGNAL mem_mode_dc                 : mem_mode_t;
   SIGNAL mem_mode_ex                 : mem_mode_t;
   SIGNAL mem_mode_mem                : mem_mode_t;
   SIGNAL mem_result_mem              : word_t;
   SIGNAL mem_result_wb               : word_t;
   SIGNAL operand_a                   : word_t;
   SIGNAL operand_b                   : word_t;
   SIGNAL pc_dc                       : word_t;
   SIGNAL pc_ex                       : word_t;
   SIGNAL pc_pf                       : word_t;
   SIGNAL pc_pre_if                   : word_t;
   SIGNAL predicted_target_addr_dc    : word_t;
   SIGNAL predicted_target_addr_ex    : word_t;
   SIGNAL predicted_target_addr_if    : word_t;
   SIGNAL raddr                       : std_logic_vector(ADDR_WIDTH - 1 DOWNTO 0);
   SIGNAL rd_addr_dc                  : register_file_t;
   SIGNAL rd_addr_ex                  : register_file_t;
   SIGNAL rd_addr_mem                 : register_file_t;
   SIGNAL rd_addr_wb                  : register_file_t;
   SIGNAL rdata                       : std_logic_vector((NUM_BYTES * BYTE_WIDTH) - 1 DOWNTO 0);
   SIGNAL return_addr                 : word_t;
   SIGNAL rom_addr                    : std_logic_vector(ADDR_WIDTH - 1 DOWNTO 0);
   SIGNAL rs1_addr                    : register_file_t;
   SIGNAL rs1_dc                      : word_t;
   SIGNAL rs1_ex                      : word_t;
   SIGNAL rs2_addr                    : register_file_t;
   SIGNAL rs2_dc                      : word_t;
   SIGNAL rs2_ex                      : word_t;
   SIGNAL rs2_fwd_mux_out             : word_t;
   SIGNAL rs2_mem                     : word_t;
   SIGNAL sbpu_mode_dc                : sbpu_mode_t;
   SIGNAL sbta_valid_dc               : boolean;
   SIGNAL stall_dc                    : boolean;
   SIGNAL stall_rest_dc               : boolean;
   SIGNAL store_data                  : word_t;
   SIGNAL waddr                       : std_logic_vector(ADDR_WIDTH - 1 DOWNTO 0);
   SIGNAL wdata                       : std_logic_vector((NUM_BYTES * BYTE_WIDTH) - 1 DOWNTO 0);
   SIGNAL wrong_jump_prediction_dbpu  : boolean;
   SIGNAL wrong_jump_prediction_sbpu  : boolean;

   -- Implicit buffer signal declarations
   SIGNAL alu_result_ex_internal : word_t;
   SIGNAL pc_internal            : word_t;


   -- Component Declarations
   COMPONENT addr_calc
   PORT (
      ex_out_ex    : IN     word_t ;
      ex_out_mem   : IN     word_t ;
      mem_mode_mem : IN     mem_mode_t ;
      store_data   : IN     word_t ;
      be           : OUT    std_logic_vector (NUM_BYTES - 1 DOWNTO 0);
      raddr        : OUT    std_logic_vector (ADDR_WIDTH - 1 DOWNTO 0);
      waddr        : OUT    std_logic_vector (ADDR_WIDTH - 1 DOWNTO 0);
      wdata        : OUT    std_logic_vector ((NUM_BYTES * BYTE_WIDTH) - 1 DOWNTO 0)
   );
   END COMPONENT;
   COMPONENT addr_width_reducer
   PORT (
      pc       : IN     word_t ;
      rom_addr : OUT    std_logic_vector (ADDR_WIDTH - 1 DOWNTO 0)
   );
   END COMPONENT;
   COMPONENT alu
   PORT (
      alu_mode_ex   : IN     alu_mode_t ;
      operand_a     : IN     word_t ;
      operand_b     : IN     word_t ;
      alu_flags     : OUT    flag_t ;
      alu_result_ex : OUT    word_t 
   );
   END COMPONENT;
   COMPONENT bpu
   PORT (
      bpb_controls               : IN     bpb_controls_t ;
      btc_controls_dbpu          : IN     btc_controls_t ;
      btc_controls_sbpu          : IN     btc_controls_t ;
      clk                        : IN     std_logic ;
      pc                         : IN     word_t ;
      res_n                      : IN     std_logic ;
      wrong_jump_prediction_dbpu : IN     boolean ;
      wrong_jump_prediction_sbpu : IN     boolean ;
      bpb_state_if               : OUT    std_logic_vector (1 DOWNTO 0);
      jump_predicted_if          : OUT    boolean ;
      predicted_target_addr_if   : OUT    word_t 
   );
   END COMPONENT;
   COMPONENT bta_adder
   PORT (
      imm_dc : IN     word_t ;
      pc_dc  : IN     word_t ;
      bta    : OUT    word_t 
   );
   END COMPONENT;
   COMPONENT data_memory_extractor
   PORT (
      ex_out_mem         : IN     word_t ;
      mem_mode_mem       : IN     mem_mode_t ;
      rdata              : IN     std_logic_vector ((NUM_BYTES * BYTE_WIDTH) - 1 DOWNTO 0);
      data_memory_result : OUT    word_t 
   );
   END COMPONENT;
   COMPONENT dbpu
   PORT (
      alu_flags                  : IN     flag_t ;
      alu_result_ex              : IN     word_t ;
      bpb_state_ex               : IN     bpb_state_t ;
      dbpu_mode_ex               : IN     dbpu_mode_t ;
      imm_or_bta_ex              : IN     word_t ;
      jump_predicted_ex          : IN     boolean ;
      pc_ex                      : IN     word_t ;
      predicted_target_addr_ex   : IN     word_t ;
      bpb_controls               : OUT    bpb_controls_t ;
      btc_controls_dbpu          : OUT    btc_controls_t ;
      dbta                       : OUT    word_t ;
      dbta_valid_ex              : OUT    boolean ;
      is_return_addr             : OUT    boolean ;
      wrong_jump_prediction_dbpu : OUT    boolean 
   );
   END COMPONENT;
   COMPONENT dc_ex_pipeline_reg
   PORT (
      alu_mode_dc              : IN     alu_mode_t ;
      bpb_state_dc             : IN     bpb_state_t ;
      clk                      : IN     std_logic ;
      dbpu_mode_dc             : IN     dbpu_mode_t ;
      divider_control_dc       : IN     divider_control_t ;
      fwd_rs1_dc               : IN     fwd_select_t ;
      fwd_rs2_dc               : IN     fwd_select_t ;
      fwd_store_data_dc        : IN     boolean ;
      imm_or_bta_dc            : IN     word_t ;
      imm_to_alu_dc            : IN     boolean ;
      jump_predicted_dc        : IN     boolean ;
      mem_mode_dc              : IN     mem_mode_t ;
      pc_dc                    : IN     word_t ;
      predicted_target_addr_dc : IN     word_t ;
      rd_addr_dc               : IN     register_file_t ;
      res_n                    : IN     std_logic ;
      rs1_dc                   : IN     word_t ;
      rs2_dc                   : IN     word_t ;
      stall_rest_dc            : IN     boolean ;
      alu_mode_ex              : OUT    alu_mode_t ;
      bpb_state_ex             : OUT    bpb_state_t ;
      dbpu_mode_ex             : OUT    dbpu_mode_t ;
      divider_control_ex       : OUT    divider_control_t ;
      fwd_rs1_ex               : OUT    fwd_select_t ;
      fwd_rs2_ex               : OUT    fwd_select_t ;
      fwd_store_data_ex        : OUT    boolean ;
      imm_or_bta_ex            : OUT    word_t ;
      imm_to_alu_ex            : OUT    boolean ;
      jump_predicted_ex        : OUT    boolean ;
      mem_mode_ex              : OUT    mem_mode_t ;
      pc_ex                    : OUT    word_t ;
      predicted_target_addr_ex : OUT    word_t ;
      rd_addr_ex               : OUT    register_file_t ;
      rs1_ex                   : OUT    word_t ;
      rs2_ex                   : OUT    word_t 
   );
   END COMPONENT;
   COMPONENT decoder
   PORT (
      dbpu_mode_ex               : IN     dbpu_mode_t ;
      dbta_valid_ex              : IN     boolean ;
      divider_control_ex         : IN     divider_control_t ;
      division_done              : IN     boolean ;
      instruction_word_dc        : IN     word_t ;
      mem_mode_ex                : IN     mem_mode_t ;
      rd_addr_ex                 : IN     register_file_t ;
      rd_addr_mem                : IN     register_file_t ;
      wrong_jump_prediction_dbpu : IN     boolean ;
      alu_mode_dc                : OUT    alu_mode_t ;
      dbpu_mode_dc               : OUT    dbpu_mode_t ;
      divider_control_dc         : OUT    divider_control_t ;
      fwd_rs1_dc                 : OUT    fwd_select_t ;
      fwd_rs2_dc                 : OUT    fwd_select_t ;
      fwd_store_data_dc          : OUT    boolean ;
      imm_dc                     : OUT    word_t ;
      imm_to_alu_dc              : OUT    boolean ;
      is_bta                     : OUT    boolean ;
      mem_mode_dc                : OUT    mem_mode_t ;
      rd_addr_dc                 : OUT    register_file_t ;
      rs1_addr                   : OUT    register_file_t ;
      rs2_addr                   : OUT    register_file_t ;
      sbpu_mode_dc               : OUT    sbpu_mode_t ;
      sbta_valid_dc              : OUT    boolean ;
      stall_dc                   : OUT    boolean ;
      stall_rest_dc              : OUT    boolean 
   );
   END COMPONENT;
   COMPONENT divider
   PORT (
      clk                : IN     std_logic ;
      divider_control_ex : IN     divider_control_t ;
      operand_a          : IN     word_t ;
      operand_b          : IN     word_t ;
      res_n              : IN     std_logic ;
      divider_result     : OUT    word_t ;
      division_done      : OUT    boolean 
   );
   END COMPONENT;
   COMPONENT ex_mem_pipeline_reg
   PORT (
      clk                : IN     std_logic ;
      ex_out_ex          : IN     word_t ;
      fwd_store_data_ex  : IN     boolean ;
      mem_mode_ex        : IN     mem_mode_t ;
      rd_addr_ex         : IN     register_file_t ;
      res_n              : IN     std_logic ;
      rs2_fwd_mux_out    : IN     word_t ;
      stall_rest_dc      : IN     boolean ;
      ex_out_mem         : OUT    word_t ;
      fwd_store_data_mem : OUT    boolean ;
      mem_mode_mem       : OUT    mem_mode_t ;
      rd_addr_mem        : OUT    register_file_t ;
      rs2_mem            : OUT    word_t 
   );
   END COMPONENT;
   COMPONENT ex_out_mux
   PORT (
      alu_result_ex  : IN     word_t ;
      divider_result : IN     word_t ;
      division_done  : IN     boolean ;
      is_return_addr : IN     boolean ;
      return_addr    : IN     word_t ;
      ex_out_ex      : OUT    word_t 
   );
   END COMPONENT;
   COMPONENT gen_ram_be
   GENERIC (
      ADDR_WIDTH : positive;
      NUM_BYTES  : positive;
      BYTE_WIDTH : positive
   );
   PORT (
      be    : IN     std_logic_vector (NUM_BYTES - 1 DOWNTO 0);
      clk   : IN     std_logic;
      raddr : IN     std_logic_vector (ADDR_WIDTH - 1 DOWNTO 0);
      waddr : IN     std_logic_vector (ADDR_WIDTH - 1 DOWNTO 0);
      wdata : IN     std_logic_vector ((NUM_BYTES * BYTE_WIDTH) - 1 DOWNTO 0);
      rdata : OUT    std_logic_vector ((NUM_BYTES * BYTE_WIDTH) - 1 DOWNTO 0)
   );
   END COMPONENT;
   COMPONENT gen_rom
   GENERIC (
      ADDR_WIDTH : positive;
      DATA_WIDTH : positive;
      INIT_FILE  : string
   );
   PORT (
      addr : IN     STD_LOGIC_VECTOR (ADDR_WIDTH - 1 DOWNTO 0);
      clk  : IN     STD_LOGIC;
      q    : OUT    STD_LOGIC_VECTOR (DATA_WIDTH - 1 DOWNTO 0)
   );
   END COMPONENT;
   COMPONENT if_dc_pipeline_reg
   PORT (
      bpb_state_if             : IN     std_logic_vector (1 DOWNTO 0);
      clk                      : IN     std_logic ;
      instruction_word_if      : IN     word_t ;
      jump_predicted_if        : IN     boolean ;
      pc_pre_if                : IN     word_t ;
      predicted_target_addr_if : IN     word_t ;
      res_n                    : IN     std_logic ;
      stall_dc                 : IN     boolean ;
      bpb_state_dc             : OUT    bpb_state_t ;
      instruction_word_dc      : OUT    word_t ;
      jump_predicted_dc        : OUT    boolean ;
      pc_dc                    : OUT    word_t ;
      predicted_target_addr_dc : OUT    word_t 
   );
   END COMPONENT;
   COMPONENT imm_bta_mux
   PORT (
      bta           : IN     word_t ;
      imm_dc        : IN     word_t ;
      is_bta        : IN     boolean ;
      imm_or_bta_dc : OUT    word_t 
   );
   END COMPONENT;
   COMPONENT instruction_word_mux
   PORT (
      instruction_word_umgenudelt : IN     word_t ;
      wrong_jump_prediction_dbpu  : IN     boolean ;
      wrong_jump_prediction_sbpu  : IN     boolean ;
      instruction_word_if         : OUT    word_t 
   );
   END COMPONENT;
   COMPONENT mem_mode_mux
   PORT (
      data_memory_result : IN     word_t ;
      ex_out_mem         : IN     word_t ;
      mem_mode_mem       : IN     mem_mode_t ;
      mem_result_mem     : OUT    word_t 
   );
   END COMPONENT;
   COMPONENT mem_wb_pipeline_reg
   PORT (
      clk            : IN     std_logic ;
      mem_result_mem : IN     word_t ;
      rd_addr_mem    : IN     register_file_t ;
      res_n          : IN     std_logic ;
      stall_rest_dc  : IN     boolean ;
      mem_result_wb  : OUT    word_t ;
      rd_addr_wb     : OUT    register_file_t 
   );
   END COMPONENT;
   COMPONENT pc_ex_inc
   PORT (
      pc_ex       : IN     word_t ;
      return_addr : OUT    word_t 
   );
   END COMPONENT;
   COMPONENT pc_inc
   PORT (
      pc_pre_if : IN     word_t ;
      res_n     : IN     std_logic ;
      pc_pf     : OUT    word_t 
   );
   END COMPONENT;
   COMPONENT pc_mux
   PORT (
      dbta                       : IN     word_t ;
      dbta_valid_ex              : IN     boolean ;
      imm_or_bta_dc              : IN     word_t ;
      jump_predicted_if          : IN     boolean ;
      pc_pf                      : IN     word_t ;
      predicted_target_addr_if   : IN     word_t ;
      return_addr                : IN     word_t ;
      sbta_valid_dc              : IN     boolean ;
      wrong_jump_prediction_dbpu : IN     boolean ;
      wrong_jump_prediction_sbpu : IN     boolean ;
      pc                         : OUT    word_t 
   );
   END COMPONENT;
   COMPONENT pf_if_pipeline_reg
   PORT (
      clk       : IN     std_logic ;
      pc        : IN     word_t ;
      res_n     : IN     std_logic ;
      stall_dc  : IN     boolean ;
      pc_pre_if : OUT    word_t 
   );
   END COMPONENT;
   COMPONENT register_file
   PORT (
      clk           : IN     std_logic ;
      mem_result_wb : IN     word_t ;
      rd_addr_wb    : IN     register_file_t ;
      res_n         : IN     std_logic ;
      rs1_addr      : IN     register_file_t ;
      rs2_addr      : IN     register_file_t ;
      rs1_dc        : OUT    word_t ;
      rs2_dc        : OUT    word_t 
   );
   END COMPONENT;
   COMPONENT rs1_fwd_mux
   PORT (
      ex_out_mem    : IN     word_t ;
      fwd_rs1_ex    : IN     fwd_select_t ;
      mem_result_wb : IN     word_t ;
      rs1_ex        : IN     word_t ;
      operand_a     : OUT    word_t 
   );
   END COMPONENT;
   COMPONENT rs2_fwd_mux
   PORT (
      ex_out_mem      : IN     word_t ;
      fwd_rs2_ex      : IN     fwd_select_t ;
      mem_result_wb   : IN     word_t ;
      rs2_ex          : IN     word_t ;
      rs2_fwd_mux_out : OUT    word_t 
   );
   END COMPONENT;
   COMPONENT rs2_mux
   PORT (
      imm_or_bta_ex   : IN     word_t ;
      imm_to_alu_ex   : IN     boolean ;
      rs2_fwd_mux_out : IN     word_t ;
      operand_b       : OUT    word_t 
   );
   END COMPONENT;
   COMPONENT sbpu
   PORT (
      imm_or_bta_dc              : IN     word_t ;
      jump_predicted_dc          : IN     boolean ;
      pc_dc                      : IN     word_t ;
      sbpu_mode_dc               : IN     sbpu_mode_t ;
      btc_controls_sbpu          : OUT    btc_controls_t ;
      wrong_jump_prediction_sbpu : OUT    boolean 
   );
   END COMPONENT;
   COMPONENT store_data_fwd_mux
   PORT (
      fwd_store_data_mem : IN     boolean ;
      mem_result_wb      : IN     word_t ;
      rs2_mem            : IN     word_t ;
      store_data         : OUT    word_t 
   );
   END COMPONENT;
   COMPONENT umnudler
   PORT (
      instruction_word_rom        : IN     word_t ;
      instruction_word_umgenudelt : OUT    word_t 
   );
   END COMPONENT;

   -- Optional embedded configurations
   -- pragma synthesis_off
   FOR ALL : addr_calc USE ENTITY RISCV_Processor_lib.addr_calc;
   FOR ALL : addr_width_reducer USE ENTITY RISCV_Processor_lib.addr_width_reducer;
   FOR ALL : alu USE ENTITY RISCV_Processor_lib.alu;
   FOR ALL : bpu USE ENTITY RISCV_Processor_lib.bpu;
   FOR ALL : bta_adder USE ENTITY RISCV_Processor_lib.bta_adder;
   FOR ALL : data_memory_extractor USE ENTITY RISCV_Processor_lib.data_memory_extractor;
   FOR ALL : dbpu USE ENTITY RISCV_Processor_lib.dbpu;
   FOR ALL : dc_ex_pipeline_reg USE ENTITY RISCV_Processor_lib.dc_ex_pipeline_reg;
   FOR ALL : decoder USE ENTITY RISCV_Processor_lib.decoder;
   FOR ALL : divider USE ENTITY RISCV_Processor_lib.divider;
   FOR ALL : ex_mem_pipeline_reg USE ENTITY RISCV_Processor_lib.ex_mem_pipeline_reg;
   FOR ALL : ex_out_mux USE ENTITY RISCV_Processor_lib.ex_out_mux;
   FOR ALL : gen_ram_be USE ENTITY RISCV_Processor_lib.gen_ram_be;
   FOR ALL : gen_rom USE ENTITY RISCV_Processor_lib.gen_rom;
   FOR ALL : if_dc_pipeline_reg USE ENTITY RISCV_Processor_lib.if_dc_pipeline_reg;
   FOR ALL : imm_bta_mux USE ENTITY RISCV_Processor_lib.imm_bta_mux;
   FOR ALL : instruction_word_mux USE ENTITY RISCV_Processor_lib.instruction_word_mux;
   FOR ALL : mem_mode_mux USE ENTITY RISCV_Processor_lib.mem_mode_mux;
   FOR ALL : mem_wb_pipeline_reg USE ENTITY RISCV_Processor_lib.mem_wb_pipeline_reg;
   FOR ALL : pc_ex_inc USE ENTITY RISCV_Processor_lib.pc_ex_inc;
   FOR ALL : pc_inc USE ENTITY RISCV_Processor_lib.pc_inc;
   FOR ALL : pc_mux USE ENTITY RISCV_Processor_lib.pc_mux;
   FOR ALL : pf_if_pipeline_reg USE ENTITY RISCV_Processor_lib.pf_if_pipeline_reg;
   FOR ALL : register_file USE ENTITY RISCV_Processor_lib.register_file;
   FOR ALL : rs1_fwd_mux USE ENTITY RISCV_Processor_lib.rs1_fwd_mux;
   FOR ALL : rs2_fwd_mux USE ENTITY RISCV_Processor_lib.rs2_fwd_mux;
   FOR ALL : rs2_mux USE ENTITY RISCV_Processor_lib.rs2_mux;
   FOR ALL : sbpu USE ENTITY RISCV_Processor_lib.sbpu;
   FOR ALL : store_data_fwd_mux USE ENTITY RISCV_Processor_lib.store_data_fwd_mux;
   FOR ALL : umnudler USE ENTITY RISCV_Processor_lib.umnudler;
   -- pragma synthesis_on


BEGIN

   -- Instance port mappings.
   addr_calc_i : addr_calc
      PORT MAP (
         ex_out_ex    => ex_out_ex,
         ex_out_mem   => ex_out_mem,
         mem_mode_mem => mem_mode_mem,
         store_data   => store_data,
         be           => be,
         raddr        => raddr,
         waddr        => waddr,
         wdata        => wdata
      );
   addr_width_reducer_i : addr_width_reducer
      PORT MAP (
         pc       => pc_internal,
         rom_addr => rom_addr
      );
   alu_i : alu
      PORT MAP (
         alu_mode_ex   => alu_mode_ex,
         operand_a     => operand_a,
         operand_b     => operand_b,
         alu_flags     => alu_flags,
         alu_result_ex => alu_result_ex_internal
      );
   bpu_i : bpu
      PORT MAP (
         bpb_controls               => bpb_controls,
         btc_controls_dbpu          => btc_controls_dbpu,
         btc_controls_sbpu          => btc_controls_sbpu,
         clk                        => clk,
         pc                         => pc_internal,
         res_n                      => res_n,
         wrong_jump_prediction_dbpu => wrong_jump_prediction_dbpu,
         wrong_jump_prediction_sbpu => wrong_jump_prediction_sbpu,
         bpb_state_if               => bpb_state_if,
         jump_predicted_if          => jump_predicted_if,
         predicted_target_addr_if   => predicted_target_addr_if
      );
   bta_adder_i : bta_adder
      PORT MAP (
         imm_dc => imm_dc,
         pc_dc  => pc_dc,
         bta    => bta
      );
   data_memory_extractor_i : data_memory_extractor
      PORT MAP (
         ex_out_mem         => ex_out_mem,
         mem_mode_mem       => mem_mode_mem,
         rdata              => rdata,
         data_memory_result => data_memory_result
      );
   dbpu_i : dbpu
      PORT MAP (
         alu_flags                  => alu_flags,
         alu_result_ex              => alu_result_ex_internal,
         bpb_state_ex               => bpb_state_ex,
         dbpu_mode_ex               => dbpu_mode_ex,
         imm_or_bta_ex              => imm_or_bta_ex,
         jump_predicted_ex          => jump_predicted_ex,
         pc_ex                      => pc_ex,
         predicted_target_addr_ex   => predicted_target_addr_ex,
         bpb_controls               => bpb_controls,
         btc_controls_dbpu          => btc_controls_dbpu,
         dbta                       => dbta,
         dbta_valid_ex              => dbta_valid_ex,
         is_return_addr             => is_return_addr,
         wrong_jump_prediction_dbpu => wrong_jump_prediction_dbpu
      );
   dc_ex_pipeline_reg_i : dc_ex_pipeline_reg
      PORT MAP (
         alu_mode_dc              => alu_mode_dc,
         bpb_state_dc             => bpb_state_dc,
         clk                      => clk,
         dbpu_mode_dc             => dbpu_mode_dc,
         divider_control_dc       => divider_control_dc,
         fwd_rs1_dc               => fwd_rs1_dc,
         fwd_rs2_dc               => fwd_rs2_dc,
         fwd_store_data_dc        => fwd_store_data_dc,
         imm_or_bta_dc            => imm_or_bta_dc,
         imm_to_alu_dc            => imm_to_alu_dc,
         jump_predicted_dc        => jump_predicted_dc,
         mem_mode_dc              => mem_mode_dc,
         pc_dc                    => pc_dc,
         predicted_target_addr_dc => predicted_target_addr_dc,
         rd_addr_dc               => rd_addr_dc,
         res_n                    => res_n,
         rs1_dc                   => rs1_dc,
         rs2_dc                   => rs2_dc,
         stall_rest_dc            => stall_rest_dc,
         alu_mode_ex              => alu_mode_ex,
         bpb_state_ex             => bpb_state_ex,
         dbpu_mode_ex             => dbpu_mode_ex,
         divider_control_ex       => divider_control_ex,
         fwd_rs1_ex               => fwd_rs1_ex,
         fwd_rs2_ex               => fwd_rs2_ex,
         fwd_store_data_ex        => fwd_store_data_ex,
         imm_or_bta_ex            => imm_or_bta_ex,
         imm_to_alu_ex            => imm_to_alu_ex,
         jump_predicted_ex        => jump_predicted_ex,
         mem_mode_ex              => mem_mode_ex,
         pc_ex                    => pc_ex,
         predicted_target_addr_ex => predicted_target_addr_ex,
         rd_addr_ex               => rd_addr_ex,
         rs1_ex                   => rs1_ex,
         rs2_ex                   => rs2_ex
      );
   decoder_i : decoder
      PORT MAP (
         dbpu_mode_ex               => dbpu_mode_ex,
         dbta_valid_ex              => dbta_valid_ex,
         divider_control_ex         => divider_control_ex,
         division_done              => division_done,
         instruction_word_dc        => instruction_word_dc,
         mem_mode_ex                => mem_mode_ex,
         rd_addr_ex                 => rd_addr_ex,
         rd_addr_mem                => rd_addr_mem,
         wrong_jump_prediction_dbpu => wrong_jump_prediction_dbpu,
         alu_mode_dc                => alu_mode_dc,
         dbpu_mode_dc               => dbpu_mode_dc,
         divider_control_dc         => divider_control_dc,
         fwd_rs1_dc                 => fwd_rs1_dc,
         fwd_rs2_dc                 => fwd_rs2_dc,
         fwd_store_data_dc          => fwd_store_data_dc,
         imm_dc                     => imm_dc,
         imm_to_alu_dc              => imm_to_alu_dc,
         is_bta                     => is_bta,
         mem_mode_dc                => mem_mode_dc,
         rd_addr_dc                 => rd_addr_dc,
         rs1_addr                   => rs1_addr,
         rs2_addr                   => rs2_addr,
         sbpu_mode_dc               => sbpu_mode_dc,
         sbta_valid_dc              => sbta_valid_dc,
         stall_dc                   => stall_dc,
         stall_rest_dc              => stall_rest_dc
      );
   divider_i : divider
      PORT MAP (
         clk                => clk,
         divider_control_ex => divider_control_ex,
         operand_a          => operand_a,
         operand_b          => operand_b,
         res_n              => res_n,
         divider_result     => divider_result,
         division_done      => division_done
      );
   ex_mem_pipeline_reg_i : ex_mem_pipeline_reg
      PORT MAP (
         clk                => clk,
         ex_out_ex          => ex_out_ex,
         fwd_store_data_ex  => fwd_store_data_ex,
         mem_mode_ex        => mem_mode_ex,
         rd_addr_ex         => rd_addr_ex,
         res_n              => res_n,
         rs2_fwd_mux_out    => rs2_fwd_mux_out,
         stall_rest_dc      => stall_rest_dc,
         ex_out_mem         => ex_out_mem,
         fwd_store_data_mem => fwd_store_data_mem,
         mem_mode_mem       => mem_mode_mem,
         rd_addr_mem        => rd_addr_mem,
         rs2_mem            => rs2_mem
      );
   ex_out_mux_i : ex_out_mux
      PORT MAP (
         alu_result_ex  => alu_result_ex_internal,
         divider_result => divider_result,
         division_done  => division_done,
         is_return_addr => is_return_addr,
         return_addr    => return_addr,
         ex_out_ex      => ex_out_ex
      );
   gen_ram_be_i : gen_ram_be
      GENERIC MAP (
         ADDR_WIDTH => 10,
         NUM_BYTES  => 4,
         BYTE_WIDTH => 8
      )
      PORT MAP (
         clk   => clk,
         raddr => raddr,
         waddr => waddr,
         wdata => wdata,
         be    => be,
         rdata => rdata
      );
   gen_rom_i : gen_rom
      GENERIC MAP (
         ADDR_WIDTH => 10,
         DATA_WIDTH => 32,
         INIT_FILE  => "/u/home/clab/st161569/Downloads/main.mif"
      )
      PORT MAP (
         addr => rom_addr,
         clk  => clk,
         q    => instruction_word_rom
      );
   if_dc_pipeline_reg_i : if_dc_pipeline_reg
      PORT MAP (
         bpb_state_if             => bpb_state_if,
         clk                      => clk,
         instruction_word_if      => instruction_word_if,
         jump_predicted_if        => jump_predicted_if,
         pc_pre_if                => pc_pre_if,
         predicted_target_addr_if => predicted_target_addr_if,
         res_n                    => res_n,
         stall_dc                 => stall_dc,
         bpb_state_dc             => bpb_state_dc,
         instruction_word_dc      => instruction_word_dc,
         jump_predicted_dc        => jump_predicted_dc,
         pc_dc                    => pc_dc,
         predicted_target_addr_dc => predicted_target_addr_dc
      );
   imm_bta_mux_i : imm_bta_mux
      PORT MAP (
         bta           => bta,
         imm_dc        => imm_dc,
         is_bta        => is_bta,
         imm_or_bta_dc => imm_or_bta_dc
      );
   instruction_word_mux_i : instruction_word_mux
      PORT MAP (
         instruction_word_umgenudelt => instruction_word_umgenudelt,
         wrong_jump_prediction_dbpu  => wrong_jump_prediction_dbpu,
         wrong_jump_prediction_sbpu  => wrong_jump_prediction_sbpu,
         instruction_word_if         => instruction_word_if
      );
   mem_mode_mux_i : mem_mode_mux
      PORT MAP (
         data_memory_result => data_memory_result,
         ex_out_mem         => ex_out_mem,
         mem_mode_mem       => mem_mode_mem,
         mem_result_mem     => mem_result_mem
      );
   mem_wb_pipeline_reg_i : mem_wb_pipeline_reg
      PORT MAP (
         clk            => clk,
         mem_result_mem => mem_result_mem,
         rd_addr_mem    => rd_addr_mem,
         res_n          => res_n,
         stall_rest_dc  => stall_rest_dc,
         mem_result_wb  => mem_result_wb,
         rd_addr_wb     => rd_addr_wb
      );
   pc_ex_inc_i : pc_ex_inc
      PORT MAP (
         pc_ex       => pc_ex,
         return_addr => return_addr
      );
   pc_inc_i : pc_inc
      PORT MAP (
         pc_pre_if => pc_pre_if,
         res_n     => res_n,
         pc_pf     => pc_pf
      );
   pc_mux_i : pc_mux
      PORT MAP (
         dbta                       => dbta,
         dbta_valid_ex              => dbta_valid_ex,
         imm_or_bta_dc              => imm_or_bta_dc,
         jump_predicted_if          => jump_predicted_if,
         pc_pf                      => pc_pf,
         predicted_target_addr_if   => predicted_target_addr_if,
         return_addr                => return_addr,
         sbta_valid_dc              => sbta_valid_dc,
         wrong_jump_prediction_dbpu => wrong_jump_prediction_dbpu,
         wrong_jump_prediction_sbpu => wrong_jump_prediction_sbpu,
         pc                         => pc_internal
      );
   pf_if_pipeline_reg_i : pf_if_pipeline_reg
      PORT MAP (
         clk       => clk,
         pc        => pc_internal,
         res_n     => res_n,
         stall_dc  => stall_dc,
         pc_pre_if => pc_pre_if
      );
   register_file_i : register_file
      PORT MAP (
         clk           => clk,
         mem_result_wb => mem_result_wb,
         rd_addr_wb    => rd_addr_wb,
         res_n         => res_n,
         rs1_addr      => rs1_addr,
         rs2_addr      => rs2_addr,
         rs1_dc        => rs1_dc,
         rs2_dc        => rs2_dc
      );
   rs1_fwd_mux_i : rs1_fwd_mux
      PORT MAP (
         ex_out_mem    => ex_out_mem,
         fwd_rs1_ex    => fwd_rs1_ex,
         mem_result_wb => mem_result_wb,
         rs1_ex        => rs1_ex,
         operand_a     => operand_a
      );
   rs2_fwd_mux_i : rs2_fwd_mux
      PORT MAP (
         ex_out_mem      => ex_out_mem,
         fwd_rs2_ex      => fwd_rs2_ex,
         mem_result_wb   => mem_result_wb,
         rs2_ex          => rs2_ex,
         rs2_fwd_mux_out => rs2_fwd_mux_out
      );
   rs2_mux_i : rs2_mux
      PORT MAP (
         imm_or_bta_ex   => imm_or_bta_ex,
         imm_to_alu_ex   => imm_to_alu_ex,
         rs2_fwd_mux_out => rs2_fwd_mux_out,
         operand_b       => operand_b
      );
   sbpu_i : sbpu
      PORT MAP (
         imm_or_bta_dc              => imm_or_bta_dc,
         jump_predicted_dc          => jump_predicted_dc,
         pc_dc                      => pc_dc,
         sbpu_mode_dc               => sbpu_mode_dc,
         btc_controls_sbpu          => btc_controls_sbpu,
         wrong_jump_prediction_sbpu => wrong_jump_prediction_sbpu
      );
   store_data_fwd_mux_i : store_data_fwd_mux
      PORT MAP (
         fwd_store_data_mem => fwd_store_data_mem,
         mem_result_wb      => mem_result_wb,
         rs2_mem            => rs2_mem,
         store_data         => store_data
      );
   umnudler_i : umnudler
      PORT MAP (
         instruction_word_rom        => instruction_word_rom,
         instruction_word_umgenudelt => instruction_word_umgenudelt
      );

   -- Implicit buffered output assignments
   alu_result_ex <= alu_result_ex_internal;
   pc            <= pc_internal;

END struct;
