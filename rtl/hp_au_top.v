module hp_au_top #(
    parameter WIDTH = 4
)(
    input  [WIDTH-1:0] a, b,
    input  [1:0]       sel,
    output [WIDTH-1:0] result
);

    // --- Fios Internos ---
    wire [WIDTH-1:0] s_bin;
    wire [3:0]       s_bcd;
    wire             cout_bcd;

    // --- INSTÂNCIA 1: NÚCLEO BINÁRIO ---
    binary_core #(.WIDTH(WIDTH)) bin_inst (
        .a(a), 
        .b(b), 
        .sub(sel[0]), 
        .s(s_bin)      // <--- CORREÇÃO: Mudei de .r para .s (Verifique se é .s ou .result no seu arquivo!)
    );

    // --- INSTÂNCIA 2: NÚCLEO BCD ---
    bcd_adder_core bcd_inst (
        .a(a[3:0]), 
        .b(b[3:0]), 
        .cin(1'b0), 
        .s_bcd(s_bcd), 
        .cout_bcd(cout_bcd)
    );

    // --- INSTÂNCIA 3: ROTEAMENTO ---
    routing_unit #(.WIDTH(WIDTH)) mux_inst (
        .d0(s_bin),                        
        .d1(s_bin),                        
        .d2({ {(WIDTH-4){1'b0}}, s_bcd }), 
        .d3({WIDTH{1'b0}}),                
        .sel(sel), 
        .y(result)
    );

endmodule