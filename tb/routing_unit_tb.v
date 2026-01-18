`timescale 1ns/1ps

module routing_unit_tb();
    parameter W = 4; // Largura de teste configurável

    reg  [W-1:0] d0, d1, d2, d3;
    reg  [1:0]   sel;
    wire [W-1:0] y;

    // Instanciação da UUT (Unit Under Test)
    routing_unit #(.WIDTH(W)) uut (
        .d0(d0), .d1(d1), .d2(d2), .d3(d3),
        .sel(sel),
        .y(y)
    );

    initial begin
        // Estímulos: Valores hexadecimais claros para identificação
        d0 = 4'hA; d1 = 4'hB; d2 = 4'hC; d3 = 4'hD;
        
        #10 sel = 2'b00; // Deve sair A
        #10 sel = 2'b01; // Deve sair B
        #10 sel = 2'b10; // Deve sair C
        #10 sel = 2'b11; // Deve sair D
        
        #10 $display("Simulação da Routing Unit concluída.");
        $stop;
    end
endmodule