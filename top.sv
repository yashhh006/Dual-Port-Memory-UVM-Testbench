`include "assertions.sv"

module top;
  bit clk_1,rstn_1;
  bit clk_2,rstn_2;
  mem_intf pif(clk_1,rstn_1,clk_2,rstn_2);
  //mem_intf pif(clk_1,rstn_1,clk_2,rstn_2);
  
  always #5 clk_1=~clk_1;
  always #5 clk_2=~clk_2;
  
  memory #(`width,`depth,`addr_width) dut(
    .clk_1(pif.clk_1),
    .rstn_1(pif.rstn_1),
    .write_1(pif.write_1),
    .valid_1(pif.valid_1),
    .wdata_1(pif.wdata_1),
    .rdata_1(pif.rdata_1),
    .addr_1(pif.addr_1),
    .ready_1(pif.ready_1),
    
    //Port 2
    .clk_2(pif.clk_2),
    .rstn_2(pif.rstn_2),
    .write_2(pif.write_2),
    .valid_2(pif.valid_2),
    .wdata_2(pif.wdata_2),
    .rdata_2(pif.rdata_2),
    .addr_2(pif.addr_2),
    .ready_2(pif.ready_2));
  
  assertions #(`width,`depth,`addr_width)uut(
    .clk(pif.clk_1),
    .rstn(pif.rstn_1),
    .write(pif.write_1),
    .valid(pif.valid_1),
    .wdata(pif.wdata_1),
    .rdata(pif.rdata_1),
    .addr(pif.addr_1),
    .ready(pif.ready_1));
  
  initial begin
    uvm_config_db#(virtual mem_intf)::set(null,"*","pif",pif);
    //uvm_config_db#(virtual mem_intf)::set(null,"*","pif",pif);
    //#1000
    //$finish;
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
    run_test("mem_test_2");
  end
  
  initial begin
    $dumpfile("dump.vcd"); 
    $dumpvars(0,top);
  end
endmodule
