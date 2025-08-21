class mem_cov2 extends uvm_subscriber#(mem_tx2);
  `uvm_component_utils(mem_cov2);
  mem_tx2 tx2;
  
  covergroup cg2;
    wr_rd_2:coverpoint tx2.write_2{
      bins write={1'b1};
      bins reads ={1'b0};
      option.comment="WRR2";}
    
    addr2_cg:coverpoint tx2.addr_2{
      option.auto_bin_max=8;
      option.comment="ADD";
      option.at_least =1;
    }
    
    wr_rd_2Xaddr2_cg: cross wr_rd_2, addr2_cg{
      option.weight=4;
      option.comment="CROSS2";
      option.at_least =1;}
  endgroup
  
  function new(string name="",uvm_component parent);
    super.new(name,parent);
    cg2=new();
  endfunction
  
  //TLM method > must be implemented in the cov class
  function void write(mem_tx2 t);
    this.tx2=t;    //converting the t object handle to the tx by copy by handle
    cg2.sample();
  endfunction
  
  function void report_phase(uvm_phase phase);
    `uvm_info(get_full_name(),$sformatf("Addr2 Coverage is %0.2f %%",
                                        cg2.addr2_cg.get_coverage()),UVM_LOW);
    `uvm_info(get_full_name(),$sformatf("Write Coverage is %0.2f %%",
                                        cg2.wr_rd_2.get_coverage()),UVM_LOW);
    `uvm_info(get_full_name(),$sformatf("Cross Coverage is %0.2f %%",                                      cg2.wr_rd_2Xaddr2_cg.get_coverage()),UVM_LOW);
  endfunction
endclass