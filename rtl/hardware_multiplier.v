module hardware_multiplier (
    input  [3:0] a, b,    // Entradas de 4 bits (Operandos)
    output [7:0] product  // Saída de 8 bits (Resultado Completo)
);
    /* ANÁLISE LINHA A LINHA:
       1. input [3:0]: Nossos operandos são de 4 bits. Max valor = 15.
       2. output [7:0]: POR QUE 8 BITS?
          Regra de Ouro da Aritmética Digital: A multiplicação de N bits por N bits
          resulta em 2N bits.
          Ex: 15 (1111) * 15 (1111) = 225 (11100001).
          Se a saída fosse de 4 bits, perderíamos os bits mais importantes (Overflow).
    */

    assign product = a * b;

    /* ANÁLISE FÍSICA:
       O comando '*' parece simples, mas é poderoso.
       Em FPGAs de alto nível (Stratix, Arria), isso ativa um "Hard IP" (circuito pronto).
       Em FPGAs básicas (Cyclone), isso cria uma matriz de portas AND e Adders (Array Multiplier).
    */
endmodule