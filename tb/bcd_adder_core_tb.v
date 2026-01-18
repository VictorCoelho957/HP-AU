`timescale 1ns/1ps

module bcd_adder_core_tb;

    // 1. Sinais para conectar no Chip (DUT)
    reg  [3:0] a, b;   // Entradas (Nós controlamos)
    reg        cin;
    wire [3:0] s_bcd;  // Saídas (O chip responde)
    wire       cout_bcd;

    // 2. Instância do Chip (Ligando os fios)
    bcd_adder_core DUT (
        .a(a), 
        .b(b), 
        .cin(cin), 
        .s_bcd(s_bcd), 
        .cout_bcd(cout_bcd)
    );

    // 3. Bloco de Monitoramento (O "Console.log" do Hardware)
    initial begin
        $display("-------------------------------------------------------------");
        $display(" Tempo |  A   +  B   (Cin) | Soma Binaria | BCD (Saida) | Cout");
        $display("-------------------------------------------------------------");
        // Monitora mudanças e imprime na tela automaticamente
        $monitor(" %4tns | %d (%b) + %d (%b) (%b) |    %d      |  %d (%b)   |  %b", 
                 $time, a, a, b, b, cin, (a+b+cin), s_bcd, s_bcd, cout_bcd);
    end

    // 4. Os Testes (O Roteiro da Tortura)
    initial begin
        // CASO 1: A "Zona Segura" (Soma <= 9)
        // Esperamos: Soma binária igual à BCD. Sem Carry.
        a = 4; b = 3; cin = 0; #10; // 4+3 = 7
        a = 4; b = 5; cin = 0; #10; // 4+5 = 9 (Limite Superior Seguro)

        // CASO 2: O "Ponto de Quebra" (Soma = 10)
        // Esperamos: Soma binária seria 10 (1010), mas BCD deve ser 0 (0000). Carry deve ACENDER.
        a = 5; b = 5; cin = 0; #10; 

        // CASO 3: A "Zona Proibida" (10 < Soma < 16)
        // Esperamos: Correção automática. Ex: 7+6=13. BCD deve mostrar 3 (0011). Carry deve ACENDER.
        a = 7; b = 6; cin = 0; #10;

        // CASO 4: O "Estouro Binário" (Soma >= 16)
        // Esperamos: O bit de carry nativo ativa a correção. Ex: 9+9=18. BCD deve ser 8.
        a = 9; b = 9; cin = 0; #10;

        $display("-------------------------------------------------------------");
        $display("Testes concluidos.");
        $stop;
    end

endmodule