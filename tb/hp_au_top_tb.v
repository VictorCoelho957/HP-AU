`timescale 1ns/1ps

module hp_au_top_tb;
    // PROVA DE CONCEITO: Mudando para 8 bits
    localparam W = 8; 

    reg  [W-1:0] a, b;
    reg  [3:0]   sel;
    wire [W-1:0] result;

    // Instanciando a ALU como um IP de 8 bits
    hp_au_top #(.WIDTH(W)) uut (
        .a(a), .b(b), .sel(sel), .result(result)
    );

    initial begin
        $display("=== TESTE FASE 7: PARAMETRIZACAO %0d BITS ===", W);
        
        // Teste de Multiplicação: 10 * 10 = 100
        // Em 4 bits isso daria overflow (0), em 8 bits deve dar 100!
        a = 8'd10; b = 8'd10; sel = 4'd8; #10;
        if(result === 8'd100) 
            $display("[OK] Multiplicacao 8-bits: 10 * 10 = %d", result);
        else 
            $display("[ERRO] Falha na escala: %d", result);

        $stop;
    end
endmodule