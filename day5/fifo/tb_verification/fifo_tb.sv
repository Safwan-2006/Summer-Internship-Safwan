//Interfacing FIFO
interface fifo_interface;
  logic clk;
  logic rst;
  logic wrenb;
  logic rdenb;
  logic [7:0]data_in;
  logic [7:0]data_out;
  logic full;
  logic empty;
endinterface

module fifo_tb;
  fifo_interface fi_1();
  
  fifo dut(fi_1.clk,fi_1.rst,fi_1.wrenb,fi_1.rdenb,fi_1.data_in,fi_1.data_out,fi_1.full,fi_1.empty);
  
  initial begin
    {fi_1.clk, fi_1.rst, fi_1.wrenb, fi_1.rdenb, fi_1.data_in} = 0;
  end 
   
  always #5 fi_1.clk = ~fi_1.clk;

  initial begin 
    fi_1.rst = 1;
    #10;
    fi_1.rst = 0;
    #10;
    
    fi_1.wrenb = 1;                 
    fi_1.data_in = 8'hAA; #10;    
    fi_1.data_in = 8'hBB; #10;      
    fi_1.data_in = 8'hCC; #10;      
    fi_1.wrenb = 0;                 
    #20;

    fi_1.rdenb = 1;                
    #20;                          
    fi_1.rdenb = 0;                
    #20;
        
    fi_1.wrenb = 1;
    fi_1.data_in = 8'h01; #10;
    fi_1.data_in = 8'h02; #10;
    fi_1.data_in = 8'h03; #10;
    fi_1.data_in = 8'h04; #10;
    fi_1.data_in = 8'h05; #10;
    fi_1.data_in = 8'h06; #10;
    fi_1.data_in = 8'h07; #10;
    fi_1.wrenb = 0;
    #20;
        
    fi_1.rdenb = 1;
    #80;                       
    fi_1.rdenb = 0;
    #20;
    $finish();    
  end 
  
endmodule