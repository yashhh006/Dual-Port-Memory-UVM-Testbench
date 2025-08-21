class mem_drv3 extends mem_drv;
  `new_comp
  `uvm_component_utils(mem_drv3)
  
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
  endfunction
  
  task run();
    super.run();
  endtask
endclass