`timescale 1 ns / 1 ps
`define ASSERT(name, property)
`define ASSERT_KNOWN(name, property)
`define ASSERT_IF(name, property)
`define ASSERT_INIT(name, property)
`define ASSERT_KNOWN_IF(name, property)
`define ASSERT_INIT_NET(name, property)


    module ibex_axi_verilog_wrapper #
    (
        parameter         C_M00_AXI_TARGET_SLAVE_BASE_ADDR = 32'h40000000,
        parameter integer C_M00_AXI_BURST_LEN              = 16,
        parameter integer C_M00_AXI_ID_WIDTH               = 1,
        parameter integer C_M00_AXI_ADDR_WIDTH             = 32,
        parameter integer C_M00_AXI_DATA_WIDTH             = 32,
        parameter integer C_M00_AXI_AWUSER_WIDTH           = 0,
        parameter integer C_M00_AXI_ARUSER_WIDTH           = 0,
        parameter integer C_M00_AXI_WUSER_WIDTH            = 0,
        parameter integer C_M00_AXI_RUSER_WIDTH            = 0,
        parameter integer C_M00_AXI_BUSER_WIDTH            = 0,

        // Parameters of Axi Master Bus Interface M01_AXI
        parameter  C_M01_AXI_TARGET_SLAVE_BASE_ADDR = 32'h40000000,
        parameter integer C_M01_AXI_BURST_LEN       = 16,
        parameter integer C_M01_AXI_ID_WIDTH        = 1,
        parameter integer C_M01_AXI_ADDR_WIDTH      = 32,
        parameter integer C_M01_AXI_DATA_WIDTH      = 32,
        parameter integer C_M01_AXI_AWUSER_WIDTH    = 0,
        parameter integer C_M01_AXI_ARUSER_WIDTH    = 0,
        parameter integer C_M01_AXI_WUSER_WIDTH     = 0,
        parameter integer C_M01_AXI_RUSER_WIDTH     = 0,
        parameter integer C_M01_AXI_BUSER_WIDTH     = 0,

        parameter         IBEX_PMPEnable            = 1'b0,
        parameter integer IBEX_PMPGranularity       = 0,
        parameter integer IBEX_PMPNumRegions        = 4,
        parameter integer IBEX_MHPMCounterNum       = 0,
        parameter integer IBEX_MHPMCounterWidth     = 40,
        parameter         IBEX_RV32E                = 1'b0,
        parameter integer IBEX_RV32M                = 2,  // RV32MFast, // int
        parameter integer IBEX_RV32B                = 0,  // RV32BNone, // int
        parameter integer IBEX_RegFile              = 0,  // RegFileFF, // int
        parameter         IBEX_BranchTargetALU      = 1'b0,
        parameter         IBEX_WritebackStage       = 1'b0,
        parameter         IBEX_ICache               = 1'b0,
        parameter         IBEX_ICacheECC            = 1'b0,
        parameter         IBEX_BranchPredictor      = 1'b0,
        parameter         IBEX_DbgTriggerEn         = 1'b0,
        parameter integer IBEX_DbgHwBreakNum        = 1,
        parameter         IBEX_SecureIbex           = 1'b0,
        parameter         IBEX_ICacheScramble       = 1'b0,
        parameter integer IBEX_DmHaltAddr           = 32'h1A110800,
        parameter integer IBEX_DmExceptionAddr      = 32'h1A110808
    ) (
        input  wire                                m00_m01_axi_aclk,
        input  wire                                m00_m01_axi_aresetn,
        // Ports of Axi Master Bus Interface M00_AXI
        output wire [C_M00_AXI_ID_WIDTH-1 : 0]     m00_axi_awid,
        output wire [C_M00_AXI_ADDR_WIDTH-1 : 0]   m00_axi_awaddr,
        output wire [7 : 0]                        m00_axi_awlen,
        output wire [2 : 0]                        m00_axi_awsize,
        output wire [1 : 0]                        m00_axi_awburst,
        output wire                                m00_axi_awlock,
        output wire [3 : 0]                        m00_axi_awcache,
        output wire [2 : 0]                        m00_axi_awprot,
        output wire [3 : 0]                        m00_axi_awqos,
        output wire [C_M00_AXI_AWUSER_WIDTH-1 : 0] m00_axi_awuser,
        output wire                                m00_axi_awvalid,
        input  wire                                m00_axi_awready,
        output wire [C_M00_AXI_DATA_WIDTH-1 : 0]   m00_axi_wdata,
        output wire [C_M00_AXI_DATA_WIDTH/8-1 : 0] m00_axi_wstrb,
        output wire                                m00_axi_wlast,
        output wire [C_M00_AXI_WUSER_WIDTH-1 : 0]  m00_axi_wuser,
        output wire                                m00_axi_wvalid,
        input  wire                                m00_axi_wready,
        input  wire [C_M00_AXI_ID_WIDTH-1 : 0]     m00_axi_bid,
        input  wire [1 : 0]                        m00_axi_bresp,
        input  wire [C_M00_AXI_BUSER_WIDTH-1 : 0]  m00_axi_buser,
        input  wire                                m00_axi_bvalid,
        output wire                                m00_axi_bready,
        output wire [C_M00_AXI_ID_WIDTH-1 : 0]     m00_axi_arid,
        output wire [C_M00_AXI_ADDR_WIDTH-1 : 0]   m00_axi_araddr,
        output wire [7 : 0]                        m00_axi_arlen,
        output wire [2 : 0]                        m00_axi_arsize,
        output wire [1 : 0]                        m00_axi_arburst,
        output wire                                m00_axi_arlock,
        output wire [3 : 0]                        m00_axi_arcache,
        output wire [2 : 0]                        m00_axi_arprot,
        output wire [3 : 0]                        m00_axi_arqos,
        output wire [C_M00_AXI_ARUSER_WIDTH-1 : 0] m00_axi_aruser,
        output wire                                m00_axi_arvalid,
        input  wire                                m00_axi_arready,
        input  wire [C_M00_AXI_ID_WIDTH-1 : 0]     m00_axi_rid,
        input  wire [C_M00_AXI_DATA_WIDTH-1 : 0]   m00_axi_rdata,
        input  wire [1 : 0]                        m00_axi_rresp,
        input  wire                                m00_axi_rlast,
        input  wire [C_M00_AXI_RUSER_WIDTH-1 : 0]  m00_axi_ruser,
        input  wire                                m00_axi_rvalid,
        output wire                                m00_axi_rready,

        // Ports of Axi Master Bus Interface M01_AXI
        output wire [C_M00_AXI_ID_WIDTH-1 : 0]     m01_axi_awid,
        output wire [C_M00_AXI_ADDR_WIDTH-1 : 0]   m01_axi_awaddr,
        output wire [7 : 0]                        m01_axi_awlen,
        output wire [2 : 0]                        m01_axi_awsize,
        output wire [1 : 0]                        m01_axi_awburst,
        output wire                                m01_axi_awlock,
        output wire [3 : 0]                        m01_axi_awcache,
        output wire [2 : 0]                        m01_axi_awprot,
        output wire [3 : 0]                        m01_axi_awqos,
        output wire [C_M00_AXI_AWUSER_WIDTH-1 : 0] m01_axi_awuser,
        output wire                                m01_axi_awvalid,
        input  wire                                m01_axi_awready,
        output wire [C_M00_AXI_DATA_WIDTH-1 : 0]   m01_axi_wdata,
        output wire [C_M00_AXI_DATA_WIDTH/8-1 : 0] m01_axi_wstrb,
        output wire                                m01_axi_wlast,
        output wire [C_M00_AXI_WUSER_WIDTH-1 : 0]  m01_axi_wuser,
        output wire                                m01_axi_wvalid,
        input  wire                                m01_axi_wready,
        input  wire [C_M00_AXI_ID_WIDTH-1 : 0]     m01_axi_bid,
        input  wire [1 : 0]                        m01_axi_bresp,
        input  wire [C_M00_AXI_BUSER_WIDTH-1 : 0]  m01_axi_buser,
        input  wire                                m01_axi_bvalid,
        output wire                                m01_axi_bready,
        output wire [C_M00_AXI_ID_WIDTH-1 : 0]     m01_axi_arid,
        output wire [C_M00_AXI_ADDR_WIDTH-1 : 0]   m01_axi_araddr,
        output wire [7 : 0]                        m01_axi_arlen,
        output wire [2 : 0]                        m01_axi_arsize,
        output wire [1 : 0]                        m01_axi_arburst,
        output wire                                m01_axi_arlock,
        output wire [3 : 0]                        m01_axi_arcache,
        output wire [2 : 0]                        m01_axi_arprot,
        output wire [3 : 0]                        m01_axi_arqos,
        output wire [C_M00_AXI_ARUSER_WIDTH-1 : 0] m01_axi_aruser,
        output wire                                m01_axi_arvalid,
        input  wire                                m01_axi_arready,
        input  wire [C_M00_AXI_ID_WIDTH-1 : 0]     m01_axi_rid,
        input  wire [C_M00_AXI_DATA_WIDTH-1 : 0]   m01_axi_rdata,
        input  wire [1 : 0]                        m01_axi_rresp,
        input  wire                                m01_axi_rlast,
        input  wire [C_M00_AXI_RUSER_WIDTH-1 : 0]  m01_axi_ruser,
        input  wire                                m01_axi_rvalid,
        output wire                                m01_axi_rready,

        input  wire [31:0]                         boot_addr_i,
        // Interrupt inputs
        input  wire                                irq_software_i,
        input  wire                                irq_timer_i,
        input  wire                                irq_external_i,
        input  wire [14:0]                         irq_fast_i,
        input  wire                                irq_nm_i       // non-maskeable interrupt
    );

    ibex_axi_ip #(
        .C_M00_AXI_TARGET_SLAVE_BASE_ADDR (C_M00_AXI_TARGET_SLAVE_BASE_ADDR),
        .C_M00_AXI_BURST_LEN              (C_M00_AXI_BURST_LEN),
        .C_M00_AXI_ID_WIDTH               (C_M00_AXI_ID_WIDTH),
        .C_M00_AXI_ADDR_WIDTH             (C_M00_AXI_ADDR_WIDTH),
        .C_M00_AXI_DATA_WIDTH             (C_M00_AXI_DATA_WIDTH),
        .C_M00_AXI_AWUSER_WIDTH           (C_M00_AXI_AWUSER_WIDTH),
        .C_M00_AXI_ARUSER_WIDTH           (C_M00_AXI_ARUSER_WIDTH),
        .C_M00_AXI_WUSER_WIDTH            (C_M00_AXI_WUSER_WIDTH),
        .C_M00_AXI_RUSER_WIDTH            (C_M00_AXI_RUSER_WIDTH),
        .C_M00_AXI_BUSER_WIDTH            (C_M00_AXI_BUSER_WIDTH),
        .C_M01_AXI_TARGET_SLAVE_BASE_ADDR (C_M01_AXI_TARGET_SLAVE_BASE_ADDR),
        .C_M01_AXI_BURST_LEN              (C_M01_AXI_BURST_LEN),
        .C_M01_AXI_ID_WIDTH               (C_M01_AXI_ID_WIDTH),
        .C_M01_AXI_ADDR_WIDTH             (C_M01_AXI_ADDR_WIDTH),
        .C_M01_AXI_DATA_WIDTH             (C_M01_AXI_DATA_WIDTH),
        .C_M01_AXI_AWUSER_WIDTH           (C_M01_AXI_AWUSER_WIDTH),
        .C_M01_AXI_ARUSER_WIDTH           (C_M01_AXI_ARUSER_WIDTH),
        .C_M01_AXI_WUSER_WIDTH            (C_M01_AXI_WUSER_WIDTH),
        .C_M01_AXI_RUSER_WIDTH            (C_M01_AXI_RUSER_WIDTH),
        .C_M01_AXI_BUSER_WIDTH            (C_M01_AXI_BUSER_WIDTH),
        .IBEX_PMPEnable                   (IBEX_PMPEnable), 
        .IBEX_PMPGranularity              (IBEX_PMPGranularity), 
        .IBEX_PMPNumRegions               (IBEX_PMPNumRegions), 
        .IBEX_MHPMCounterNum              (IBEX_MHPMCounterNum), 
        .IBEX_MHPMCounterWidth            (IBEX_MHPMCounterWidth), 
        .IBEX_RV32E                       (IBEX_RV32E), 
        .IBEX_RV32M                       (IBEX_RV32M), 
        .IBEX_RV32B                       (IBEX_RV32B), 
        .IBEX_RegFile                     (IBEX_RegFile), 
        .IBEX_BranchTargetALU             (IBEX_BranchTargetALU), 
        .IBEX_WritebackStage              (IBEX_WritebackStage), 
        .IBEX_ICache                      (IBEX_ICache), 
        .IBEX_ICacheECC                   (IBEX_ICacheECC), 
        .IBEX_BranchPredictor             (IBEX_BranchPredictor), 
        .IBEX_SecureIbex                  (IBEX_SecureIbex), 
        .IBEX_ICacheScramble              (IBEX_ICacheScramble), 
        .IBEX_DmHaltAddr                  (IBEX_DmHaltAddr), 
        .IBEX_DmExceptionAddr             (IBEX_DmExceptionAddr) 
    ) i_ibex_axi_ip (
        .m00_axi_aclk      (m00_m01_axi_aclk),
        .m00_axi_aresetn   (m00_m01_axi_aresetn),
        .m00_axi_awid      (m00_axi_awid),
        .m00_axi_awaddr    (m00_axi_awaddr),
        .m00_axi_awlen     (m00_axi_awlen),
        .m00_axi_awsize    (m00_axi_awsize),
        .m00_axi_awburst   (m00_axi_awburst),
        .m00_axi_awlock    (m00_axi_awlock),
        .m00_axi_awcache   (m00_axi_awcache),
        .m00_axi_awprot    (m00_axi_awprot),
        .m00_axi_awqos     (m00_axi_awqos),
        .m00_axi_awuser    (m00_axi_awuser),
        .m00_axi_awvalid   (m00_axi_awvalid),
        .m00_axi_awready   (m00_axi_awready),
        .m00_axi_wdata     (m00_axi_wdata),
        .m00_axi_wstrb     (m00_axi_wstrb),
        .m00_axi_wlast     (m00_axi_wlast),
        .m00_axi_wuser     (m00_axi_wuser),
        .m00_axi_wvalid    (m00_axi_wvalid),
        .m00_axi_wready    (m00_axi_wready),
        .m00_axi_bid       (m00_axi_bid),
        .m00_axi_bresp     (m00_axi_bresp),
        .m00_axi_buser     (m00_axi_buser),
        .m00_axi_bvalid    (m00_axi_bvalid),
        .m00_axi_bready    (m00_axi_bready),
        .m00_axi_arid      (m00_axi_arid),
        .m00_axi_araddr    (m00_axi_araddr),
        .m00_axi_arlen     (m00_axi_arlen),
        .m00_axi_arsize    (m00_axi_arsize),
        .m00_axi_arburst   (m00_axi_arburst),
        .m00_axi_arlock    (m00_axi_arlock),
        .m00_axi_arcache   (m00_axi_arcache),
        .m00_axi_arprot    (m00_axi_arprot),
        .m00_axi_arqos     (m00_axi_arqos),
        .m00_axi_aruser    (m00_axi_aruser),
        .m00_axi_arvalid   (m00_axi_arvalid),
        .m00_axi_arready   (m00_axi_arready),
        .m00_axi_rid       (m00_axi_rid),
        .m00_axi_rdata     (m00_axi_rdata),
        .m00_axi_rresp     (m00_axi_rresp),
        .m00_axi_rlast     (m00_axi_rlast),
        .m00_axi_ruser     (m00_axi_ruser),
        .m00_axi_rvalid    (m00_axi_rvalid),
        .m00_axi_rready    (m00_axi_rready),

        // Ports of Axi Master Bus Interface M01_AXI
        .m01_axi_aclk      (m00_m01_axi_aclk),
        .m01_axi_aresetn   (m00_m01_axi_aresetn),
        .m01_axi_awid      (m01_axi_awid),
        .m01_axi_awaddr    (m01_axi_awaddr),
        .m01_axi_awlen     (m01_axi_awlen),
        .m01_axi_awsize    (m01_axi_awsize),
        .m01_axi_awburst   (m01_axi_awburst),
        .m01_axi_awlock    (m01_axi_awlock),
        .m01_axi_awcache   (m01_axi_awcache),
        .m01_axi_awprot    (m01_axi_awprot),
        .m01_axi_awqos     (m01_axi_awqos),
        .m01_axi_awuser    (m01_axi_awuser),
        .m01_axi_awvalid   (m01_axi_awvalid),
        .m01_axi_awready   (m01_axi_awready),
        .m01_axi_wdata     (m01_axi_wdata),
        .m01_axi_wstrb     (m01_axi_wstrb),
        .m01_axi_wlast     (m01_axi_wlast),
        .m01_axi_wuser     (m01_axi_wuser),
        .m01_axi_wvalid    (m01_axi_wvalid),
        .m01_axi_wready    (m01_axi_wready),
        .m01_axi_bid       (m01_axi_bid),
        .m01_axi_bresp     (m01_axi_bresp),
        .m01_axi_buser     (m01_axi_buser),
        .m01_axi_bvalid    (m01_axi_bvalid),
        .m01_axi_bready    (m01_axi_bready),
        .m01_axi_arid      (m01_axi_arid),
        .m01_axi_araddr    (m01_axi_araddr),
        .m01_axi_arlen     (m01_axi_arlen),
        .m01_axi_arsize    (m01_axi_arsize),
        .m01_axi_arburst   (m01_axi_arburst),
        .m01_axi_arlock    (m01_axi_arlock),
        .m01_axi_arcache   (m01_axi_arcache),
        .m01_axi_arprot    (m01_axi_arprot),
        .m01_axi_arqos     (m01_axi_arqos),
        .m01_axi_aruser    (m01_axi_aruser),
        .m01_axi_arvalid   (m01_axi_arvalid),
        .m01_axi_arready   (m01_axi_arready),
        .m01_axi_rid       (m01_axi_rid),
        .m01_axi_rdata     (m01_axi_rdata),
        .m01_axi_rresp     (m01_axi_rresp),
        .m01_axi_rlast     (m01_axi_rlast),
        .m01_axi_ruser     (m01_axi_ruser),
        .m01_axi_rvalid    (m01_axi_rvalid),
        .m01_axi_rready    (m01_axi_rready),

        .boot_addr_i       (boot_addr_i),
        .irq_software_i    (irq_software_i),
        .irq_timer_i       (irq_timer_i),
        .irq_external_i    (irq_external_i),
        .irq_fast_i        (irq_fast_i),
        .irq_nm_i          (irq_nm_i)       // non-maskeable interrupt
    );

    endmodule
