import riscv_pkg::*;

module alu (
    input  logic [XLEN-1:0]       alu_in1,
    input  logic [XLEN-1:0]       alu_in2,
    input  alu_control_t          alu_control,

    output logic [XLEN-1:0]       alu_out,
    output logic                  zero
);

    localparam int SHIFT_BITS = $clog2(XLEN);

  always_comb begin
    unique case (alu_control)
      ALU_ADD:    result = alu_in1 + alu_in2;
      ALU_SUB:    result = alu_in1 + ~alu_in2 + (XLEN)'b1;
      ALU_AND:    result = alu_in1 & alu_in2;
      ALU_OR:     result = alu_in1 | alu_in2;
      ALU_XOR:    result = alu_in1 ^ alu_in2;
      ALU_SLT:    result = XLEN'($signed(alu_in1) < $signed(alu_in2));
      ALU_SLTU:   result = XLEN'(alu_in1 < alu_in2);
      ALU_SLL:    result = alu_in1 << alu_in2[SHIFT_BITS-1:0];
      ALU_SRL:    result = alu_in1 >> alu_in2[SHIFT_BITS-1:0];
      ALU_SRA:    result = $signed(alu_in1) >>> alu_in2[SHIFT_BITS-1:0];
      ALU_PASS_B: result = alu_in2;
      default:    result = '0;
    endcase
  end

  assign zero = (result == '0);

endmodule
