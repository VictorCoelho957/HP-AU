module barrel_shifter #(
    parameter WIDTH = 4
)(
    input  [WIDTH-1:0] a,
    input  [1:0]       amt,    // Quantidade de deslocamento
    output [WIDTH-1:0] result
);
    // Deslocamento lógico para a direita (Exemplo)
    assign result = a >> amt;
endmodule