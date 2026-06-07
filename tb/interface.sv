interface apb_if #(parameter ADDR_WIDTH=8,
                   DATA_WIDTH=32)
                  (input logic PCLK);

   logic PRESETn;

  
   logic start;
   logic write;

   logic [ADDR_WIDTH-1:0] addr;
   logic [DATA_WIDTH-1:0] wdata;

   logic [DATA_WIDTH-1:0] rdata;
   logic done;
   logic error;

   
   logic PSEL;
   logic PENABLE;
   logic PWRITE;

   logic [ADDR_WIDTH-1:0] PADDR;
   logic [DATA_WIDTH-1:0] PWDATA;

   logic [DATA_WIDTH-1:0] PRDATA;

   logic PREADY;
   logic PSLVERR;

endinterface
