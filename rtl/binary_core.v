module binary_core #(
    parameter WIDTH = 4 
)(
    input  [WIDTH-1:0] a, b,
    input              sub,  // 0: Soma, 1: Subtração
    output [WIDTH-1:0] s,
    output             cout
);
    wire [WIDTH-1:0] b_aux;

    // Inversão controlada via porta XOR
    assign b_aux = b ^ {WIDTH{sub}};

    // Operação unificada: Se sub=1, o carry-in recebe 1 para o Complemento de 2
    assign {cout, s} = a + b_aux + sub; 

endmodule