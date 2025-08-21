class mem_cov extends uvm_subscriber#(mem_tx);
  `uvm_component_utils(mem_cov);
  mem_tx tx;
  
  covergroup cg;
    wr_rd_1: coverpoint tx.write_1{
      bins writes={1'b1};
      bins reads ={1'b0};
      option.comment="WRR";}
    
    addr1_cg:coverpoint tx.addr_1{
      option.auto_bin_max=8;
      option.comment="ADD";
      option.at_least =1;
    }
    
    wr_rd_1Xaddr1_cg: cross wr_rd_1, addr1_cg{
      option.weight=4;
      option.comment="CROSS";
      option.at_least =1;}
  endgroup
  
  function new(string name="",uvm_component parent);
    super.new(name,parent);
    cg=new();
  endfunction
  
  function void write(mem_tx t);
    
  endfunction
  
  function void report_phase(uvm_phase phase);
    `uvm_info(get_full_name(),$sformatf("Addr1 Coverage is %0.2f %%",
                                        cg.addr1_cg.get_coverage()),UVM_LOW);
    `uvm_info(get_full_name(),$sformatf("Write1 Coverage is %0.2f %%",
                                        cg.wr_rd_1.get_coverage()),UVM_LOW);
    `uvm_info(get_full_name(),$sformatf("Cross-1 Coverage is %0.2f %%",                                      cg.wr_rd_1Xaddr1_cg.get_coverage()),UVM_LOW);
  endfunction
endclass