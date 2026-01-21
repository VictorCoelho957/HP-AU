`timescale 1ns/1ps

module hp_au_top_tb;
    reg [3:0] a, b;
    reg [3:0] sel;   // GARANTA OS 4 BITS AQUI
    wire [3:0] result;

    hp_au_top #(.WIDTH(4)) uut (
        .a(a), .b(b), .sel(sel), .result(result)
    );

    initial begin
        $display("=== TESTE INTEGRADO FASE 6: MULTIPLICACAO E INTEGRACAO ===");
        
        // Teste de Regressão: AND (Slot 4 - Binário 0100)
        a = 4'b1100; b = 4'b1010; sel = 4'd4; #10;
        if(result === 4'b1000) $display("[OK] AND funcionando");
        else $display("[ERRO] AND Falhou: %b", result);

        // Teste da Multiplicação (Slot 8 - Binário 1000)
        a = 4'd3; b = 4'd2; sel = 4'd8; #10;
        if(result === 4'd6) $display("[OK] MULT INTEGRADO: 3 * 2 = 6");
        else $display("[ERRO] MULT Falhou: %d", result);

        // Teste de Truncamento (4 * 4 = 16, estoura 4 bits -> deve ser 0)
        a = 4'd4; b = 4'd4; sel = 4'd8; #10;
        if(result === 4'd0) $display("[OK] MULT TRUNCAMENTO: 4 * 4 = Saida 0");

        $stop;
    end
endmodule