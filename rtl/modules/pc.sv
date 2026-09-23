import riscv_pkg::*;

module pc (
    input  logic            clk,
    input  logic            reset,
    input  logic [XLEN-1:0] pc_next,
    output logic [XLEN-1:0] pc_out
);

  always_ff @(posedge clk, posedge reset)
    if (reset) pc_out <= '0;
    else pc_out <= pc_next;

endmodule
