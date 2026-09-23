import riscv_pkg::*;

module imem #(
    parameter int unsigned DEPTH      = 1024,  // up to 2^(32-2)
    parameter string       MEM_INIT_F = ""     // file path of instructions in hexadecimal
) (
    input  logic [XLEN-1:0] pc_addr,
    output logic [XLEN-1:0] instr
);

  logic [XLEN-1:0] rom[DEPTH];

  initial begin
    if (MEM_INIT_F != "") $readmemh(MEM_INIT_F, rom);
    else for (int i = 0; i < DEPTH; i++) rom[i] = 32'h0000_0013;  // NOP
  end

  // Word-aligned addressing
  localparam int WordAddrWidth = $clog2(DEPTH);
  logic [WordAddrWidth-1:0] word_addr;
  assign word_addr = pc_addr[WordAddrWidth+1:2];

  assign instr = rom[word_addr];

endmodule
