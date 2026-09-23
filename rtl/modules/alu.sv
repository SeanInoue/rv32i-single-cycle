import riscv_pkg::*;

module alu (
    input logic         [XLEN-1:0] alu_in1,
    input logic         [XLEN-1:0] alu_in2,
    input alu_control_t            alu_control,

    output logic [XLEN-1:0] alu_out,
    output logic            zero
);

  localparam int ShiftBits = $clog2(XLEN);

  always_comb begin
    unique case (alu_control)
      ALU_ADD:    alu_out = alu_in1 + alu_in2;
      ALU_SUB:    alu_out = alu_in1 + ~alu_in2 + XLEN'(1);
      ALU_AND:    alu_out = alu_in1 & alu_in2;
      ALU_OR:     alu_out = alu_in1 | alu_in2;
      ALU_XOR:    alu_out = alu_in1 ^ alu_in2;
      ALU_SLT:    alu_out = XLEN'($signed(alu_in1) < $signed(alu_in2));
      ALU_SLTU:   alu_out = XLEN'(alu_in1 < alu_in2);
      ALU_SLL:    alu_out = alu_in1 << alu_in2[ShiftBits-1:0];
      ALU_SRL:    alu_out = alu_in1 >> alu_in2[ShiftBits-1:0];
      ALU_SRA:    alu_out = $signed(alu_in1) >>> alu_in2[ShiftBits-1:0];
      ALU_PASS_B: alu_out = alu_in2;
      default:    alu_out = '0;
    endcase
  end

  assign zero = (alu_out == '0);

endmodule
