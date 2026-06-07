module apb_slave #(
    parameter ADDR_WIDTH = 8,
    parameter DATA_WIDTH = 32,
    parameter DEPTH      = 256,
    parameter WAIT_CYCLES = 2
)(
    input  logic                    PCLK,
    input  logic                    PRESETn,

    input  logic                    PSEL,
    input  logic                    PENABLE,
    input  logic                    PWRITE,
    input  logic [ADDR_WIDTH-1:0]   PADDR,
    input  logic [DATA_WIDTH-1:0]   PWDATA,

    output logic [DATA_WIDTH-1:0]   PRDATA,
    output logic                    PREADY,
    output logic                    PSLVERR
);

logic [DATA_WIDTH-1:0] mem [0:DEPTH-1];

localparam CNT_W = (WAIT_CYCLES > 0) ?
                   $clog2(WAIT_CYCLES + 1) : 1;

logic [CNT_W-1:0] wait_count;

integer i;

wire access_phase;

assign access_phase = PSEL && PENABLE;

always_ff @(posedge PCLK or negedge PRESETn) begin

    if(!PRESETn) begin

        PREADY     <= 1'b0;
        PSLVERR    <= 1'b0;
        PRDATA     <= '0;
        wait_count <= '0;

        for(i=0;i<DEPTH;i=i+1)
            mem[i] <= '0;

    end
    else begin

        PREADY  <= 1'b0;
        PSLVERR <= 1'b0;

        if(access_phase) begin

            if(wait_count < WAIT_CYCLES) begin
                wait_count <= wait_count + 1'b1;
            end
            else begin

                wait_count <= '0;
                PREADY     <= 1'b1;

                if(PADDR >= DEPTH) begin
                    PSLVERR <= 1'b1;
                end
                else begin

                    if(PWRITE)
                        mem[PADDR] <= PWDATA;
                    else
                        PRDATA <= mem[PADDR];

                end
            end
        end
        else begin
            wait_count <= '0;
        end
    end
end

endmodule
