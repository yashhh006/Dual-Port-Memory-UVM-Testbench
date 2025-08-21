class mem_tx2 extends uvm_sequence_item;
  
  rand bit write_2;
  rand bit [`width-1:0]wdata_2;
  rand bit [`addr_width-1:0]addr_2;
  
  `new_obj
  `uvm_object_utils_begin(mem_tx2)
  `uvm_field_int(addr_2,UVM_ALL_ON)
  `uvm_field_int(wdata_2,UVM_ALL_ON)
  `uvm_field_int(write_2,UVM_ALL_ON)
  `uvm_object_utils_end
  
endclass