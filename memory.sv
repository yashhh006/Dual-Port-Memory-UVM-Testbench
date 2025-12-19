module memory(clk_1,rstn_1,addr_1,write_1,valid_1,wdata_1,ready_1,rdata_1,
             clk_2,rstn_2,addr_2,write_2,valid_2,wdata_2,ready_2,rdata_2);
  parameter width=8;
  parameter depth=32;
  parameter addr_width=$clog2(depth);
  
  //Port_1
  input clk_1,rstn_1,write_1,valid_1;
  input [width-1:0]wdata_1;
  input [addr_width-1:0]addr_1;
  output reg ready_1;
  output reg [width-1:0]rdata_1;
  
  //Port_2
  input clk_2,rstn_2,write_2,valid_2;
  input [width-1:0]wdata_2;
  input [addr_width-1:0]addr_2;
  output reg ready_2;
  output reg [width-1:0]rdata_2;
  
  reg [width-1:0]temp[depth-1:0];
  bit [width-1:0]flag[depth-1:0];
  
  //initial begin
  //  write_1=0;
  //  valid_1=0;
  //  addr_1=0;
  //  wdata_1=0;
  //  ready_1=0;
  //  rdata_1=0;
  //  
  //  write_2=0;
  //  valid_2=0;
  //  addr_2=0;
  //  wdata_2=0;
  //  ready_2=0;
  //  rdata_2=0;
  //end
  
  //Port_1
  always@(posedge clk_1)begin
    if(!rstn_1)begin
      ready_1<=0;
      rdata_1<=0;
      for(int i=0;i<depth;i++)temp[i]=0;
    end
    else begin
      if(valid_1==1)begin
        ready_1<=1;
        if(write_1==1)begin 
          temp[addr_1]<=wdata_1;
          `uvm_info("MEM_WRITE",($sformatf("temp[%0d]=%0h",addr_1,wdata_1))
                    ,UVM_LOW)
        end
        else begin
          if (valid_2 && write_2 && (addr_1==addr_2)) begin
               // FORWARDING FROM PORT 2 -> PORT 1
               rdata_1<=wdata_2; 
               `uvm_info("MEM_READ_FWD", "Port 1 read new data from Port 2", UVM_LOW)
           end
           else begin
               // Normal Read
               rdata_1<=temp[addr_1];
           end
        end
        `uvm_info("MEMORY",($sformatf("temp=%p",temp)),UVM_LOW)
      end
      else ready_1<=0;
    end
  end
  
  //Port_2
  always@(posedge clk_2)begin
    if(!rstn_2)begin
      ready_2<=0;
      rdata_2<=0;
      for(int i=0;i<depth;i++)temp[i]=0;
    end
    else begin
      if(valid_2==1)begin
        ready_2<=1;
        if(write_2==1)begin
          temp[addr_2]<=wdata_2;
          `uvm_info("MEM_WRITE2",($sformatf("temp[%0d]=%0h",addr_2,
                                            wdata_2)),UVM_LOW)
        end
        else begin
          if (valid_1 && write_1 && (addr_1==addr_2)) begin
              // COLLISION DETECTED: Forward the data directly!
              rdata_2<=wdata_1;
              `uvm_info("MEM_READ_FWD", $sformatf("Forwarded New Data: %0h", wdata_1), UVM_LOW)
          end
          else begin
              // NO COLLISION: Read from memory array normally
              rdata_2<=temp[addr_2];
              `uvm_info("MEM_READ", $sformatf("Read Old Data: %0h", temp[addr_2]), UVM_LOW)
          end
        end
        `uvm_info("MEMORY",($sformatf("temp=%p",temp)),UVM_LOW)
      end
      else ready_2<=0;
    end
  end
endmodule
