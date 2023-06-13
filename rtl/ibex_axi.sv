typedef logic [31:0] axi_addr_t;
typedef logic [31:0] axi_data_t;
typedef logic [3:0]  axi_id_t;
typedef logic        axi_user_t;
typedef logic [3:0]  axi_strb_t;

`AXI_TYPEDEF_AW_CHAN_T(axi_aw_t, axi_addr_t, axi_id_t, axi_user_t)
`AXI_TYPEDEF_W_CHAN_T (axi_w_t, axi_data_t, axi_strb_t, axi_user_t)
`AXI_TYPEDEF_B_CHAN_T (axi_b_t, axi_id_t, axi_user_t)
`AXI_TYPEDEF_AR_CHAN_T(axi_ar_t, axi_addr_t, axi_id_t, axi_user_t)
`AXI_TYPEDEF_R_CHAN_T (axi_r_t, axi_data_t, axi_id_t, axi_user_t)
`AXI_TYPEDEF_REQ_T    (axi_req_t, axi_aw_t, axi_w_t, axi_ar_t)
`AXI_TYPEDEF_RESP_T   (axi_rsp_t, axi_b_t, axi_r_t)


module ibex_axi import ibex_pkg::*; # (
  parameter type axi_req_t = axi_req_t,
  parameter type axi_rsp_t = axi_rsp_t
)(
  input  logic         clk_i,
  input  logic         rst_ni,

  input  logic [31:0]  boot_addr_i,

  // Instruction memory interface
  output axi_req_t     instr_axi_req_o,
  input  axi_rsp_t     instr_axi_rsp_i,

  // Data memory interface
  output axi_req_t     data_axi_req_o,
  input  axi_rsp_t     data_axi_rsp_i,

  // Interrupt inputs
  input  logic         irq_software_i,
  input  logic         irq_timer_i,
  input  logic         irq_external_i,
  input  logic [14:0]  irq_fast_i,
  input  logic         irq_nm_i       // non-maskeable interrupt
);

  // Instruction memory interface
  logic        instr_req;
  logic        instr_gnt;
  logic        instr_rvalid;
  logic [31:0] instr_addr;
  logic [31:0] instr_rdata;
  logic        instr_err;

  // Data memory interface
  logic        data_req;
  logic        data_gnt;
  logic        data_rvalid;
  logic        data_we;
  logic [3:0]  data_be;
  logic [31:0] data_addr;
  logic [31:0] data_wdata;
  logic [31:0] data_rdata;
  logic        data_err;

  ibex_top # (
    .PMPEnable        (0), 
    .PMPGranularity   (0), 
    .PMPNumRegions    (4), 
    .MHPMCounterNum   (0), 
    .MHPMCounterWidth (40), 
    .RV32E            (0), 
    .RV32M            (ibex_pkg::RV32MSingleCycle), 
    .RV32B            (ibex_pkg::RV32BBalanced), 
    .RegFile          (ibex_pkg::RegFileFF), 
    .BranchTargetALU  (1), 
    .WritebackStage   (1), 
    .ICache           (0), 
    .ICacheECC        (0), 
    .BranchPredictor  (0), 
    .SecureIbex       (0), 
    .ICacheScramble   (0), 
    .DbgTriggerEn     (0)
  ) i_ibex (
    // Clock and Reset
    .clk_i,
    .rst_ni,
    .test_en_i            (1'd0),     // enable all clock gates for testing
    .ram_cfg_i            (10'd0),
    .hart_id_i            (32'd0),
    .boot_addr_i,
    .instr_req_o          (instr_req),
    .instr_gnt_i          (instr_gnt),
    .instr_rvalid_i       (instr_rvalid),
    .instr_addr_o         (instr_addr),
    .instr_rdata_i        (instr_rdata),
    .instr_rdata_intg_i   (7'd0),
    .instr_err_i          (instr_err),
    .data_req_o           (data_req),
    .data_gnt_i           (data_gnt),
    .data_rvalid_i        (data_rvalid),
    .data_we_o            (data_we),
    .data_be_o            (data_be),
    .data_addr_o          (data_addr),
    .data_wdata_o         (data_wdata),
    .data_wdata_intg_o    (),
    .data_rdata_i         (data_rdata),
    .data_rdata_intg_i    (7'd0),
    .data_err_i           (data_err),
    .irq_software_i,
    .irq_timer_i,
    .irq_external_i,
    .irq_fast_i,
    .irq_nm_i,                             // non-maskeable interrupt
    .scramble_key_valid_i   (1'd0),
    .scramble_key_i         ('d0),
    .scramble_nonce_i       ('d0),
    .scramble_req_o         (),
    .debug_req_i            (1'd0),
    .crash_dump_o           (),
    .double_fault_seen_o    (),
    .fetch_enable_i         (1'd1),
    .alert_minor_o          (),
    .alert_major_internal_o (),
    .alert_major_bus_o      (),
    .core_sleep_o           (),
    .scan_rst_ni            (1'd1)
  );

  axi_from_mem #(
    .MemAddrWidth  (32),
    .AxiAddrWidth  (32),
    .DataWidth     (32),
    .MaxRequests   (1),
    .axi_req_t     (axi_req_t),
    .axi_rsp_t     (axi_rsp_t)
  ) i_instr_axi (
    .clk_i,
    .rst_ni,
    .mem_req_i        (instr_req),
    .mem_addr_i       (instr_addr),
    .mem_we_i         ('d0),
    .mem_wdata_i      ('d0),
    .mem_be_i         ('d0),
    .mem_gnt_o        (instr_gnt),
    .mem_rsp_valid_o  (instr_rvalid),
    .mem_rsp_rdata_o  (instr_rdata),
    .mem_rsp_error_o  (instr_err),
    .slv_aw_cache_i   ('d0),
    .slv_ar_cache_i   ('d0),
    .axi_req_o        (instr_axi_req_o),
    .axi_rsp_i        (instr_axi_rsp_i)
  );

  axi_from_mem #(
    .MemAddrWidth  (32),
    .AxiAddrWidth  (32),
    .DataWidth     (32),
    .MaxRequests   (1),
    .axi_req_t     (axi_req_t),
    .axi_rsp_t     (axi_rsp_t)
  ) i_data_axi ( 
    .clk_i,
    .rst_ni,
    .mem_req_i        (data_req),
    .mem_addr_i       (data_addr),
    .mem_we_i         (data_we),
    .mem_wdata_i      (data_wdata),
    .mem_be_i         (data_be),
    .mem_gnt_o        (data_gnt),
    .mem_rsp_valid_o  (data_rvalid),
    .mem_rsp_rdata_o  (data_rdata),
    .mem_rsp_error_o  (data_err),
    .slv_aw_cache_i   ('d0),
    .slv_ar_cache_i   ('d0),
    .axi_req_o        (data_axi_req_o),
    .axi_rsp_i        (data_axi_rsp_i)
  );

endmodule
