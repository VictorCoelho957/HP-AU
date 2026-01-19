module cla_4bit (
    input  [3:0] a, b,   // Entradas de 4 bits
    input        cin,    // Carry In do sistema
    output [3:0] sum,    // Resultado da Soma
    output       cout,   // Carry Out final (C4)
    output       Pg, Gg  // Sinais de Grupo (para expansão)
);
    wire [3:0] g, p;     // Fios para guardar os Generates e Propagates individuais
    wire [4:0] c;        // Vetor de Carries (c[0] até c[4])

    // --- Passo 1: Cálculo Paralelo de G e P ---
    // Isso acontece simultaneamente para todos os bits.
    // Baseado na definição da Aula 18 (Slide "Funções Geradora e Propagadora")
    assign g = a & b; 
    assign p = a ^ b; 

    // --- Passo 2: A Árvore de Antecipação (Look-Ahead) ---
    // Implementação das equações deduzidas na seção 3.2.
    assign c[0] = cin;
    
    // C1 = G0 + P0.C0
    assign c[1] = g[0] | (p[0] & c[0]);
    
    // C2 = G1 + P1.G0 + P1.P0.C0
    assign c[2] = g[1] | (p[1] & g[0]) | (p[1] & p[0] & c[0]);
    
    // C3 = G2 + P2.G1 + P2.P1.G0 + P2.P1.P0.C0
    assign c[3] = g[2] | (p[2] & g[1]) | (p[2] & p[1] & g[0]) | (p[2] & p[1] & p[0] & c[0]);
    
    // C4 = G3 + P3.G2 + P3.P2.G1 + P3.P2.P1.G0 + P3.P2.P1.P0.C0
    assign c[4] = g[3] | (p[3] & g[2]) | (p[3] & p[2] & g[1]) | (p[3] & p[2] & p[1] & g[0]) | (p[3] & p[2] & p[1] & p[0] & c[0]);

    // --- Passo 3: Soma Final ---
    // A soma final de qualquer bit 'i' é sempre Pi XOR Ci
    assign sum = p ^ c[3:0]; //  É o acabamento final. Aplica o carry calculado na soma parcial ($P$).

    // --- Saídas Auxiliares ---
    assign cout = c[4]; // É o resultado final do "vai-um"
    assign Pg   = &p; // "E" de todos os Ps (Grupo propaga)
    assign Gg   = c[4]; // Simplificação para este estágio
endmodule