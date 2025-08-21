class mem_tx3 extends mem_tx;
  `new_obj
  `uvm_object_utils(mem_tx3)
  
  constraint a_c{addr_1 < 15;}
endclass