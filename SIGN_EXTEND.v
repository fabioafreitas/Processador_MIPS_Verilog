/**
 * Universidade Federal Rural de Pernambuco
 * Departamento de Estat�stica e Inform�tica
 * Disciplina: Arquitetura e Organiza��o de Computadores
 * 
 * Extensor de singal de 16 para 32 bits.
 *
 * @author Andr� Aziz (andre.caraujo@ufrpe.br)
 */
module SIGN_EXTEND(
  A,
  O
);

input A;
output O;

wire [15:0] A;
wire [31:0] O;

assign O[31:16] = (A[15] == 0) ? 0 : -1;
assign O[15:0] = A;

endmodule
