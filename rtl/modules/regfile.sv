import riscv_pkg::*;

module regfile (
    input  logic                  clk,
    input  logic                  reg_write,
    input  logic [REG_ADDR_W-1:0] rd,
    input  logic [REG_ADDR_W-1:0] rs1,
    input  logic [REG_ADDR_W-1:0] rs2,
    input  logic [      XLEN-1:0] write_data,
    output logic [      XLEN-1:0] read_data1,
    output logic [      XLEN-1:0] read_data2
);

  logic [XLEN-1:0] rf[NUM_REGS];

  always_ff @(posedge clk) begin
    if (reg_write && rd != '0) rf[rd] <= write_data;
  end

  assign read_data1 = (rs1 != '0) ? rf[rs1] : '0;
  assign read_data2 = (rs2 != '0) ? rf[rs2] : '0;

endmodule
