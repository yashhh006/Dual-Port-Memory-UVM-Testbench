class mem_env extends uvm_env;
  `uvm_component_utils(mem_env)
  
  mem_agent agt;
  mem_agent2 agt2;
  mem_sbd sbd;
  
  `new_comp
  
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    sbd=mem_sbd::type_id::create("scb",this);
    agt= mem_agent::type_id::create("agt",this);
    agt2= mem_agent2::type_id::create("agt2",this);
    
  endfunction
  
  function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    //agt.mon.ap_port.connect(sbd.sbd_imp);
  endfunction
endclass