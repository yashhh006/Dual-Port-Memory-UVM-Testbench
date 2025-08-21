class mem_mon extends uvm_monitor;
  `uvm_component_utils(mem_mon)
  uvm_analysis_port #(mem_tx) ap_port;
  mem_tx tx;
  virtual mem_intf vif_1;
  
  function new(string name="", uvm_component parent=null);
    super.new(name,parent);
    ap_port=new("ap_port",this);
  endfunction
  
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    uvm_config_db#(virtual mem_intf)::get(this,"","pif_1",vif_1);
  endfunction
  
  function void write(mem_tx t);
    
  endfunction
  
  task run_phase(uvm_phase phase);
    forever begin
      @(vif_1.cb_mon1);
      if(vif_1.cb_mon1.valid_1==1 && vif_1.cb_mon1.ready_1==1)begin
        tx=new();
        tx.write_1=vif_1.cb_mon1.write_1;
        tx.addr_1=vif_1.cb_mon1.addr_1;
        if(vif_1.cb_mon1.write_1==1)
          tx.wdata_1=vif_1.cb_mon1.wdata_1;
        else tx.wdata_1=vif_1.cb_mon1.rdata_1;
        
        tx.print();
        ap_port.write(tx);
      end
    end
  endtask
endclass