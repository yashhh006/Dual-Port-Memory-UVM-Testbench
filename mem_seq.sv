class mem_seq extends uvm_sequence#(mem_tx);
  
  `uvm_object_utils(mem_seq)
  `new_obj
  mem_tx tx;
  int q_1[$];
  int temp_1;
  
  task body;
    //Write_1
    repeat(5)begin
      `uvm_do_with(req,{req.write_1==1;});
      //req.print();
      q_1.push_back(req.addr_1);
    end
    
    //Read_1
    repeat(5)begin
      temp_1=q_1.pop_front();
      `uvm_do_with(req,{req.write_1==0; req.addr_1==temp_1;});
      //req.print();
    end
  endtask
endclass