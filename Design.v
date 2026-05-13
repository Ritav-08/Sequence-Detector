module sdFSM1011(
   input      data_i,
   input      rst_i, 
   input      clk_i,
   output reg dout_o
);

   //net(s)
   reg [1:0]present_state;

   //States
   localparam 
      S0 = 2'b00, 
      S1 = 2'b01, 
      S2 = 2'b10, 
      S3 = 2'b11;

   //FSM
   always@(posedge rst_i, posedge clk_i) begin
      //Reset
      if(rst_i) begin
         present_state <= S0;
         dout_o <= 1'b0;
      end
      //State Transitions
      else begin
         present_state <= S0; //default
         case(present_state)
            S0: begin 
               if(data_i) present_state <= S1;
            end
            S1: begin 
               if(data_i == 1'b0) present_state <= S2;
            end
            S2: begin 
               if(data_i) present_state <= S3; 
               else present_state <= S0;
            end
            S3: begin 
               if(data_i) present_state <= S1;
               else present_state <= S2; 
            end
            default: ;
         endcase
      
         //Output Generation
         dout_o <= 1'b0; //default
         case(present_state)
            S0: dout_o <= 1'b0;
            S1: dout_o <= 1'b0;
            S2: dout_o <= 1'b0;
            S3: begin 
               if(data_i) dout_o <= 1'b1; 
               else dout_o <= 1'b0;
            end
            default: ;
         endcase
      end
   end
   
endmodule
