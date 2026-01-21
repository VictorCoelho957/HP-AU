module hp_au_top #(
    parameter WIDTH = 4
)(
    input  [WIDTH-1:0] a, b,
    input  [3:0]       sel,
    output [WIDTH-1:0] result
);

    // --- Barramentos de Interconexão ---
    wire [WIDTH-1:0] s_bin, s_bcd, s_cla, s_shift;
    wire [(2*WIDTH)-1:0] s_mult_full;

    // --- INSTANCIAÇÃO COM PROPAGAÇÃO DE PARÂMETROS ---

    // 1. Núcleo Binário (Fase 2)
    binary_core #(.WIDTH(WIDTH)) bin_inst (
        .a(a), .b(b), .sub(sel[0]), .s(s_bin), .cout()
    );

    // 2. Multiplicador (Fase 6)
    hardware_multiplier #(.WIDTH(WIDTH)) mult_inst (
        .a(a), .b(b), .product(s_mult_full)
    );

    // 3. Shifter (Fase 5)
    barrel_shifter #(.WIDTH(WIDTH)) shift_inst (
        .a(a), .amt(b[1:0]), .result(s_shift) // b controla a distância do shift
    );

    // [Nota Técnica] BCD e CLA são otimizados para 4 bits. 
    // Em designs de N-bits, eles são mantidos como blocos legados 
    // ou expandidos via 'generate' (assunto para o Módulo Avançado).

    // --- MUX DE SELEÇÃO FINAL (A Inteligência da ALU) ---
    assign result = (sel == 4'b0000) ? s_bin :                // 0: SOMA
                    (sel == 4'b0001) ? s_bin :                // 1: SUB
                    (sel == 4'b0100) ? (a & b) :              // 4: AND
                    (sel == 4'b0101) ? (a | b) :              // 5: OR
                    (sel == 4'b0110) ? (a ^ b) :              // 6: XOR
                    (sel == 4'b0111) ? s_shift :              // 7: SHIFT
                    (sel == 4'b1000) ? s_mult_full[WIDTH-1:0] : // 8: MULT (Truncada)
                    {WIDTH{1'b0}};                            // DEFAULT: ZERAR

endmodule