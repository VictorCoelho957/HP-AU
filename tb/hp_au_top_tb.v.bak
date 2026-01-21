`timescale 1ns/1ps

module hp_au_top_tb; // Testbench Top Level atualizado
    reg [3:0] a, b;
    reg [2:0] sel;   // Agora 3 bits
    wire [3:0] result;

    hp_au_top #(.WIDTH(4)) uut (
        .a(a), .b(b), .sel(sel), .result(result)
    );

    initial begin
        $display("=== TESTE FASE 5: LOGICA E SHIFTER ===");
        
        // Teste 1: AND (Slot 4)
        // 1100 & 1010 = 1000
        a = 4'b1100; b = 4'b1010; sel = 3'd4; #10;
        if(result === 4'b1000) $display("[OK] AND: 1100 & 1010 = %b", result);
        else $display("[ERRO] AND Falhou: %b", result);

        // Teste 2: XOR (Slot 6) - Crítico para criptografia
        // 1100 ^ 1010 = 0110
        sel = 3'd6; #10;
        if(result === 4'b0110) $display("[OK] XOR: 1100 ^ 1010 = %b", result);
        else $display("[ERRO] XOR Falhou: %b", result);

        // Teste 3: Barrel Shifter (Slot 7)
        // Mover '0001' (1) por 2 posições para a esquerda -> '0100' (4)
        // No Shifter, 'a' é o dado, 'b' é a quantidade.
        a = 4'b0001; b = 4'b0010; sel = 3'd7; #10;
        
        if(result === 4'b0100) 
            $display("[OK] SHIFT: 0001 << 2 = %b (Multiplicacao por 4)", result);
        else 
            $display("[ERRO] SHIFT Falhou. Esperado 0100, Recebido %b", result);

        $stop;
    end
endmodule