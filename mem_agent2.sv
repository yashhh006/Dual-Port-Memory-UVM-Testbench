class mem_agent2 extends uvm_agent;
  `new_comp
  `uvm_component_utils(mem_agent2)
  
  mem_sqr2 sqr2;
  mem_drv2 drv2;
  mem_mon2 mon2;
  mem_cov2 cov2;
  
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    sqr2=mem_sqr2::type_id::create("agt2",this);
    drv2=mem_drv2::type_id::create("drv2",this);
    mon2=mem_mon2::type_id::create("mon2",this);
    cov2=mem_cov2::type_id::create("cov2",this);
  endfunction
  
  function void connect_phase(uvm_phase phase);
    drv2.seq_item_port.connect(sqr2.seq_item_export);
    mon2.ap_port_2.connect(cov2.analysis_export);
  endfunction
endclass