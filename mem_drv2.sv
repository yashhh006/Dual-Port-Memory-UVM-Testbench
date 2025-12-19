class mem_drv2 extends uvm_driver#(mem_tx2);
  `new_comp
  `uvm_component_utils(mem_drv2)
  virtual mem_intf vif_2;
  
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    uvm_config_db#(virtual mem_intf)::get(this,"","pif",vif_2);
  endfunction
  
  task run_phase(uvm_phase phase);
    forever begin
      seq_item_port.get_next_item(req);
      drive_tx(req);
      seq_item_port.item_done();
    end
  endtask
  
  task drive_tx(mem_tx2 tx);
    @(vif_2.cb_drv2);
    vif_2.cb_drv2.write_2<=tx.write_2;
    vif_2.cb_drv2.addr_2<=tx.addr_2;
    if(tx.write_2==1)
      vif_2.cb_drv2.wdata_2<=tx.wdata_2;
    vif_2.cb_drv2.valid_2<=1;
    wait(vif_2.cb_drv2.ready_2==1);
    if(tx.write_2==0)begin
      @(vif_2.cb_drv2);
      tx.wdata_2<=vif_2.cb_drv2.rdata_2;
    end
    //@(vif_2.cb_drv2);
    vif_2.cb_drv2.valid_2<=0;
  endtask
endclass
