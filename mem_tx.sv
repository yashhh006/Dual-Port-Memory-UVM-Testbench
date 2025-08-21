class mem_tx extends uvm_sequence_item;
  
  rand bit write_1;
  rand bit [`width-1:0]wdata_1;
  rand bit [`addr_width-1:0]addr_1;
  
  `new_obj
  `uvm_object_utils_begin(mem_tx)
  `uvm_field_int(addr_1,UVM_ALL_ON)
  `uvm_field_int(wdata_1,UVM_ALL_ON)
  `uvm_field_int(write_1,UVM_ALL_ON)
  `uvm_object_utils_end
  
endclass