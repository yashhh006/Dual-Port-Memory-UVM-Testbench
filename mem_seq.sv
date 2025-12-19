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

class mem_seq_only_wr extends mem_seq;
  `uvm_object_utils(mem_seq_only_wr)
  `new_obj
  
  mem_tx tx;
  
  task body();
    for(int i=0;i<`depth;i++)begin
      `uvm_do_with(req,{req.write_1==1; req.addr_1==i;});
    end
    
    //for(int i=0;i<`depth;i++)begin
    //  `uvm_do_with(req,{req.write_1==0; req.addr_1==i;});
    //end
  endtask
endclass

class mem_seq_1wr extends mem_seq;
  `uvm_object_utils(mem_seq_1wr);
  `new_obj
  
  mem_tx tx;
  
  task body();
    `uvm_do_with(req,{req.write_1==1; req.addr_1==0; req.wdata_1==5;});
    `uvm_do_with(req,{req.write_1==1; req.addr_1==1; req.wdata_1==10;});
    `uvm_do_with(req,{req.write_1==1; req.addr_1==2; req.wdata_1==15;});
    `uvm_do_with(req,{req.write_1==1; req.addr_1==0; req.wdata_1==55;});
  endtask
endclass
