module barrel_shifter_4bit (
    input  [3:0] a,          // Dado de entrada
    input  [1:0] shift_amt,  // Quantidade para deslocar (0 a 3)
    output [3:0] y           // Resultado deslocado para Esquerda
);
    // Um Barrel Shifter é puramente combinacional.
    // Usamos o operador '<<' do Verilog, mas fisicamente o sintetizador
    // transforma isso em uma cascata de Muxes.
    
    assign y = a << shift_amt;

    /* EXPLICAÇÃO FÍSICA DO QUE O SINTETIZADOR VAI CRIAR:
       Não é mágica. É uma matriz.
       Se shift_amt == 0: y = a
       Se shift_amt == 1: y = {a[2:0], 1'b0}
       Se shift_amt == 2: y = {a[1:0], 2'b00}
       ...
       Isso é feito com Multiplexadores 4x1 para cada bit de saída.
    */
endmodule