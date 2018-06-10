/**
 * Universidade Federal Rural de Pernambuco
 * Departamento de Estat�stica e Inform�tica
 * Disciplina: Arquitetura e Organiza��o de Computadores
 * 
 * Unidade L�gica e Aritm�tica - ULA - de 32 bits.
 *
 * @author Andr� Aziz (andre.caraujo@ufrpe.br)
 */

module ULA (
  A,   	       // Operando A
  B,           // Operando B
  S,           // Resultado
  OP,          // Sele��o da opera��o
  Z            // Indica que o resultado � zero.
);

input [31:0] A;
input [31:0] B;
input [3:0] OP;
output [31:0] S;
output Z;

wire signed [31:0] A, B;
wire [3:0] OP;
reg signed [31:0] S;
reg Z;

initial begin
  S = 0;
  Z = 0;
end
	
always @ (A or B or OP) begin : operacoes_ula

  case (OP)
	
	// 0
  // S = A & B
  4'b0000: begin 
    S = A & B;
  end
	
	// 1		
  // S = A | B
  4'b0001: begin
    S = A | B;  
  end
  
  // 2 
  // S = A + B
  4'b0010: begin
    S = A + B;
  end
	
	// 3
	// 
	4'b0011: begin
    
  end
	
	// 4
	4'b0100: begin
    
  end
	
	
	// 5
	4'b0101: begin
    
  end
	
	// 6
  // S = A - B 
  4'b0110: begin
    S = A - B;
  end

  // 7
  // S = A < B
  4'b0111: begin
    S = (A < B) ? 1 : 0;
  end
	
	// 8
	4'b1000: begin
    
  end
	
	// 9
	4'b1001: begin
    
  end
	
	// 10
	4'b1010: begin
    
  end
	
	// 11
	4'b1011: begin
    
  end
	
	
	// 12
  // S = ~(A | B)
  4'b1100: begin
    S = ~(A | B);
  end
  
  
  // 13
  4'b1101: begin
    
  end
	
	
	// 14
	4'b1110: begin
    
  end
	
	
	// 15
	4'b1111: begin
    
  end
  
  default: begin
    S = 0;
  end

  endcase

  Z = (S == 0) ? 1'b1 : 1'b0;	
end

endmodule
