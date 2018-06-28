/**
 * Universidade Federal Rural de Pernambuco
 * Departamento de Estatística e Informática
 * Disciplina: Arquitetura e Organização de Computadores
 * 
 * Unidade Lógica e Aritmética - ULA - de 32 bits.
 *
 * @author André Aziz (andre.caraujo@ufrpe.br)
 */

module ULA (
  A,   	       // Operando A
  B,           // Operando B
  S,           // Resultado
  SHAMT,       // valor do shamt que sai da instrução
  OP,          // Seleção da operação
  Z            // Indica que o resultado é zero.
);

input [31:0] A;
input [31:0] B;
input [4:0] OP;     // foi estendido para 5 bits, pois 16 operacoes nao eram suficientes
input [4:0] SHAMT;  // modificaçao do shamt
output [31:0] S;
output Z;

wire signed [31:0] A, B;
wire [4:0] OP;      // foi estendido para 5 bits
wire [4:0] SHAMT;   // modificaçao do shamt
reg signed [31:0] S;
reg Z;

initial begin
  S = 0;
  Z = 0;
end
	
always @ (A or B or OP) begin : operacoes_ula

  case (OP)
	
	// 0     S = A & B
  5'b00000: begin 
    S = A & B;
  end
	
	// 1     S = A | B
  5'b00001: begin
    S = A | B;  
  end
  
  // 2     S = A + B
  5'b00010: begin
    S = A + B;
  end
	
	// 3     S = A  atribuição    JR
	5'b00011: begin
    S = A + 32'h0000;
  end
	
	// 4     zero = (A == B)? 1:0
	5'b00100: begin
    Z = (A == B)? 1:0;
  end
	
	
	// 5     zero = (A != B)? 1:0
	5'b00101: begin
    Z = (A != B)? 1:0;
  end
	
	// 6     S = A - B 
  5'b00110: begin
    S = A - B;
  end

  // 7     S = (A < B) ? 1 : 0;
  5'b00111: begin
    S = (A < B) ? 1 : 0;
  end
	
	// 8     S = B << 16
	5'b01000: begin
    S = B << 5'b10000;
  end
	
	// 9     S = A << B 
	5'b01001: begin
    S = A << SHAMT;
  end
	
	// 10     S = A >> B
	5'b01010: begin
    S = A >> SHAMT;
  end
	
	// 11     S = ~(A | B)
	5'b01011: begin
    S = ~(A | B);
  end
	
	// 12     load byte unsigned
  5'b01100: begin
    S = 32'h000000ff & (A + B);
  end
  
  // 13     load half unsigned
  5'b01101: begin
    S = 32'h0000ffff & (A + B);
  end
	
	// 14     load word
	5'b01110: begin
    S = A + B;
  end
	
	// 15     store byte     // dúvida
	5'b01111: begin
    S = 32'h000000ff & (A + B);
  end
  
  // 16     store half     // dúvida
	5'b10000: begin
    S = 32'h0000ffff & (A + B);
  end
  
  // 17     store word
	5'b10001: begin
    S = A + B;
  end
  
  // 18     jump
	5'b10010: begin
    // deixar em branco
  end
  
  // 19     jump and link
	5'b10011: begin
    // deixar em branco
  end
  
  default: begin
    S = 0;
  end

  endcase

  Z = (S == 0) ? 1'b1 : 1'b0;	
end

endmodule
