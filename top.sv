`include "assertions.sv"

module top;
  bit clk_1,rstn_1;
  bit clk_2,rstn_2;
  mem_intf pif_1(clk_1,rstn_1,clk_2,rstn_2);
  mem_intf pif_2(clk_1,rstn_1,clk_2,rstn_2);
  
  always #5 clk_1=~clk_1;
  always #5 clk_2=~clk_2;
  
  memory #(`width,`depth,`addr_width) dut(
    .clk_1(pif_1.clk_1),
    .rstn_1(pif_1.rstn_1),
    .write_1(pif_1.write_1),
    .valid_1(pif_1.valid_1),
    .wdata_1(pif_1.wdata_1),
    .rdata_1(pif_1.rdata_1),
    .addr_1(pif_1.addr_1),
    .ready_1(pif_1.ready_1),
    
    //Port 2
    .clk_2(pif_2.clk_2),
    .rstn_2(pif_2.rstn_2),
    .write_2(pif_2.write_2),
    .valid_2(pif_2.valid_2),
    .wdata_2(pif_2.wdata_2),
    .rdata_2(pif_2.rdata_2),
    .addr_2(pif_2.addr_2),
    .ready_2(pif_2.ready_2));
  
  assertions #(`width,`depth,`addr_width)uut(
    .clk(pif_1.clk_1),
    .rstn(pif_1.rstn_1),
    .write(pif_1.write_1),
    .valid(pif_1.valid_1),
    .wdata(pif_1.wdata_1),
    .rdata(pif_1.rdata_1),
    .addr(pif_1.addr_1),
    .ready(pif_1.ready_1));
  
  initial begin
    uvm_config_db#(virtual mem_intf)::set(null,"*","pif_1",pif_1);
    uvm_config_db#(virtual mem_intf)::set(null,"*","pif_2",pif_2);
    #1000
    $finish;
  end
    
  initial begin
    rstn_1=0;
    repeat(2)@(posedge clk_1);
    rstn_1=1;
  end
  
  initial begin
    rstn_2=0;
    repeat(2)@(posedge clk_2);
    rstn_2=1;
  end
    
  
  initial begin
    run_test("mem_test");
  end
  
  initial begin
    $dumpfile("dump.vcd"); 
    $dumpvars(0,top);
  end
endmodule