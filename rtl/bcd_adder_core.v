module bcd_adder_core (
    // Entradas: Dois números de 4 bits (0 a 9) e um "vem-um"
    input  [3:0] a, b,
    input        cin,
    // Saídas: O resultado corrigido e o "vai-um" decimal
    output [3:0] s_bcd,
    output       cout_bcd
);
    // Fios internos (WIRING)
    // binary_sum precisa de 5 bits (4 para o número + 1 para o estouro nativo)
    wire [4:0] binary_sum; 
    wire       adj_needed; // O sinal de "Alerta de Correção"

    // PASSO 1: A Soma "Ingênua"
    // Aqui, o hardware soma como se fosse binário puro.
    // Ex: 5 (0101) + 5 (0101) = 10 (01010) -> binary_sum guarda isso.
    assign binary_sum = a + b + cin;

    // PASSO 2: O Detetive (Lógica Combinacional)
    // Aqui implementamos a equação que descobrimos acima.
    // binary_sum[4] é o Carry nativo (K).
    // & = Porta AND (E)
    // | = Porta OR (OU)
    assign adj_needed = binary_sum[4] | 
                        (binary_sum[3] & binary_sum[2]) | 
                        (binary_sum[3] & binary_sum[1]);

    // PASSO 3: A Correção (Multiplexador)
    // Sintaxe: (CONDIÇÃO) ? (VALOR_SE_VERDADEIRO) : (VALOR_SE_FALSO);
    // Se o detetive (adj_needed) disser "1", somamos 6 (0110).
    // Se disser "0", somamos 0 (não fazemos nada).
    assign s_bcd    = adj_needed ? (binary_sum[3:0] + 4'b0110) : binary_sum[3:0];
    
    // PASSO 4: O Carry Decimal
    // Se precisou ajustar, significa que passamos de 9. Então o Carry é 1.
    assign cout_bcd = adj_needed;

endmodule