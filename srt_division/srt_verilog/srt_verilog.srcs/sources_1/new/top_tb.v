`timescale 1ns / 1ps

module top_tb;

    // Parameters
    parameter CLOCK_PERIOD = 20;

    // Signals
    reg clk;
    reg rst;
    reg start;
    wire done;
    reg [63:0] div_input;
    reg [63:0] location;
    wire correct;
    
    // Instantiate the Unit Under Test (UUT)
    d_wrapper uut (
        .clk(clk),
        .rst(rst),
        .start(start),
        .done(done),
        .div_input(div_input),
        .location(location),
        .correct(correct)
    );
    

    // Clock process definitions
    initial begin
        clk = 0;
        forever #(CLOCK_PERIOD / 2) clk = ~clk;
    end

    // Stimulus process
    initial begin
        // Initialize
        rst = 1;
        start = 0;
        div_input = 64'd10;
        location = 64'd3;  
        
        #(CLOCK_PERIOD);
        rst = 0;
        #(CLOCK_PERIOD);
        #(CLOCK_PERIOD);
        // Start the divider
        start = 1;
        #(CLOCK_PERIOD);
        start = 0;
        
        // Wait for the done signal
        wait (done == 1);
        
        // Check the result
        if (correct != 1) begin
            $display("Division incorrect!");
            $stop;
        end
        
        $finish;
    end

endmodule