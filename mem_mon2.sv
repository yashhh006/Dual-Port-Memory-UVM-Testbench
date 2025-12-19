class mem_mon2 extends uvm_monitor;
  `uvm_component_utils(mem_mon2)
  uvm_analysis_port #(mem_tx2) ap_port_2;
  mem_tx2 tx2;
  virtual mem_intf vif_2;
  
  function new(string name="", uvm_component parent=null);
    super.new(name,parent);
    ap_port_2=new("ap_port_2",this);
  endfunction
  
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    uvm_config_db#(virtual mem_intf)::get(this,"","pif",vif_2);
  endfunction
  
  task run_phase(uvm_phase phase);
    forever begin
      @(vif_2.cb_mon2);
      if(vif_2.cb_mon2.valid_2==1 && vif_2.cb_mon2.ready_2==1)begin
        tx2=new();
        tx2.write_2=vif_2.cb_mon2.write_2;
        tx2.addr_2=vif_2.cb_mon2.addr_2;
        if(vif_2.cb_mon2.write_2==1)
          tx2.wdata_2=vif_2.cb_mon2.wdata_2;
        else tx2.wdata_2=vif_2.cb_mon2.rdata_2;
        
        tx2.print();
        ap_port_2.write(tx2);
      end
    end
  endtask

endclass
