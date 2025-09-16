`timescale 1ns/1ps

module FIFO_tb();

    parameter DSIZE = 8; 
    parameter ASIZE = 3; 
    parameter DEPTH = 1 << ASIZE; 

    reg [DSIZE-1:0] wdata;  
    wire [DSIZE-1:0] rdata;  
    wire wfull, rempty;      
    reg winc, rinc, wclk, rclk, wrst_n, rrst_n; 

    FIFO #(DSIZE, ASIZE) fifo (
        .rdata(rdata), 
        .wdata(wdata),
        .wfull(wfull),
        .rempty(rempty),
        .winc(winc), 
        .rinc(rinc), 
        .wclk(wclk), 
        .rclk(rclk), 
        .wrst_n(wrst_n), 
        .rrst_n(rrst_n)
    );

    integer i=0;
    integer seed = 1;

    
    always #5 wclk = ~wclk;    
    always #10 rclk = ~rclk;   
    
    initial begin
        
        wclk = 0;
        rclk = 0;
        wrst_n = 1;     
        rrst_n = 1;     
        winc = 0;
        rinc = 0;
        wdata = 0;

      
        #40 wrst_n = 0; rrst_n = 0;
        #40 wrst_n = 1; rrst_n = 1;

      
        rinc = 1;
        for (i = 0; i < 10; i = i + 1) begin
            wdata = $random(seed) % 256;
            winc = 1;
            #10;
            winc = 0;
            #10;
        end

     
        rinc = 0;
        winc = 1;
        for (i = 0; i < DEPTH + 3; i = i + 1) begin
            wdata = $random(seed) % 256;
            #10;
        end

       
        winc = 0;
        rinc = 1;
        for (i = 0; i < DEPTH + 3; i = i + 1) begin
            #20;
        end

        $finish;
    end

endmodule
