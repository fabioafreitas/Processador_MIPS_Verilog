/**
 * Universidade Federal Rural de Pernambuco
 * Departamento de Estatística e Informática
 * Disciplina: Arquitetura e Organização de Computadores
 * 
 * Controle da ULA
 *
 * @author André Aziz (andre.caraujo@ufrpe.br)
 */
 
//// OP para o controle da ula
//`define ALUOP_0   2'b00
//`define ALUOP_1   2'b01 
//`define ALUOP_2   2'b10 
//`define ALUOP_3   2'b11 // OPERAÇÕES TIPO R

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
`define OP_AND           4'b0000 //   A & B
`define OP_OR            4'b0001 //   A | B
`define OP_SOMA          4'b0010 //   A + B
`define OP_ATRIBUICAO    4'b0011 //   A = B, A recebe B
`define OP_4            4'b0100
`define OP_5            4'b0101
`define OP_SUBTRACAO     4'b0110 //   A - B
`define OP_MENORQUE      4'b0111 //   A < B
`define OP_8            4'b1000
`define OP_MULTIPLICACAO 4'b1001 //   A << B
`define OP_DIVISAO       4'b1010 //   A >> B
`define OP_11            4'b1011
`define OP_NOR           4'b1100 // ~(A | B)  
`define OP_13            4'b1101
`define OP_14            4'b1110
`define OP_15            4'b1111

module ALU_CONTROL (
  funct,
  op,
  control
);

input funct;
input op;
output control;

wire [5:0] funct;
wire [1:0] op;
wire [3:0] control;

// neccerário usar assign, pois always@(*) não permite uso de Wire
// Este assign representa um grande switch feito com operador ternário
// FALTA ADICIONAR AS DEMAIS OPERAÇÕES
// REVISAR TODAS AS INSTRUÇÕES DEPOIS
assign control = (op == 2'b00) ? OP_SOMA :                                  // ADDI, ADDIU
                 //(op == ALUOP_) ? OP_ :                                       // ANDI
                 (op == 2'b01) ? OP_SUBTRACAO :                             // BEQ
                 //(op == ALUOP_) ? OP_ :                                       // BNE
//                 (op == ALUOP_) ? OP_ :                                       // J
//                 (op == ALUOP_) ? OP_ :                                       // JAL
//                 (op == ALUOP_) ? OP_ :                                       // LBU
//                 (op == ALUOP_) ? OP_ :                                       // LHU
//                 (op == ALUOP_) ? OP_ :                                       // LUI
//                 (op == ALUOP_) ? OP_ :                                       // LW
//                 (op == ALUOP_) ? OP_ :                                       // ORI
//                 (op == ALUOP_) ? OP_ :                                       // SLTI
//                 (op == ALUOP_) ? OP_ :                                       // SLTIU
//                 (op == ALUOP_) ? OP_ :                                       // SB
//                 (op == ALUOP_) ? OP_ :                                       // SH
//                 (op == ALUOP_) ? OP_ :                                       // SW
 
                 (op == 2'b11 && funct == FUNCT_ADD)  ? OP_SOMA :           // ADD
                 (op == 2'b11 && funct == FUNCT_ADDU) ? OP_SOMA :           // ADDU
                 (op == 2'b11 && funct == FUNCT_ADD)  ? OP_ATRIBUICAO :     // JR
                 (op == 2'b11 && funct == FUNCT_JR)   ? OP_ATRIBUICAO :     // AND
                 (op == 2'b11 && funct == FUNCT_NOR)  ? OP_NOR :            // NOR
                 (op == 2'b11 && funct == FUNCT_OR)   ? OP_OR :             // OR                  
                 (op == 2'b11 && funct == FUNCT_SLT)  ? OP_MENORQUE :       // SLT
                 (op == 2'b11 && funct == FUNCT_SLTU) ? OP_MENORQUE :       // SLTU
                 (op == 2'b11 && funct == FUNCT_SLL)  ? OP_MULTIPLICACAO :  // SLL
                 (op == 2'b11 && funct == FUNCT_SRL)  ? OP_DIVISAO :        // SRL
                 (op == 2'b11 && funct == FUNCT_SUB)  ? OP_SUBTRACAO :      // SUB
                 (op == 2'b11 && funct == FUNCT_SUBU) ? OP_SUBTRACAO :      // SUBU
 
 //              (op == 2'b10 && funct == TODAS AS FUNCT DO TIPO R
                  OP_AND; // default

endmodule
