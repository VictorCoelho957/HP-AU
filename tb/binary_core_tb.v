`timescale 1ns/1ps

module binary_core_tb();
    parameter W = 4;

    reg  [W-1:0] a, b;
    reg          sub;
    wire [W-1:0] s;
    wire         cout;

    binary_core #(.WIDTH(W)) uut (
        .a(a), .b(b), .sub(sub),
        .s(s), .cout(cout)
    );

    initial begin
        // TESTE 1: Soma (10 + 2 = 12)
        sub = 0; a = 4'd10; b = 4'd2; #10;
        
        // TESTE 2: Subtração (12 - 1 = 11)
        // Deve resultar em 1011 com cout=1
        sub = 1; a = 4'd12; b = 4'd1; #10;
        
        // TESTE 3: Overflow Binário (15 + 1 = 0)
        sub = 0; a = 4'd15; b = 4'd1; #10;
        
        #10 $stop;
    end
endmodule