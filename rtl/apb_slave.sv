module apb_slave #(
  parameter ADDR_WIDTH=8,
  parameter DATA_WIDTH=32,
  parameter DEPTH=256,
  parameter WAIT_CYCLES=2
  )
  (
  input logic PCLK,PRESETn,
  input logic PSEL,PENABLE,PWRITE,
  input logic [ADDR_WIDTH-1:0]PADDR,
  input logic [DATA_WIDTH-1:0]PWDATA,
    
  output logic [DATA_WIDTH-1:0]PRDATA,
  output logic PREADY,
  output logic PSLVERR
);
  logic [DATA_WIDTH-1:0]mem[0:DEPTH-1];
  integer wait_count;
  
  always_ff @(posedge PCLK or negedge PRESETn) begin
    if(!PRESETn) begin
      PREADY<=0;
      PSLVERR<=0;
      wait_count<=0;
    end 
    else begin
      if(PSEL && PENABLE) begin
        if(wait_count<WAIT_CYCLES) begin
          wait_count<=wait_count+1;
          PREADY<=1;
        end
        else begin
          wait_count<=0;
          PREADY<=1;
          if(PADDR>=DEPTH) begin
            PSLVERR<=1;
          end
          else begin
            PSLVERR<=0;
            if(PWRITE)
              mem[PADDR]<=PWDATA;
            else
              PRDATA<=mem[PADDR];
          end
        end
      end
      else begin
        PREADY<=0;
        PSLVERR<=0;
        wait_count<=0;
      end
    end
  end
  
endmodule
