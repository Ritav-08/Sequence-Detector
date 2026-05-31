`timescale 1ns / 1ps

module tb_sdFSM1011();
   reg  data_ti;
   reg  rst_ti;
   reg  clk_ti;
   wire dout_to;

//reg(s)
   reg [3:0] stream = 4'b0;

//instantiation
sdFSM1011 DUT(.data_i (data_ti), 
              .clk_i  (clk_ti) ,
              .rst_i  (rst_ti) ,
              .dout_o (dout_to)
);

//clock
initial begin
              clk_ti = 1'b0;
   forever #5 clk_ti = ~ clk_ti;
end

//Feeding
initial begin
   //Reset
         rst_ti  = 1'b1;
         data_ti = 1'b0;
      #3 rst_ti  = 1'b0;
   //Data
                #3  data_ti = 1'b0;
      repeat(5) #10 data_ti = $urandom_range(0,1);
                #10 data_ti = 1'b1;
                #10 data_ti = 1'b0;
                #10 data_ti = 1'b1;
                #10 data_ti = 1'b1;
      repeat(8) #10 data_ti = $urandom_range(0,1);
      #5 $finish;
end //feeding

//registery
always@(posedge clk_ti) begin
   stream <= {stream[2:0], data_ti};
end

//capture
initial begin
   $monitor ("Time: %0t, Clk: %b, Rst: %b, Sequence: %0b, Detection: %b", 
             $time,      clk_ti,  rst_ti,  stream,             dout_to);
   $dumpfile("sdFSM1011.vcd");
   $dumpvars(0, tb_sdFSM1011);
end

endmodule
