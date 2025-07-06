`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// Create Date: 06/07/2025 10:52:35 AM
// Design Name: 
// Module Name: pipelining_tb
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
//////////////////////////////////////////////////////////////////////////////////


module pipelining_tb;

localparam tclk = 5; 

  reg i_clk;
  reg i_rst;
  reg [31:0] counter;
  wire valid_out;
  wire [31:0] EF_match_count;

  // Instantiate 
  pipelining Pipelining_inst(
    .i_clk(i_clk),
    .i_rst(i_rst),
    .counter(counter),
    .valid_out(valid_out),
    .EF_match_count(EF_match_count)
  );
  
  
  initial i_clk = 0;
  
  always #tclk i_clk = ~i_clk;

  initial begin
  
    i_rst = 1;
    counter = 32'd0;#10;
    
    i_rst = 0;
    repeat (100_000_000) begin
    @(posedge i_clk);
       counter = counter + 1'd1;
    end
    
    #10;
    
    $finish;    
 
  end

endmodule

