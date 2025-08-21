interface mem_intf(input bit clk_1,rstn_1,clk_2,rstn_2);
  bit write_1,valid_1;
  bit [`width-1:0]wdata_1;
  bit [`addr_width-1:0]addr_1;
  bit ready_1;
  bit [`width-1:0]rdata_1;
  
  bit write_2,valid_2;
  bit [`width-1:0]wdata_2;
  bit [`addr_width-1:0]addr_2;
  bit ready_2;
  bit [`width-1:0]rdata_2;
  
  clocking cb_drv1@(posedge clk_1);
    default input #0 output #1;
    output write_1;
    output valid_1;
    output addr_1;
    output wdata_1;
    input ready_1;
    input rdata_1 ;
  endclocking
  
  clocking cb_mon1@(posedge clk_1);
    default input #1;
    input write_1;
    input valid_1;
    input addr_1;
    input wdata_1;
    input ready_1;
    input rdata_1;
  endclocking
  
  clocking cb_drv2@(posedge clk_2);
    default input #0 output #1;
    output write_2;
    output valid_2;
    output addr_2;
    output wdata_2;
    input ready_2;
    input rdata_2;
  endclocking
  
  clocking cb_mon2@(posedge clk_2);
    default input #1;
    input write_2;
    input valid_2;
    input addr_2;
    input wdata_2;
    input ready_2;
    input rdata_2;
  endclocking
endinterface