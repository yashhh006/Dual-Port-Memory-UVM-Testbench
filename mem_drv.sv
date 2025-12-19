class mem_drv extends uvm_driver#(mem_tx);
  `new_comp
  `uvm_component_utils(mem_drv)
  virtual mem_intf vif_1;
  
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    uvm_config_db#(virtual mem_intf)::get(this,"","pif",vif_1);
  endfunction
  
  task run_phase(uvm_phase phase);
    forever begin
      seq_item_port.get_next_item(req);
      drive_tx(req);
      seq_item_port.item_done();
    end
  endtask
  
  task drive_tx(mem_tx tx);
    @(vif_1.cb_drv1);
    vif_1.cb_drv1.write_1<=tx.write_1;
    vif_1.cb_drv1.addr_1<=tx.addr_1;
    if(tx.write_1==1)
      vif_1.cb_drv1.wdata_1<=tx.wdata_1;
    vif_1.cb_drv1.valid_1<=1;
    wait(vif_1.cb_drv1.ready_1==1);
    if(tx.write_1==0)begin
      @(vif_1.cb_drv1);
      tx.wdata_1<=vif_1.cb_drv1.rdata_1;
    end
    @(vif_1.cb_drv1);
    vif_1.cb_drv1.valid_1<=0;
  endtask
endclass
