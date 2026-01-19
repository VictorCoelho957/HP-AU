module hp_au_top #(
    parameter WIDTH = 4
)(
    input  [WIDTH-1:0] a, b,
    input  [2:0]       sel,    // [MODIFICADO] Agora são 3 bits!
    output [WIDTH-1:0] result
);

    // --- Fios Internos ---
    wire [WIDTH-1:0] s_bin;     
    wire [3:0]       s_bcd, s_cla;
    wire             cout_bcd, cout_cla;
    wire [3:0]       s_shift;   // Saída do Shifter

    // --- Instâncias Matemáticas (Fases 2, 3, 4) ---
    binary_core #(.WIDTH(WIDTH)) bin_inst (.a(a), .b(b), .sub(sel[0]), .s(s_bin));
    bcd_adder_core bcd_inst (.a(a[3:0]), .b(b[3:0]), .cin(1'b0), .s_bcd(s_bcd), .cout_bcd(cout_bcd));
    cla_4bit cla_inst (.a(a[3:0]), .b(b[3:0]), .cin(1'b0), .sum(s_cla), .cout(cout_cla), .Pg(), .Gg());

    // --- Instância Shifter (Fase 5) ---
    // Usamos os 2 bits menos significativos de 'b' para definir o quanto deslocar
    barrel_shifter_4bit shift_inst (
        .a(a[3:0]), 
        .shift_amt(b[1:0]), 
        .y(s_shift)
    );

    // --- Roteamento Expandido (Mux 8x1) ---
    // O Mux agora gerencia 8 entradas baseadas no 'sel' de 3 bits.
    assign result = (sel == 3'b000) ? s_bin :                       // 0: Soma Lenta
                    (sel == 3'b001) ? s_bin :                       // 1: Sub Lenta
                    (sel == 3'b010) ? { {(WIDTH-4){1'b0}}, s_bcd } : // 2: BCD
                    (sel == 3'b011) ? { {(WIDTH-4){1'b0}}, s_cla } : // 3: CLA
                    (sel == 3'b100) ? (a & b) :                     // 4: AND (Lógica Pura)
                    (sel == 3'b101) ? (a | b) :                     // 5: OR
                    (sel == 3'b110) ? (a ^ b) :                     // 6: XOR
                    (sel == 3'b111) ? { {(WIDTH-4){1'b0}}, s_shift } : // 7: Shifter
                    {WIDTH{1'b0}};                                  // Default

endmodule