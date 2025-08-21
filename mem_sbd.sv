class mem_sbd extends uvm_scoreboard;
  `uvm_component_utils(mem_sbd)
  uvm_analysis_imp#(mem_tx,mem_sbd) sbd_imp;
  //`new_comp
  
  function new(string name="",uvm_component parent=null);
    super.new(name,parent);
    sbd_imp=new("sbd_imp",this);
  endfunction
  
  //function void build_phase(uvm_phase phase);
  //  super.build_phase(phase);
  //endfunction
  
  
  //TLM method > must be implemented in the cov class
  function void write(mem_tx t);
    
  endfunction
endclass