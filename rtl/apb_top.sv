module apb_top #(
  parameter ADDR_WIDTH=8,
  parameter DATA_WIDTH=32,
  parameter DEPTH=256,
  parameter WAIT_CYCLES=2
  )
  (
  input logic PCLK,PRESETn,
  input logic start,write,
  input logic [ADDR_WIDTH-1:0]addr,
  input logic [DATA_WIDTH-1:0]wdata,
  output logic [DATA_WIDTH-1:0]rdata,
  output logic done,
  output logic error
);
  logic PSEL,PENABLE,PWRITE;
  logic [ADDR_WIDTH-1:0]PADDR;
  logic [DATA_WIDTH-1:0]PWDATA,PRDATA;
  logic PREAD,PSLVERR;
  
  apb_master #(
    .ADDR_WIDTH(ADDR_WIDTH),
    .DATA_WIDTH(DATA_WIDTH)
  ) master (
    .*
  );
  
  apb_slave #(
    .ADDR_WIDTH(ADDR_WIDTH),
    .DATA_WIDTH(DATA_WIDTH),
    .DEPTH(DEPTH),
    .WAIT_CYCLES(WAIT_CYCLES)
  ) slave (
    .PCLK(PCLK), .PRESETn(PRESETn),
    .PSEL(PSEL), .PENABLE(PENABLE),
    .PWRITE(PWRITE), .PADDR(PADDR),
    .PWDATA(PWDATA), .PRDATA(PRDATA),
    .PREADY(PREADY), .PSLVERR(PSLVERR)
  );
  
endmodule
