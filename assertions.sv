module assertions(clk,rstn,addr,write,valid,wdata,ready,rdata);
  parameter width=8;
  parameter depth=32;
  parameter addr_width=$clog2(depth);
  
  input clk,rstn,write,valid;
  input [width-1:0]wdata;
  input [addr_width-1:0]addr;
  input ready;
  input [width-1:0]rdata;
  
  property reset();
    @(posedge clk)  (rstn==0) |-> (rdata==0);
  endproperty
  
  RESET:assert property(reset);
    
  property one();
    @(posedge clk) (valid==1) |=> ##[0:3](ready==1);
  endproperty
  
  ONE:assert property(one);
    
  property two();
    @(posedge clk) valid |=> ##[0:3]$stable(wdata);
  endproperty
  
  TWO:assert property(two);
    
  property three();
    @(posedge clk) (addr==7) |-> $countones(wdata)==3;
  endproperty
  
  //THREE: assert property(three);
    
  //property four();
  //  @(posedge clk) (addr==12) |-> $countones(wdata)==4;
  //endproperty
  //
  //FOUR: assert property(three);
  
endmodule