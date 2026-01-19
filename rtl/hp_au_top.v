module hp_au_top #(
    parameter WIDTH = 4
)(
    input  [WIDTH-1:0] a, b,
    input  [1:0]       sel,
    output [WIDTH-1:0] result
);

    // --- 1. Declaração de Fios ---
    wire [WIDTH-1:0] s_bin;     // Fio existente (Ripple Carry)
    wire [3:0]       s_bcd;     // Fio existente (BCD)
    wire             cout_bcd;
    
    // [MODIFICAÇÃO]: Criamos fios novos para trazer o sinal do CLA para o Top Level.
    // Sem isso, não teríamos como conectar a saída do módulo ao multiplexador.
    wire [3:0]       s_cla;     
    wire             cout_cla;  

    // --- Instâncias Existentes (Binário e BCD) ---
    binary_core #(.WIDTH(WIDTH)) bin_inst (.a(a), .b(b), .sub(sel[0]), .s(s_bin));
    bcd_adder_core bcd_inst (.a(a[3:0]), .b(b[3:0]), .cin(1'b0), .s_bcd(s_bcd), .cout_bcd(cout_bcd));

    // --- 2. Instância do CLA (Fase 4) ---
    // [MODIFICAÇÃO]: Aqui "soldamos" o chip CLA na placa mãe.
    cla_4bit cla_inst (
        .a(a[3:0]),      // Conectamos os 4 bits menos significativos da entrada A
        .b(b[3:0]),      // Conectamos os 4 bits menos significativos da entrada B
        .cin(1'b0),      // Carry in fixo em 0 (sem soma anterior)
        .sum(s_cla),     // A saída calculada vai para o fio 's_cla'
        .cout(cout_cla), // O carry vai para 'cout_cla'
        .Pg(), .Gg()     // Deixamos em branco () pois não vamos usar cascateamento agora.
    );

    // --- 3. Multiplexador Atualizado ---
    routing_unit #(.WIDTH(WIDTH)) mux_inst (
        .d0(s_bin),                        
        .d1(s_bin),                        
        .d2({ {(WIDTH-4){1'b0}}, s_bcd }), 
        
        // [MODIFICAÇÃO]: Preenchemos o slot '11' (d3) que estava vazio.
        // { {(WIDTH-4){1'b0}}, s_cla } -> Isso é uma concatenação segura.
        // Se WIDTH for 8, ele cria 4 zeros e junta com o s_cla (4 bits), totalizando 8.
        // Isso evita erros de síntese se mudarmos o tamanho do processador.
        .d3({ {(WIDTH-4){1'b0}}, s_cla }), 
        
        .sel(sel), 
        .y(result)
    );
endmodule