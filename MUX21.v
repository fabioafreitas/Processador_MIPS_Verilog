/**
 * Universidade Federal Rural de Pernambuco
 * Departamento de Estat�stica e Inform�tica
 * Disciplina: Arquitetura e Organiza��o de Computadores
 * 
 * Mux 2 para 1.
 *
 * @author Andr� Aziz (andre.caraujo@ufrpe.br)
 */
module MUX21(
  A,
  B,
  O,
  S
);

parameter DATA_WIDTH = 32;

input A;
input B;
input S;
output O;

wire [DATA_WIDTH-1:0] A;
wire [DATA_WIDTH-1:0] B;
wire [DATA_WIDTH-1:0] O;
wire S;

assign O = (S == 0) ? A : B;

endmodule
  