class mem_seq2 extends uvm_sequence#(mem_tx2);
  
  `uvm_object_utils(mem_seq2)
  `new_obj
  mem_tx tx2;
  int q_2[$];
  int temp_2;
  
  task body;
    //Write_1
    repeat(5)begin
      `uvm_do_with(req,{req.write_2==1;});
      //req.print();
      q_2.push_back(req.addr_2);
    end
    
    //Read_1
    repeat(5)begin
      temp_2=q_2.pop_front();
      `uvm_do_with(req,{req.write_2==0; req.addr_2==temp_2;});
      //req.print();
    end
  endtask
endclass