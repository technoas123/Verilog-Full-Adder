`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/13/2026 01:48:31 PM
// Design Name: 
// Module Name: testBench_FA
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module tb_full_adder;

    // Registers for inputs to drive the signals
    reg a;
    reg b;
    reg cin;

    // Wires for outputs to observe the signals
    wire sum;
    wire carry;

    // Instantiate the Device Under Test (DUT)
    full_adder dut (
        .a(a),
        .b(b),
        .cin(cin),
        .sum(sum),
        .carry(carry)
    );


    // Stimulus block
    initial begin
        // Monitor outputs in the Tcl Console
        $monitor("Time = %0t | a = %b, b = %b, cin = %b | sum = %b, carry = %b", $time, a, b, cin, sum, carry);
        
        // Test all 8 binary combinations
        a = 0; b = 0; cin = 0; #10;
        a = 0; b = 0; cin = 1; #10;
        a = 0; b = 1; cin = 0; #10;
        a = 0; b = 1; cin = 1; #10;
        a = 1; b = 0; cin = 0; #10;
        a = 1; b = 0; cin = 1; #10;
        a = 1; b = 1; cin = 0; #10;
        a = 1; b = 1; cin = 1; #10;
        
        // Stop simulation
        $stop;
    end

endmodule

