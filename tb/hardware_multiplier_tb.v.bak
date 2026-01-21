`timescale 1ns/1ps

module hardware_multiplier_tb;
    reg [3:0] a, b;     // Registradores para estimular as entradas
    wire [7:0] product; // Fio para observar a saída expandida

    // Instância do DUT (Device Under Test)
    hardware_multiplier dut (
        .a(a), 
        .b(b), 
        .product(product)
    );

    initial begin
        $display("=== TESTE UNITARIO: MULTIPLICADOR 4x4 -> 8 BITS ===");
        
        // Caso 1: Teste Simples (Dentro de 4 bits)
        // 2 * 3 = 6 (00000110)
        a = 2; b = 3; #10;
        if(product === 6) $display("[OK] 2 * 3 = %d", product);
        else $display("[FALHA] 2 * 3. Esperado 6, Recebido %d", product);

        // Caso 2: Teste de Fronteira (Máximo de 4 bits)
        // 15 * 1 = 15 (00001111)
        a = 15; b = 1; #10;
        if(product === 15) $display("[OK] 15 * 1 = %d", product);
        else $display("[FALHA] 15 * 1. Esperado 15, Recebido %d", product);

        // Caso 3: O Teste Crítico (Expansão de Bits)
        // 10 * 10 = 100 (01100100).
        // Se nossa saída fosse de 4 bits, veríamos apenas '4' (0100).
        // Precisamos ver 100.
        a = 10; b = 10; #10;
        if(product === 100) $display("[OK] 10 * 10 = %d (Expansao funcionou)", product);
        else $display("[FALHA] 10 * 10. Esperado 100, Recebido %d", product);

        $stop;
    end
endmodule