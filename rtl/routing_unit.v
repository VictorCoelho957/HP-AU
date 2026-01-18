module routing_unit #(
    parameter WIDTH = 4 // Parametrização para o portfólio
)(
    input  [WIDTH-1:0] d0, d1, d2, d3,
    input  [1:0]       sel,
    output reg [WIDTH-1:0] y
);
    // Lógica pura da Fase 1: Seleção de dados
    always @(*) begin
        case (sel)
            2'b00:   y = d0;
            2'b01:   y = d1;
            2'b10:   y = d2;
            2'b11:   y = d3;
            default: y = {WIDTH{1'b0}}; // Proteção contra latches
        endcase
    end
endmodule