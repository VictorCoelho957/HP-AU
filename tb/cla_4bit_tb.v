`timescale 1ns/1ps

module cla_4bit_tb;
    // Sinais do Testbench
    reg [3:0] a, b;
    reg cin;
    wire [3:0] sum;
    wire cout, Pg, Gg;

    // Instância do DUT (Device Under Test) - Seu Módulo CLA
    cla_4bit DUT (
        .a(a), .b(b), .cin(cin),
        .sum(sum), .cout(cout),
        .Pg(Pg), .Gg(Gg)
    );

    initial begin
        $display("==================================================");
        $display("   TESTBENCH FASE 4: CARRY LOOK-AHEAD (CLA)       ");
        $display("==================================================");
        $display("Tempo |   A  +   B  + Cin | Soma | Cout | Pg Gg");
        $display("------|-------------------|------|------|------");

        // -----------------------------------------------------------
        // CASO 1: Sanidade (Soma Simples)
        // -----------------------------------------------------------
        a = 4'd2; b = 4'd3; cin = 0; #10;
        // 2 (0010) + 3 (0011) = 5 (0101). Sem Carry.
        if (sum === 5 && cout === 0) 
            $display("%5t | %d + %d + %b |  %d   |  %b   | %b  %b  [OK] Soma Simples", $time, a, b, cin, sum, cout, Pg, Gg);
        else 
            $display("%5t | [FALHA] Esperado 5, Recebido %d", $time, sum);

        // -----------------------------------------------------------
        // CASO 2: Teste de "Generate" (G)
        // -----------------------------------------------------------
        // 8 (1000) + 8 (1000) = 16 (0000 com Carry).
        // Aqui G3 = 1 (1&1). O Carry deve sair direto pelo termo G3 da equação.
        a = 4'd8; b = 4'd8; cin = 0; #10;
        if (sum === 0 && cout === 1 && Gg === 1) 
            $display("%5t | %d + %d + %b |  %d   |  %b   | %b  %b  [OK] Generate G3 Disparou", $time, a, b, cin, sum, cout, Pg, Gg);
        else 
            $display("%5t | [FALHA] Generate falhou. Cout: %b", $time, cout);

        // -----------------------------------------------------------
        // CASO 3: O GRANDE TESTE (Propagação Total)
        // -----------------------------------------------------------
        // A=1111 (15), B=0000 (0), Cin=1.
        // Soma = 16 (0000 com Cout=1).
        // P = 1111 (Todos propagam).
        // Este caso testa o termo mais longo da equação: P3.P2.P1.P0.C0
        a = 4'b1111; b = 4'b0000; cin = 1; #10;
        
        if (sum === 0 && cout === 1 && Pg === 1) begin
            $display("%5t | 1111 + 0000 + 1 | %b |  %b   | %b  %b  [OK] Propagação Total (CLA Validado)", $time, sum, cout, Pg, Gg);
        end else begin
            $display("%5t | [FALHA] A lógica de Look-Ahead quebrou!", $time);
            $display("      Depurar: Pg esperado 1, deu %b. Cout esperado 1, deu %b", Pg, cout);
        end

        $display("==================================================");
        $stop;
    end

endmodule