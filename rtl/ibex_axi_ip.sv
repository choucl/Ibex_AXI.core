`timescale 1 ns / 1 ps

    module ibex_axi_ip import ibex_pkg::*; #
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
        parameter integer C_M01_AXI_BUSER_WIDTH     = 0
    )
    (
        // Ports of Axi Master Bus Interface M00_AXI
        input  logic                                m00_axi_aclk,
        input  logic                                m00_axi_aresetn,
        output logic [C_M00_AXI_ID_WIDTH-1 : 0]     m00_axi_awid,
        output logic [C_M00_AXI_ADDR_WIDTH-1 : 0]   m00_axi_awaddr,
        output logic [7 : 0]                        m00_axi_awlen,
        output logic [2 : 0]                        m00_axi_awsize,
        output logic [1 : 0]                        m00_axi_awburst,
        output logic                                m00_axi_awlock,
        output logic [3 : 0]                        m00_axi_awcache,
        output logic [2 : 0]                        m00_axi_awprot,
        output logic [3 : 0]                        m00_axi_awqos,
        output logic [C_M00_AXI_AWUSER_WIDTH-1 : 0] m00_axi_awuser,
        output logic                                m00_axi_awvalid,
        input  logic                                m00_axi_awready,
        output logic [C_M00_AXI_DATA_WIDTH-1 : 0]   m00_axi_wdata,
        output logic [C_M00_AXI_DATA_WIDTH/8-1 : 0] m00_axi_wstrb,
        output logic                                m00_axi_wlast,
        output logic [C_M00_AXI_WUSER_WIDTH-1 : 0]  m00_axi_wuser,
        output logic                                m00_axi_wvalid,
        input  logic                                m00_axi_wready,
        input  logic [C_M00_AXI_ID_WIDTH-1 : 0]     m00_axi_bid,
        input  logic [1 : 0]                        m00_axi_bresp,
        input  logic [C_M00_AXI_BUSER_WIDTH-1 : 0]  m00_axi_buser,
        input  logic                                m00_axi_bvalid,
        output logic                                m00_axi_bready,
        output logic [C_M00_AXI_ID_WIDTH-1 : 0]     m00_axi_arid,
        output logic [C_M00_AXI_ADDR_WIDTH-1 : 0]   m00_axi_araddr,
        output logic [7 : 0]                        m00_axi_arlen,
        output logic [2 : 0]                        m00_axi_arsize,
        output logic [1 : 0]                        m00_axi_arburst,
        output logic                                m00_axi_arlock,
        output logic [3 : 0]                        m00_axi_arcache,
        output logic [2 : 0]                        m00_axi_arprot,
        output logic [3 : 0]                        m00_axi_arqos,
        output logic [C_M00_AXI_ARUSER_WIDTH-1 : 0] m00_axi_aruser,
        output logic                                m00_axi_arvalid,
        input  logic                                m00_axi_arready,
        input  logic [C_M00_AXI_ID_WIDTH-1 : 0]     m00_axi_rid,
        input  logic [C_M00_AXI_DATA_WIDTH-1 : 0]   m00_axi_rdata,
        input  logic [1 : 0]                        m00_axi_rresp,
        input  logic                                m00_axi_rlast,
        input  logic [C_M00_AXI_RUSER_WIDTH-1 : 0]  m00_axi_ruser,
        input  logic                                m00_axi_rvalid,
        output logic                                m00_axi_rready,

        // Ports of Axi Master Bus Interface M01_AXI
        input  logic                                m01_axi_aclk,
        input  logic                                m01_axi_aresetn,
        output logic [C_M00_AXI_ID_WIDTH-1 : 0]     m01_axi_awid,
        output logic [C_M00_AXI_ADDR_WIDTH-1 : 0]   m01_axi_awaddr,
        output logic [7 : 0]                        m01_axi_awlen,
        output logic [2 : 0]                        m01_axi_awsize,
        output logic [1 : 0]                        m01_axi_awburst,
        output logic                                m01_axi_awlock,
        output logic [3 : 0]                        m01_axi_awcache,
        output logic [2 : 0]                        m01_axi_awprot,
        output logic [3 : 0]                        m01_axi_awqos,
        output logic [C_M00_AXI_AWUSER_WIDTH-1 : 0] m01_axi_awuser,
        output logic                                m01_axi_awvalid,
        input  logic                                m01_axi_awready,
        output logic [C_M00_AXI_DATA_WIDTH-1 : 0]   m01_axi_wdata,
        output logic [C_M00_AXI_DATA_WIDTH/8-1 : 0] m01_axi_wstrb,
        output logic                                m01_axi_wlast,
        output logic [C_M00_AXI_WUSER_WIDTH-1 : 0]  m01_axi_wuser,
        output logic                                m01_axi_wvalid,
        input  logic                                m01_axi_wready,
        input  logic [C_M00_AXI_ID_WIDTH-1 : 0]     m01_axi_bid,
        input  logic [1 : 0]                        m01_axi_bresp,
        input  logic [C_M00_AXI_BUSER_WIDTH-1 : 0]  m01_axi_buser,
        input  logic                                m01_axi_bvalid,
        output logic                                m01_axi_bready,
        output logic [C_M00_AXI_ID_WIDTH-1 : 0]     m01_axi_arid,
        output logic [C_M00_AXI_ADDR_WIDTH-1 : 0]   m01_axi_araddr,
        output logic [7 : 0]                        m01_axi_arlen,
        output logic [2 : 0]                        m01_axi_arsize,
        output logic [1 : 0]                        m01_axi_arburst,
        output logic                                m01_axi_arlock,
        output logic [3 : 0]                        m01_axi_arcache,
        output logic [2 : 0]                        m01_axi_arprot,
        output logic [3 : 0]                        m01_axi_arqos,
        output logic [C_M00_AXI_ARUSER_WIDTH-1 : 0] m01_axi_aruser,
        output logic                                m01_axi_arvalid,
        input  logic                                m01_axi_arready,
        input  logic [C_M00_AXI_ID_WIDTH-1 : 0]     m01_axi_rid,
        input  logic [C_M00_AXI_DATA_WIDTH-1 : 0]   m01_axi_rdata,
        input  logic [1 : 0]                        m01_axi_rresp,
        input  logic                                m01_axi_rlast,
        input  logic [C_M00_AXI_RUSER_WIDTH-1 : 0]  m01_axi_ruser,
        input  logic                                m01_axi_rvalid,
        output logic                                m01_axi_rready,

        input  logic [31:0]                         boot_addr_i,
        // Interrupt inputs
        input  logic                                irq_software_i,
        input  logic                                irq_timer_i,
        input  logic                                irq_external_i,
        input  logic [14:0]                         irq_fast_i,
        input  logic                                irq_nm_i       // non-maskeable interrupt
    );
// Instantiation of Axi Bus Interface M00_AXI

    axi_req_t instr_axi_req;
    axi_rsp_t instr_axi_rsp;
    axi_req_t data_axi_req;
    axi_rsp_t data_axi_rsp;

    // m00 request interface
    assign m00_axi_awid    = instr_axi_req.aw.id;
    assign m00_axi_awaddr  = instr_axi_req.aw.addr;
    assign m00_axi_awlen   = instr_axi_req.aw.len;
    assign m00_axi_awsize  = instr_axi_req.aw.size;
    assign m00_axi_awburst = instr_axi_req.aw.burst;
    assign m00_axi_awlock  = instr_axi_req.aw.lock;
    assign m00_axi_awcache = instr_axi_req.aw.cache;
    assign m00_axi_awprot  = instr_axi_req.aw.prot;
    assign m00_axi_awqos   = instr_axi_req.aw.qos;
    assign m00_axi_awuser  = instr_axi_req.aw.user;
    assign m00_axi_awvalid = instr_axi_req.aw_valid;

    assign m00_axi_wdata   = instr_axi_req.w.data;
    assign m00_axi_wstrb   = instr_axi_req.w.strb;
    assign m00_axi_wlast   = instr_axi_req.w.last;
    assign m00_axi_wuser   = instr_axi_req.w.user;
    assign m00_axi_wvalid  = instr_axi_req.w_valid;

    assign m00_axi_bready  = instr_axi_req.b_ready;

    assign m00_axi_arid    = instr_axi_req.ar.id;
    assign m00_axi_araddr  = instr_axi_req.ar.addr;
    assign m00_axi_arlen   = instr_axi_req.ar.len;
    assign m00_axi_arsize  = instr_axi_req.ar.size;
    assign m00_axi_arburst = instr_axi_req.ar.burst;
    assign m00_axi_arlock  = instr_axi_req.ar.lock;
    assign m00_axi_arcache = instr_axi_req.ar.cache;
    assign m00_axi_arprot  = instr_axi_req.ar.prot;
    assign m00_axi_arqos   = instr_axi_req.ar.qos;
    assign m00_axi_aruser  = instr_axi_req.ar.user;
    assign m00_axi_arvalid = instr_axi_req.ar_valid;

    assign m00_axi_rready  = instr_axi_req.r_ready;

    // m00 response interface
    assign instr_axi_rsp.aw_ready = m00_axi_awready;
    assign instr_axi_rsp.ar_ready = m00_axi_arready;
    assign instr_axi_rsp.w_ready  = m00_axi_wready;

    assign instr_axi_rsp.b.id     = m00_axi_bid;
    assign instr_axi_rsp.b.resp   = m00_axi_bresp;
    assign instr_axi_rsp.b.user   = m00_axi_buser;
    assign instr_axi_rsp.b_valid  = m00_axi_bvalid;

    assign instr_axi_rsp.r.id     = m00_axi_rid;
    assign instr_axi_rsp.r.data   = m00_axi_rdata;
    assign instr_axi_rsp.r.resp   = m00_axi_rresp;
    assign instr_axi_rsp.r.last   = m00_axi_rlast;
    assign instr_axi_rsp.r.user   = m00_axi_ruser;
    assign instr_axi_rsp.r_valid  = m00_axi_rvalid;

    // m01 request interface
    assign m01_axi_awid    = data_axi_req.aw.id;
    assign m01_axi_awaddr  = data_axi_req.aw.addr;
    assign m01_axi_awlen   = data_axi_req.aw.len;
    assign m01_axi_awsize  = data_axi_req.aw.size;
    assign m01_axi_awburst = data_axi_req.aw.burst;
    assign m01_axi_awlock  = data_axi_req.aw.lock;
    assign m01_axi_awcache = data_axi_req.aw.cache;
    assign m01_axi_awprot  = data_axi_req.aw.prot;
    assign m01_axi_awqos   = data_axi_req.aw.qos;
    assign m01_axi_awuser  = data_axi_req.aw.user;
    assign m01_axi_awvalid = data_axi_req.aw_valid;

    assign m01_axi_wdata   = data_axi_req.w.data;
    assign m01_axi_wstrb   = data_axi_req.w.strb;
    assign m01_axi_wlast   = data_axi_req.w.last;
    assign m01_axi_wuser   = data_axi_req.w.user;
    assign m01_axi_wvalid  = data_axi_req.w_valid;

    assign m01_axi_bready  = data_axi_req.b_ready;

    assign m01_axi_arid    = data_axi_req.ar.id;
    assign m01_axi_araddr  = data_axi_req.ar.addr;
    assign m01_axi_arlen   = data_axi_req.ar.len;
    assign m01_axi_arsize  = data_axi_req.ar.size;
    assign m01_axi_arburst = data_axi_req.ar.burst;
    assign m01_axi_arlock  = data_axi_req.ar.lock;
    assign m01_axi_arcache = data_axi_req.ar.cache;
    assign m01_axi_arprot  = data_axi_req.ar.prot;
    assign m01_axi_arqos   = data_axi_req.ar.qos;
    assign m01_axi_aruser  = data_axi_req.ar.user;
    assign m01_axi_arvalid = data_axi_req.ar_valid;

    assign m01_axi_rready  = data_axi_req.r_ready;

    // m01 response interface
    assign data_axi_rsp.aw_ready = m01_axi_awready;
    assign data_axi_rsp.ar_ready = m01_axi_arready;
    assign data_axi_rsp.w_ready  = m01_axi_wready;

    assign data_axi_rsp.b.id     = m01_axi_bid;
    assign data_axi_rsp.b.resp   = m01_axi_bresp;
    assign data_axi_rsp.b.user   = m01_axi_buser;
    assign data_axi_rsp.b_valid  = m01_axi_bvalid;

    assign data_axi_rsp.r.id     = m01_axi_rid;
    assign data_axi_rsp.r.data   = m01_axi_rdata;
    assign data_axi_rsp.r.resp   = m01_axi_rresp;
    assign data_axi_rsp.r.last   = m01_axi_rlast;
    assign data_axi_rsp.r.user   = m01_axi_ruser;
    assign data_axi_rsp.r_valid  = m01_axi_rvalid;

    ibex_axi # (
      .axi_req_t (axi_req_t),
      .axi_rsp_t (axi_rsp_t)
    ) ibex_axi_i (
      .clk_i                  (m00_axi_aclk),
      .rst_ni                 (m00_axi_aresetn),

      .boot_addr_i            (boot_addr_i),

      .instr_axi_req_o        (instr_axi_req),
      .instr_axi_rsp_i        (instr_axi_rsp),

      .data_axi_req_o         (data_axi_req),
      .data_axi_rsp_i         (data_axi_rsp),

      .irq_software_i         (irq_software_i),
      .irq_timer_i            (irq_timer_i),
      .irq_external_i         (irq_external_i),
      .irq_fast_i             (irq_fast_i),
      .irq_nm_i               (irq_nm_i)       // non-maskeable interrupt
    );
    endmodule
