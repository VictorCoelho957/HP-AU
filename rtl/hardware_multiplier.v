module hardware_multiplier #(
    parameter WIDTH = 4 // <--- Adicione esta linha mestre
)(
    input  [WIDTH-1:0] a, b,
    output [(2*WIDTH)-1:0] product
);
    assign product = a * b;
endmodule