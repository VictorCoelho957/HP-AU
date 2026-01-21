module hardware_multiplier #(
    parameter WIDTH = 4
)(
    input  [WIDTH-1:0] a, b,
    output [(2*WIDTH)-1:0] product // Dinamicamente calculado como 2*N
);
    /* EXPLICAÇÃO LINHA A LINHA:
       input [WIDTH-1:0]: Se WIDTH for 32, as entradas viram 32 bits automaticamente.
       output [(2*WIDTH)-1:0]: Se WIDTH for 32, a saída vira 64 bits.
       assign product = a * b: O sintetizador agora cria um multiplicador 
       da largura correta baseado no parâmetro.
    */
    assign product = a * b;
endmodule