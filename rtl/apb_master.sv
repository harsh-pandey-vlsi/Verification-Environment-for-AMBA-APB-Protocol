module apb_master #(
    parameter ADDR_WIDTH = 8,
    parameter DATA_WIDTH = 32
)(
    input  logic                    PCLK,
    input  logic                    PRESETn,

    output logic                    PSEL,
    output logic                    PENABLE,
    output logic                    PWRITE,
    output logic [ADDR_WIDTH-1:0]   PADDR,
    output logic [DATA_WIDTH-1:0]   PWDATA,

    input  logic [DATA_WIDTH-1:0]   PRDATA,
    input  logic                    PREADY,
    input  logic                    PSLVERR,

    input  logic                    start,
    input  logic                    write,
    input  logic [ADDR_WIDTH-1:0]   addr,
    input  logic [DATA_WIDTH-1:0]   wdata,

    output logic [DATA_WIDTH-1:0]   rdata,
    output logic                    done,
    output logic                    error
);

typedef enum logic [1:0] {
    IDLE,
    SETUP,
    ACCESS
} state_t;

state_t state, next_state;

always_ff @(posedge PCLK or negedge PRESETn) begin
    if(!PRESETn)
        state <= IDLE;
    else
        state <= next_state;
end

always_comb begin
    next_state = state;

    case(state)

        IDLE: begin
            if(start)
                next_state = SETUP;
        end

        SETUP: begin
            next_state = ACCESS;
        end

        ACCESS: begin
            if(PREADY)
                next_state = IDLE;
        end

        default:
            next_state = IDLE;

    endcase
end

always_ff @(posedge PCLK or negedge PRESETn) begin
    if(!PRESETn) begin
        PADDR   <= '0;
        PWDATA  <= '0;
        PWRITE  <= 1'b0;
    end
    else if(state == IDLE && start) begin
        PADDR   <= addr;
        PWDATA  <= wdata;
        PWRITE  <= write;
    end
end

always_ff @(posedge PCLK or negedge PRESETn) begin
    if(!PRESETn) begin
        rdata <= '0;
        done  <= 1'b0;
        error <= 1'b0;
    end
    else begin

        done  <= 1'b0;
        error <= 1'b0;

        if(state == ACCESS && PREADY) begin

            if(!PWRITE)
                rdata <= PRDATA;

            error <= PSLVERR;
            done  <= 1'b1;
        end
    end
end

always_comb begin

    PSEL    = 1'b0;
    PENABLE = 1'b0;

    case(state)

        SETUP: begin
            PSEL = 1'b1;
        end

        ACCESS: begin
            PSEL    = 1'b1;
            PENABLE = 1'b1;
        end

        default: begin
            PSEL    = 1'b0;
            PENABLE = 1'b0;
        end

    endcase
end

endmodule
