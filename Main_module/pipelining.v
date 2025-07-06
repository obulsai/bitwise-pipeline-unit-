`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: T.OBUL SAI
// Create Date: 06/07/2025 10:51:51 AM
// Design Name: Logical Operations with Pipelining 
// Module Name: pipelining
// Project Name: Logical Operations with Pipelining 
// Target Devices: 
// Tool Versions:2024.1 
// Description: 
/*
Problem 2: Logical Operations with Pipelining (deadline: Sunday)

Design a pipelined logic processing unit that takes an incremental 32-bit counter and performs a two-stage and three-stage pipeline of operations.

Specifications:

Inputs:

32-bit counter (free-running): {D, C, B, A}

A = [7:0], B = [15:8], C = [23:16], D = [31:24]


Operations:

E = A | (B & C) - to be computed in 2 clock cycles

F = (B & C) ^ (A | D) - to be computed in 3 clock cycles

Output valid_out = 1 when E == F

---

Pass Criteria:

Maintain pipeline correctness (i.e., E and F computed from same counter snapshot)

Use internal pipeline registers - no shortcutting!

Output valid_out should be HIGH only when E == F

Add a counter to count how many times E == F

*/ 
//////////////////////////////////////////////////////////////////////////////////

module pipelining (

    input i_clk,
    input i_rst,
    input [31:0] counter,
    output reg valid_out,
    output reg [31:0] EF_match_count
    
);
                

// Stage 1
reg [7:0] S1_A, S1_B, S1_C, S1_D;

// Stage 2
reg [7:0] S2_E, S2_BC, S2_A, S2_D;

// Stage 3
//reg [7:0] S3_E;
reg [7:0] S3_F;
       

// Stage 1: Latch inputs

always @(posedge i_clk or posedge i_rst) begin
    if(i_rst) begin
        S1_A <= 0; 
        S1_B <= 0; 
        S1_C <= 0;
        S1_D <= 0; 
    end else begin   
        S1_A <= counter[7:0];
        S1_B <= counter[15:8];
        S1_C <= counter[23:16]; 
        S1_D <= counter[31:24]; 
    end                
end                    


// Stage 2: E = A | (B & C)
always @(posedge i_clk or posedge i_rst) begin
    if(i_rst) begin
        S2_E <= 0;
        S2_BC <= 0; 
        S2_A <= 0; 
        S2_D <= 0;
    end else begin   
        S2_BC <= S1_B & S1_C;
        S2_A  <= S1_A;
        S2_D  <= S1_D;
        S2_E  <= S1_A | (S1_B & S1_C);            
    end       
end   


// Stage 3: F = (B & C) ^ (A | D), Compare E == F

always @(posedge i_clk or posedge i_rst) begin
    if(i_rst) begin
       // S3_E <= 0;
        S3_F <= 0;
        valid_out <= 0;
        EF_match_count <= 0;
    end else begin   
        //S3_E <= S2_E;
        S3_F <= S2_BC ^ (S2_A | S2_D);  

        if(S2_E == S3_F) begin
            valid_out <= 1;
            EF_match_count <= EF_match_count + 1;
        end else begin
            valid_out <= 0;
        end
    end       
end                
                
endmodule


