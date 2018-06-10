/**
 * Universidade Federal Rural de Pernambuco
 * Departamento de Estat�stica e Inform�tica
 * Disciplina: Arquitetura e Organiza��o de Computadores
 * 
 * Somador de 32 bits.
 *
 * @author Andr� Aziz (andre.caraujo@ufrpe.br)
 */
module ADDER(
  A,
  B,
  O
);

input A;
input B;
output O;

wire [31:0] A;
wire [31:0] B;
wire [31:0] O;

assign O = A + B;

endmodule
  