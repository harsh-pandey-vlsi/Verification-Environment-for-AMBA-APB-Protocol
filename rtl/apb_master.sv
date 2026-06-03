module apb_master #(
  parameter ADDR_WIDTH = 8,
  parameter DATA_WIDTH = 32
  )
  (
  input logic PCLK,PRESETn,
    
  output logic PSEL,PENABLE,PWRITE,
  output logic [ADDR_WIDTH-1:0]PADDR,
  output logic [DATA_WIDTH-1:0]PWDATA,
    
  input logic [DATA_WIDTH-1:0]PRDATA,
  input logic PREADY,
  input logic PSLVERR,
  
  input logic start,
  input logic write,
  input logic [ADDR_WIDTH-1:0]addr,
  input logic [DATA_WIDTH-1:0]wdata,
    
  output logic [DATA_WIDTH-1:0]rdata,
  output logic done,
  output logic error
);
  
  typedef enum logic [1:0]{IDLE,SETUP,ENABLE}state_t;
  state_t state,next_state;
  
  always_ff @(posedge PCLK or negedge PRESETn) begin
    if(!PRESETn)
      state<=IDLE;
    else
      state<=next_state;
  end
  
  always_comb begin
    next_state = state;
    case(state)
      IDLE:if(start)
        next_state=SETUP;
      SETUP:
        next_state=ENABLE;
      ENABLE:if(PREADY)
        next_state=IDLE;
    endcase
  end
  
  always_ff @(posedge PCLK or negedge PRESETn) begin
    if(!PRESETn) begin
      PSEL<=0;
      PENABLE<=0;
      PWRITE<=0;
      PADDR<=0;
      PWDATA<=0;
      rdata<=0;
      done<=0;
      error<=0;
    end
    else begin
      done<=0;
      case(state)
        IDLE:begin
          PENABLE<=0;
          if(start) begin
            PSEL<=1;
            PWRITE<=write;
            PADDR<=addr;
            PWDATA<=wdata;
          end
          else
            PSEL<=0;
        end
        SETUP:begin
          PENABLE<=1;
        end
        ENABLE:begin
          if(PREADY) begin
            if(!PWRITE)
              rdata<=PRDATA;
            error<=PSLVERR;
            PSEL<=0;
            PENABLE<=0;
            done<=1;
          end
        end
      endcase
    end
  end

endmodule
