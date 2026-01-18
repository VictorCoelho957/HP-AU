module hp_au_top #(
    parameter WIDTH = 4
)(
    input  [WIDTH-1:0] d0, d1, d2, d3,
    input  [1:0]       sel,
    output [WIDTH-1:0] y
);
    // Instância única da Unidade de Roteamento (Fase 1)
    routing_unit #(.WIDTH(WIDTH)) mux_inst (
        .d0(d0), .d1(d1), .d2(d2), .d3(d3),
        .sel(sel),
        .y(y)
    );
endmodule