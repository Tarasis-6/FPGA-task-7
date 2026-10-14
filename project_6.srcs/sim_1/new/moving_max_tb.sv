`timescale 1ns / 1ps

module moving_max_tb();

  reg ap_clk;
  reg ap_rst;
  reg ap_start;
  reg [31 : 0] in_data_q0;

  wire in_data_ce0;
  wire out_data_ce0;
  wire out_data_we0;
  wire ap_done;
  wire ap_idle;
  wire ap_ready;

  wire [5  : 0] in_data_address0;
  wire [31 : 0] out_data_d0;
  wire [5  : 0] out_data_address0;
  
  reg [31:0] rom [0:63];
  
  reg [31:0] out_mem [0:63];
initial begin
        
        for (int i = 0; i < 64; i=i+1)begin
            rom[i] = 20;
        end
        rom[20] = 1000;
end
  
initial begin
        ap_clk 	= 0;
        ap_rst 	= 1;     
        ap_start         = 0;
        in_data_q0       = 0;
end



always #5   ap_clk   = ~ap_clk;



initial begin

    repeat(5)@(posedge ap_clk);
    @(negedge ap_clk);ap_rst = 0;
  
    @(negedge ap_clk);ap_start = 1;
    
    @(posedge ap_done);
    @(negedge ap_clk);ap_start = 0;
    
    repeat(10) @(negedge ap_clk);
    
    $finish;

end

    always @(posedge ap_clk)
        if(out_data_ce0 && out_data_we0)
            out_mem[out_data_address0] <= out_data_d0;

    always @(posedge ap_clk)
        if(in_data_ce0)
            in_data_q0 <= rom[in_data_address0];




moving_max_0 dut (
  .in_data_ce0(in_data_ce0),              // output wire in_data_ce0
  .out_data_ce0(out_data_ce0),            // output wire out_data_ce0
  .out_data_we0(out_data_we0),            // output wire out_data_we0
  .ap_clk(ap_clk),                        // input wire ap_clk
  .ap_rst(ap_rst),                        // input wire ap_rst
  .ap_done(ap_done),                      // output wire ap_done
  .ap_idle(ap_idle),                      // output wire ap_idle
  .ap_ready(ap_ready),                    // output wire ap_ready
  .ap_start(ap_start),                    // input wire ap_start
  .in_data_address0(in_data_address0),    // output wire [5 : 0] in_data_address0
  .in_data_q0(in_data_q0),                // input wire [31 : 0] in_data_q0
  .out_data_address0(out_data_address0),  // output wire [5 : 0] out_data_address0
  .out_data_d0(out_data_d0)              // output wire [31 : 0] out_data_d0
);

endmodule
