module hp_au_top #(
    parameter WIDTH = 4
)(
    input  [WIDTH-1:0] a, b,
    input  [3:0]       sel,    // [MUDANÇA CRÍTICA] De 3 para 4 bits!
    output [WIDTH-1:0] result
);

    // --- Declaração de Fios Internos ---
    wire [WIDTH-1:0] s_bin;     
    wire [3:0]       s_bcd, s_cla, s_shift;
    wire             cout_bcd, cout_cla;
    
    // [NOVO] Fio de 8 bits para receber o impacto da multiplicação
    wire [7:0]       s_mult_full;

    // --- Instâncias das Fases Anteriores ---
    binary_core #(.WIDTH(WIDTH)) bin_inst (.a(a), .b(b), .sub(sel[0]), .s(s_bin));
    bcd_adder_core bcd_inst (.a(a[3:0]), .b(b[3:0]), .cin(1'b0), .s_bcd(s_bcd), .cout_bcd(cout_bcd));
    cla_4bit cla_inst (.a(a[3:0]), .b(b[3:0]), .cin(1'b0), .sum(s_cla), .cout(cout_cla), .Pg(), .Gg());
    barrel_shifter_4bit shift_inst (.a(a[3:0]), .shift_amt(b[1:0]), .y(s_shift));

    // --- FASE 6: Instância do Multiplicador ---
    hardware_multiplier mult_inst (
        .a(a[3:0]), 
        .b(b[3:0]), 
        .product(s_mult_full) // Conectamos ao fio de 8 bits
    );

    // --- Roteamento Expandido (Mux 16x1) ---
    /* POR QUE [3:0] NO MULTIPLICADOR?
       O 'result' final só tem 4 bits. O Mux não aceita 8 bits.
       Somos obrigados a pegar 's_mult_full[3:0]' (Truncamento).
       Em processadores reais (RISC-V), existe uma instrução 'MUL' (baixa) e 'MULH' (alta).
       Aqui estamos implementando a 'MUL' simples.
    */
    assign result = (sel == 4'b0000) ? s_bin :                       // 0: Soma
                    (sel == 4'b0001) ? s_bin :                       // 1: Sub
                    (sel == 4'b0010) ? { {(WIDTH-4){1'b0}}, s_bcd } : // 2: BCD
                    (sel == 4'b0011) ? { {(WIDTH-4){1'b0}}, s_cla } : // 3: CLA
                    (sel == 4'b0100) ? (a & b) :                     // 4: AND
                    (sel == 4'b0101) ? (a | b) :                     // 5: OR
                    (sel == 4'b0110) ? (a ^ b) :                     // 6: XOR
                    (sel == 4'b0111) ? { {(WIDTH-4){1'b0}}, s_shift } : // 7: Shifter
                    (sel == 4'b1000) ? s_mult_full[3:0] :            // 8: MULT (Truncado)
                    {WIDTH{1'b0}};                                   // Default (Slots 9-15 vazios)

endmodule