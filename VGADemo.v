module VGADemo(
    input clk_25,
    output reg [3:0] VGA_R, VGA_G, VGA_B,
    output hsync_out,
    output vsync_out
);
    wire inDisplayArea;
    wire [9:0] CounterX;
    wire [9:0] CounterY;
    wire clk_pix; 
 
    clk_div #(.FREQ(25000000)) clkmedio(
        .clk(clk_25),
        .rst(0),
        .clk_div(clk_pix)
    );

    hvsync_gen hvsync(
        .clk(clk_pix),
        .vga_h_sync(hsync_out),
        .vga_v_sync(vsync_out),
        .CounterX(CounterX),
        .CounterY(CounterY),
        .inDisplayArea(inDisplayArea)
    );


        always @(posedge clk_pix) begin
      if (inDisplayArea) begin
          if (
              // Letra G 
              (
                // Barra vertical izquierda
                ((CounterX >= 225) && (CounterX < 225+8) &&
                 (CounterY >= 200) && (CounterY < 200+80)) ||
                // Barra horizontal superior
                ((CounterY >= 200) && (CounterY < 200+8) &&
                 (CounterX >= 225) && (CounterX < 225+40)) ||
                // Barra horizontal inferior
                ((CounterY >= 200+80-8) && (CounterY < 200+80) &&
                 (CounterX >= 225) && (CounterX < 225+40)) ||
                // Barra vertical derecha (solo en la mitad inferior)
                ((CounterX >= 225+40-8) && (CounterX < 225+40) &&
                 (CounterY >= 200+40) && (CounterY < 200+80)) ||
                // Barra horizontal interna (para la “apertura”)
                ((CounterY >= 200+40-4) && (CounterY < 200+40+4) &&
                 (CounterX >= 225+20) && (CounterX < 225+40))
              )
              ||
              // Letra A
              (
                // Barra vertical izquierda
                ((CounterX >= 275) && (CounterX < 275+8) &&
                 (CounterY >= 200) && (CounterY < 200+80)) ||
                // Barra vertical derecha
                ((CounterX >= 275+40-8) && (CounterX < 275+40) &&
                 (CounterY >= 200) && (CounterY < 200+80)) ||
                // Barra horizontal central
                ((CounterY >= 240-4) && (CounterY < 240+4) &&
                 (CounterX >= 275) && (CounterX < 275+40)) ||
					 //Barra de arriba
					 ((CounterY >= 200) && (CounterY < 200+8) &&
                 (CounterX >= 275) && (CounterX < 275+40))
              )
              ||
              // Letra E
              (
                // Barra vertical izquierda
                ((CounterX >= 325) && (CounterX < 325+8) &&
                 (CounterY >= 200) && (CounterY < 200+80)) ||
                // Barra horizontal superior
                ((CounterY >= 200) && (CounterY < 200+8) &&
                 (CounterX >= 325) && (CounterX < 325+40)) ||
                // Barra horizontal central
                ((CounterY >= 240-4) && (CounterY < 240+4) &&
                 (CounterX >= 325) && (CounterX < 325+40)) ||
                // Barra horizontal inferior
                ((CounterY >= 200+80-8) && (CounterY < 200+80) &&
                 (CounterX >= 325) && (CounterX < 325+40))
              )
              ||
              // Letra L
              (
                // Barra vertical izquierda
                ((CounterX >= 375) && (CounterX < 375+8) &&
                 (CounterY >= 200) && (CounterY < 200+80)) ||
                // Barra horizontal inferior
                ((CounterY >= 200+80-8) && (CounterY < 200+80) &&
                 (CounterX >= 375) && (CounterX < 375+40))
              )
          ) begin
              // Dibuja las letras en color
              VGA_R <= 4'b0000;
              VGA_G <= 4'b0000;
              VGA_B <= 4'b0000;
          end else begin
              // Fondo
              VGA_R <= 4'b1111;
              VGA_G <= 4'b1111;
              VGA_B <= 4'b1111;
          end
      end else begin
          VGA_R <= 4'b0000;
          VGA_G <= 4'b0000;
          VGA_B <= 4'b0000;
      end
    end

endmodule

