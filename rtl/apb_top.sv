module apb_top #(
    parameter ADDR_WIDTH = 8,
    parameter DATA_WIDTH = 32,
    parameter DEPTH = 256,
    parameter WAIT_CYCLES = 2
)(
    input  logic                    PCLK,
    input  logic                    PRESETn,

    input  logic                    start,
    input  logic                    write,
    input  logic [ADDR_WIDTH-1:0]   addr,
    input  logic [DATA_WIDTH-1:0]   wdata,

    output logic [DATA_WIDTH-1:0]   rdata,
    output logic                    done,
    output logic                    error,
  
   output logic PSEL,
   output logic PENABLE,
   output logic PWRITE,

   output logic [7:0] PADDR,
   output logic [31:0] PWDATA,

   output logic [31:0] PRDATA,
   output logic PREADY,
   output logic PSLVERR
);



apb_master #(
    .ADDR_WIDTH(ADDR_WIDTH),
    .DATA_WIDTH(DATA_WIDTH)
) u_master (

    .PCLK(PCLK),
    .PRESETn(PRESETn),

    .PSEL(PSEL),
    .PENABLE(PENABLE),
    .PWRITE(PWRITE),

    .PADDR(PADDR),
    .PWDATA(PWDATA),

    .PRDATA(PRDATA),
    .PREADY(PREADY),
    .PSLVERR(PSLVERR),

    .start(start),
    .write(write),
    .addr(addr),
    .wdata(wdata),

    .rdata(rdata),
    .done(done),
    .error(error)
);

apb_slave #(
    .ADDR_WIDTH(ADDR_WIDTH),
    .DATA_WIDTH(DATA_WIDTH),
    .DEPTH(DEPTH),
    .WAIT_CYCLES(WAIT_CYCLES)
) u_slave (

    .PCLK(PCLK),
    .PRESETn(PRESETn),

    .PSEL(PSEL),
    .PENABLE(PENABLE),
    .PWRITE(PWRITE),

    .PADDR(PADDR),
    .PWDATA(PWDATA),

    .PRDATA(PRDATA),
    .PREADY(PREADY),
    .PSLVERR(PSLVERR)
);

endmodule
