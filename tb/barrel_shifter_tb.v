`timescale 1ns/1ps

module barrel_shifter_tb;
    reg [3:0] a;
    reg [1:0] shift_amt;
    wire [3:0] y;

    // Instância do DUT (Device Under Test)
    barrel_shifter_4bit dut (
        .a(a), 
        .shift_amt(shift_amt), 
        .y(y)
    );

    initial begin
        $display("=== TESTE UNITARIO: BARREL SHIFTER ===");
        
        // Caso 1: Deslocamento 0 (Identidade)
        a = 4'b1011; shift_amt = 0; #10;
        if(y === 4'b1011) $display("[OK] Shift 0: 1011 -> %b", y);
        else $display("[FALHA] Shift 0. Esperado 1011, Recebido %b", y);

        // Caso 2: Deslocamento 1
        a = 4'b0001; shift_amt = 1; #10;
        if(y === 4'b0010) $display("[OK] Shift 1: 0001 -> %b", y);
        else $display("[FALHA] Shift 1. Esperado 0010, Recebido %b", y);

        // Caso 3: Deslocamento 2 (Multiplicação por 4)
        a = 4'b0011; shift_amt = 2; #10;
        if(y === 4'b1100) $display("[OK] Shift 2: 0011 -> %b", y);
        else $display("[FALHA] Shift 2. Esperado 1100, Recebido %b", y);

        // Caso 4: Deslocamento 3 (Estouro)
        // O bit mais significativo vai cair fora
        a = 4'b1100; shift_amt = 3; #10;
        if(y === 4'b0000) $display("[OK] Shift 3: 1100 -> %b (Bits cairam fora)", y);
        else $display("[FALHA] Shift 3. Esperado 0000, Recebido %b", y);

        $stop;
    end
endmodule