/**
 * Universidade Federal Rural de Pernambuco
 * Departamento de Estatística e Informática
 * Disciplina: Arquitetura e Organização de Computadores
 * 
 * Controle da ULA
 *
 * @author André Aziz (andre.caraujo@ufrpe.br)
 */
 
// OP para o controle da ula
`define ALUOP_0   4'b0000 // SOMA
`define ALUOP_1   4'b0001 // OR
`define ALUOP_2   4'b0010 // PARA INSTRUCOES TIPO R
`define ALUOP_3   4'b0011 // AND
`define ALUOP_4   4'b0100 // BEQ
`define ALUOP_5   4'b0101 // BNE
`define ALUOP_6   4'b0110 // Set Less (SLT, SLTI, SLTIU, SLTU)
`define ALUOP_7   4'b0111 // LUI
`define ALUOP_8   4'b1000 // LBU
`define ALUOP_9   4'b1001 // LHU
`define ALUOP_A   4'b1010 // LW
`define ALUOP_B   4'b1011 // SB
`define ALUOP_C   4'b1100 // SH
`define ALUOP_D   4'b1101 // SW
`define ALUOP_E   4'b1110 // J
`define ALUOP_F   4'b1111 // JAL

// FUNCT das instruções tipo R
`define FUNCT_ADD   6'b100000
`define FUNCT_ADDU  6'b100001
`define FUNCT_AND   6'b100100
`define FUNCT_JR    6'b001000
`define FUNCT_NOR   6'b100111
`define FUNCT_OR    6'b100101
`define FUNCT_SLT   6'b101010
`define FUNCT_SLTU  6'b101011
`define FUNCT_SLL   6'b000000
`define FUNCT_SRL   6'b000010
`define FUNCT_SUB   6'b100010
`define FUNCT_SUBU  6'b100011

// OP code final que define a operação da ula
`define OP_AND  5'b00000 //   A & B
`define OP_OR   5'b00001 //   A | B
`define OP_SOMA 5'b00010 //   A + B
`define OP_JR   5'b00011 //   
`define OP_BEQ  5'b00100 //   Zero = (A == B)? 1:0
`define OP_BNE  5'b00101 //   Zero = (A != B)? 1:0
`define OP_SUB  5'b00110 //   A - B
`define OP_SLT  5'b00111 //   (A < B)? 1:0 
`define OP_LUI  5'b01000 //   B << 16
`define OP_SLL  5'b01001 //   A << B
`define OP_SRL  5'b01010 //   A >> B
`define OP_NOR  5'b01011 //   ~(A | B)
`define OP_LBU  5'b01100 // load byte word unsigned (LBU)
`define OP_LHU  5'b01101 // load half word unsigned (LHU)
`define OP_LW   5'b01110 // load word               (LW)
`define OP_SB   5'b01111 // store byte              (SB)
`define OP_SH   5'b10000 // store half              (SH)
`define OP_SW   5'b10001 // store word              (SW)
`define OP_J    5'b10010 // jump                    (J)
`define OP_JAL  5'b10011 // jump and link           (JAL)


module ALU_CONTROL (
  funct,
  op,
  control
);

input funct;
input op;
output control;

wire [5:0] funct;
wire [3:0] op;    // FOI ESTENDIDO PARA 4 BITS PARA PODER MANIPULAR MAIS INSTRUCOES
wire [3:0] control;

assign control = (op == `ALUOP_0) ? `OP_SOMA :                                 // ADDI e ADDIU
                 (op == `ALUOP_3) ? `OP_AND :                                  // ANDI
                 (op == `ALUOP_4) ? `OP_BEQ :                                  // BEQ
                 (op == `ALUOP_5) ? `OP_BNE :                                  // BNE
                 (op == `ALUOP_E) ? `OP_J :                                    // J         FALTA FAZER NA ULA
                 (op == `ALUOP_F) ? `OP_JAL :                                  // JAL       FALTA FAZER NA ULA
                 (op == `ALUOP_8) ? `OP_LHU :                                  // LBU       FALTA FAZER NA ULA
                 (op == `ALUOP_9) ? `OP_LBU :                                  // LHU       FALTA FAZER NA ULA
                 (op == `ALUOP_7) ? `OP_LUI :                                  // LUI
                 (op == `ALUOP_A) ? `OP_LW :                                   // LW
                 (op == `ALUOP_1) ? `OP_OR :                                   // ORI
                 (op == `ALUOP_6) ? `OP_SLT :                                  // SLTI e SLTIU
                 (op == `ALUOP_B) ? `OP_SB :                                   // SB        FALTA FAZER NA ULA
                 (op == `ALUOP_C) ? `OP_SH :                                   // SH        FALTA FAZER NA ULA
                 (op == `ALUOP_D) ? `OP_SW :                                   // SW        FALTA FAZER NA ULA
                 (op == `ALUOP_2 && funct == `FUNCT_ADD)  ? `OP_SOMA :         // ADD
                 (op == `ALUOP_2 && funct == `FUNCT_ADDU) ? `OP_SOMA :         // ADDU
                 (op == `ALUOP_2 && funct == `FUNCT_AND)  ? `OP_AND :          // AND
                 (op == `ALUOP_2 && funct == `FUNCT_JR)   ? `OP_JR :           // JR        FALTA FAZER NA ULA
                 (op == `ALUOP_2 && funct == `FUNCT_NOR)  ? `OP_NOR :          // NOR
                 (op == `ALUOP_2 && funct == `FUNCT_OR)   ? `OP_OR :           // OR                  
                 (op == `ALUOP_2 && funct == `FUNCT_SLT)  ? `OP_SLT :          // SLT
                 (op == `ALUOP_2 && funct == `FUNCT_SLTU) ? `OP_SLT :          // SLTU
                 (op == `ALUOP_2 && funct == `FUNCT_SLL)  ? `OP_SLL :          // SLL
                 (op == `ALUOP_2 && funct == `FUNCT_SRL)  ? `OP_SRL :          // SRL
                 (op == `ALUOP_2 && funct == `FUNCT_SUB)  ? `OP_SUB :          // SUB
                 (op == `ALUOP_2 && funct == `FUNCT_SUBU) ? `OP_SUB :          // SUBU
                 `OP_AND; // default
        

endmodule