/**
 * Universidade Federal Rural de Pernambuco
 * Departamento de Estat�stica e Inform�tica
 * Disciplina: Arquitetura e Organiza��o de Computadores
 * 
 * Controle
 *
 * @author Andr� Aziz (andre.caraujo@ufrpe.br)
 */

// OPCODE
`define OPCODE_TIPO_R 6'b000000 // diferenciar pelo campo FUNCT bits[5:0] na ALU Control
`define OPCODE_ADDI   6'b001000
`define OPCODE_ADDIU  6'b001001
`define OPCODE_ANDI   6'b001100
`define OPCODE_BEQ    6'b000100
`define OPCODE_BNE    6'b000101
`define OPCODE_J      6'b000010
`define OPCODE_JAL    6'b000011
`define OPCODE_LBU    6'b100100
`define OPCODE_LHU    6'b100101
//`define OPCODE_LL     6'b110000
`define OPCODE_LUI    6'b001111
`define OPCODE_LW     6'b100011
`define OPCODE_ORI    6'b001101
`define OPCODE_SLTI   6'b001010
`define OPCODE_SLTIU  6'b001011
`define OPCODE_SB     6'b101000
//`define OPCODE_SC     6'b111000
`define OPCODE_SH     6'b101001
`define OPCODE_SW     6'b101011


// OP da ULA
// INDICAR OS OPCODES RESTANTES PARA AS DEMAIS INTRU��ES TIPO I, NO ALU_CONTROL
`define ALUOP_SOMA      4'b0000  // add, addi, addiu
`define ALUOP_ORI       4'b0001  // ori
`define ALUOP_TIPO_R    4'b0010  // todas as intru��es tipo R
`define ALUOP_ANDI      4'b0011  // andi
`define ALUOP_BEQ       4'b0100  // beq
`define ALUOP_BNE       4'b0101  // bne
`define ALUOP_SLT       4'b0110  // slt, slti, sltiu, sltu
`define ALUOP_LUI       4'b0111  // lui
`define ALUOP_LBU       4'b1000  // blu
`define ALUOP_LHU       4'b1001  // lhu
`define ALUOP_LW        4'b1010  // lw
`define ALUOP_SB        4'b1011  // sb
`define ALUOP_SH        4'b1100  // sh
`define ALUOP_SW        4'b1101  // sw
`define ALUOP_J         4'b1110  // ainda nao foi utilizado
`define ALUOP_JAL       4'b1111  // ainda nao foi utilizado

module CONTROL(
  nrst,
  opcode,
  branch,
  read_mem,
  write_mem,
  write_reg,
  mux_write_rt_rd,
  mux_alu_src_reg_imm,
  alu_op,
  mux_branch_jump,
  mux_pc_branch,
  mux_reg_src_alu_mem
);

input nrst;
input opcode;
output branch;
output read_mem;
output write_mem;
output write_reg;
output  mux_write_rt_rd;
output mux_alu_src_reg_imm;
output alu_op;
output mux_branch_jump;
output mux_pc_branch;
output mux_reg_src_alu_mem;

wire nrst;
wire [5:0] opcode;
reg branch;
reg read_mem;
reg write_mem;
reg write_reg;
reg  mux_write_rt_rd;
reg mux_alu_src_reg_imm;
reg [3:0] alu_op;    // FOI ESTENDIDO PARA 4 BITS PARA PODER MANIPULAR MAIS INSTRUCOES
reg mux_branch_jump;
reg mux_pc_branch;
reg mux_reg_src_alu_mem;

initial begin
  branch 		= 0;
  read_mem 		= 0;
  write_mem 		= 0;
  write_reg 		= 0;
  alu_op 		= `ALUOP_TIPO_R;
  mux_write_rt_rd 	= 1;
  mux_alu_src_reg_imm 	= 0;
  mux_branch_jump 	= 1;
  mux_pc_branch 	= 0;
  mux_reg_src_alu_mem 	= 1;
end

// AS INSTRU��ES TIPO R J� EST�O COM OS FIOS SETADOS CORRETAMENTE
// FALTA SETAR ALGUNS FIOS DAS INSTRU��ES TIPO I E J
always @(nrst, opcode) begin : decode_thread

  if (nrst == 0) begin
    branch 		= 0;
    read_mem 		= 0;
    write_mem 		= 0;
    write_reg 		= 0;
    alu_op 		= `ALUOP_TIPO_R;
    mux_write_rt_rd 	= 1;
    mux_alu_src_reg_imm = 0;
    mux_branch_jump 	= 1;
    mux_pc_branch 	= 0;
    mux_reg_src_alu_mem = 1;  
  end
  else begin
    case (opcode)
 
    `OPCODE_TIPO_R: begin
      branch 			= 0;
      read_mem 			= 0;
      write_mem 		= 0;
      write_reg 		= 1;
      alu_op 			= `ALUOP_TIPO_R;
      mux_write_rt_rd 		= 1;
      mux_alu_src_reg_imm 	= 0;
      mux_branch_jump 		= 1;
      mux_pc_branch 		= 0;
      mux_reg_src_alu_mem 	= 1;  
    end
  
    `OPCODE_ADDI: begin
      branch 			= 0;
      read_mem 			= 0;
      write_mem 		= 0;
      write_reg 		= 1;
      alu_op 			= `ALUOP_SOMA;
      mux_write_rt_rd 		= 0;
      mux_alu_src_reg_imm 	= 1;
      mux_branch_jump 		= 1;
      mux_pc_branch 		= 0;
      mux_reg_src_alu_mem 	= 1;  
    end
  
    `OPCODE_ADDIU: begin
      branch 			= 0;
      read_mem 			= 0;
      write_mem 		= 0;
      write_reg 		= 1;
      alu_op 			= `ALUOP_SOMA;
      mux_write_rt_rd = 0;
      mux_alu_src_reg_imm 	= 1;
      mux_branch_jump 		= 1;
      mux_pc_branch 		= 0;
      mux_reg_src_alu_mem 	= 1;  
    end
    
    `OPCODE_ANDI: begin
      branch 			= 0;
      read_mem 			= 0;
      write_mem 		= 0;  
      write_reg 		= 1;
      alu_op 			= `ALUOP_ANDI;
      mux_write_rt_rd 		= 0;
      mux_alu_src_reg_imm 	= 1;
      mux_branch_jump 		= 1;
      mux_pc_branch 		= 0;
      mux_reg_src_alu_mem 	= 1;  
    end
    
    `OPCODE_BEQ: begin
      branch 			= 1;
      read_mem 			= 0;
      write_mem 		= 0;
      write_reg 		= 0;
      alu_op 			= `ALUOP_BEQ;
      mux_write_rt_rd 		= 0;
      mux_alu_src_reg_imm 	= 0;
      mux_branch_jump 		= 1;
      mux_pc_branch 		= 1;
      mux_reg_src_alu_mem 	= 0;  
    end
    
    `OPCODE_BNE: begin
      branch 			= 1;
      read_mem 			= 0;
      write_mem 		= 0;
      write_reg 		= 0;
      alu_op 			= `ALUOP_BNE;
      mux_write_rt_rd 		= 0;
      mux_alu_src_reg_imm 	= 0;
      mux_branch_jump 		= 1;
      mux_pc_branch 		= 1;
      mux_reg_src_alu_mem 	= 0;
    end
    
    `OPCODE_J: begin
      branch 			= 0;
      read_mem 			= 0;
      write_mem 		= 0;
      write_reg 		= 0;
      alu_op 			= `ALUOP_J;
      mux_write_rt_rd 		= 0;
      mux_alu_src_reg_imm 	= 0;
      mux_branch_jump 		= 0;
      mux_pc_branch 		= 0;
      mux_reg_src_alu_mem 	= 0;  
    end
    
    `OPCODE_JAL: begin
      branch 			= 0;
      read_mem 			= 0;
      write_mem 		= 0;
      write_reg 		= 0;
      alu_op 			= `ALUOP_JAL;
      mux_write_rt_rd 		= 0;
      mux_alu_src_reg_imm 	= 0;
      mux_branch_jump 		= 0;
      mux_pc_branch 		= 0;
      mux_reg_src_alu_mem 	= 0;  
    end
    
    `OPCODE_LBU: begin
//    branch 			= 0;
//    read_mem 			= 0;
//    write_mem 		= 0;
//    write_reg 		= 1;
      alu_op 			= `ALUOP_LBU;
//    mux_write_rt_rd 		= 0;
//    mux_alu_src_reg_imm 	= 1;
//    mux_branch_jump 		= 1;
//    mux_pc_branch 		= 0;
//    mux_reg_src_alu_mem 	= 1;  
    end
    
    `OPCODE_LHU: begin
//    branch 			= 0;
//    read_mem 			= 0;
//    write_mem 		= 0;
//    write_reg 		= 1;
      alu_op 			= `ALUOP_LHU;
//    mux_write_rt_rd 		= 0;
//    mux_alu_src_reg_imm 	= 1;
//    mux_branch_jump 		= 1;
//    mux_pc_branch 		= 0;
//    mux_reg_src_alu_mem 	= 1;  
    end
    
    `OPCODE_LUI: begin
      branch 			= 0;
      read_mem 			= 0;
      write_mem 		= 0;
      write_reg 		= 1;
      alu_op 			= `ALUOP_LUI;
      mux_write_rt_rd 		= 0;
      mux_alu_src_reg_imm 	= 1;
      mux_branch_jump 		= 1;
      mux_pc_branch 		= 0;
      mux_reg_src_alu_mem 	= 1; 
    end
 
    `OPCODE_LW: begin
      branch 			= 0;
      read_mem 			= 1;
      write_mem 		= 0;
      write_reg 		= 1;
      alu_op 			= `ALUOP_LW;   // falta alterar
      mux_write_rt_rd 		= 0;
      mux_alu_src_reg_imm 	= 1;
      mux_branch_jump 		= 1;
      mux_pc_branch 		= 0;
      mux_reg_src_alu_mem 	= 0;  
    end
    
    `OPCODE_ORI: begin
      branch 			= 0;
      read_mem 			= 0;
      write_mem 		= 0;
      write_reg 		= 1;
      alu_op 			= `ALUOP_ORI;
      mux_write_rt_rd 		= 0;
      mux_alu_src_reg_imm 	= 1;
      mux_branch_jump 		= 1;
      mux_pc_branch 		= 0;
      mux_reg_src_alu_mem 	= 1;  
    end
    
    `OPCODE_SLTI: begin
//    branch 			= 0;
//    read_mem 			= 0;
//    write_mem 		= 0;
//    write_reg 		= 1;
      alu_op 			= `ALUOP_SLT;
//    mux_write_rt_rd 		= 0;
//    mux_alu_src_reg_imm 	= 1;
//    mux_branch_jump 		= 1;
//    mux_pc_branch 		= 0;
//    mux_reg_src_alu_mem 	= 1;  
    end
    
    `OPCODE_SLTIU: begin
//    branch 			= 0;
//    read_mem 			= 0;
//    write_mem 		= 0;
//    write_reg 		= 1;
      alu_op 			= `ALUOP_SLT;
//    mux_write_rt_rd 		= 0;
//    mux_alu_src_reg_imm 	= 1;
//    mux_branch_jump 		= 1;
//    mux_pc_branch 		= 0;
//    mux_reg_src_alu_mem 	= 1;  
    end
    
    `OPCODE_SB: begin
//    branch 			= 0;
//    read_mem 			= 0;
//    write_mem 		= 0;
//    write_reg 		= 1;
      alu_op 			= `ALUOP_SB;
//    mux_write_rt_rd 		= 0;
//    mux_alu_src_reg_imm 	= 1;
//    mux_branch_jump 		= 1;
//    mux_pc_branch 		= 0;
//    mux_reg_src_alu_mem 	= 1;  
    end
    
    `OPCODE_SH: begin
//    branch 			= 0;
//    read_mem 			= 0;
//    write_mem 		= 0;
//    write_reg 		= 1;
      alu_op 			= `ALUOP_SH;
//    mux_write_rt_rd 		= 0;
//    mux_alu_src_reg_imm 	= 1;
//    mux_branch_jump 		= 1;
//    mux_pc_branch 		= 0;
//    mux_reg_src_alu_mem 	= 1;  
    end

    `OPCODE_SW: begin
      branch 			= 0;
      read_mem 			= 0;
      write_mem 		= 1;
      write_reg 		= 0;
      alu_op 			= `ALUOP_SW;
      mux_write_rt_rd 		= 0;
      mux_alu_src_reg_imm 	= 1;
      mux_branch_jump 		= 1;
      mux_pc_branch 		= 0;
      mux_reg_src_alu_mem 	= 0;  
    end

    endcase
  end
end

endmodule
