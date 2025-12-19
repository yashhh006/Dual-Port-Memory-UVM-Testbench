class mem_test extends uvm_test;
  mem_env env;
  
  `uvm_component_utils(mem_test)
  
  `new_comp
  
  function void build_phase(uvm_phase phase);
    //GLOBAL
    
    set_type_override_by_type(mem_drv::get_type(),mem_drv3::get_type());
    uvm_factory::get().set_type_override_by_name("mem_tx","mem_tx3");
    
    uvm_factory::get().print();
    //INST
    
    //set_type_override_by_name("mem_drv","mem_drv2");
    //set_inst_override_by_name("env.agt.drv","mem_drv","mem_drv3");
    
    /*
    factory checks for overrides when "create" method is called, so it is crucial to write all the overrides method before the factory registration
    */
    
    env=mem_env::type_id::create("env",this);
  endfunction
  
  function void end_of_elaboration_phase(uvm_phase phase);
    super.end_of_elaboration_phase(phase);
    uvm_top.print_topology();
  endfunction
  
  task run_phase(uvm_phase phase);
    //Port1
    mem_seq seq;
    //Port2
    mem_seq2 seq2;
    
    seq=mem_seq::type_id::create("seq");
    seq2=mem_seq2::type_id::create("seq2");
    
    phase.raise_objection(this);
    fork
      seq.start(env.agt.sqr);
      seq2.start(env.agt2.sqr2);
    join
    phase.phase_done.set_drain_time(this,50);
    phase.drop_objection(this);
  endtask
  
  //function void report_phase(uvm_phase phase);
  //  if(mem_comm::matchings==0 || mem_comm::mismatchings>0)
  //    `uvm_error("MEM_TEST","TESTCASE FAILED")
  //  else
  //    `uvm_info("MEM_TEST","TESTCASE PASSED",UVM_LOW)
  //endfunction
endclass

class mem_test_2 extends mem_test;
  `uvm_component_utils(mem_test_2)
  `new_comp
  
  task run_phase(uvm_phase phase);
    //Port1
    mem_seq_only_wr seq;
    //Port2
    mem_seq2_only_rd seq2;
    
    seq=mem_seq_only_wr::type_id::create("seq");
    seq2=mem_seq2_only_rd::type_id::create("seq2");
    
    phase.raise_objection(this);
    fork
      seq.start(env.agt.sqr);
      seq2.start(env.agt2.sqr2);
    join
    phase.phase_done.set_drain_time(this,50);
    phase.drop_objection(this);
    
  endtask
endclass

class mem_test_1wr_1rd extends mem_test;
  `uvm_component_utils(mem_test_1wr_1rd)
  `new_comp
  
  task run_phase(uvm_phase phase);
    //Port1
    mem_seq_1wr seq;
    //Port2
    mem_seq2_1rd seq2;
    
    seq=mem_seq_1wr::type_id::create("seq");
    seq2=mem_seq2_1rd::type_id::create("seq2");
    
    phase.raise_objection(this);
    fork
      seq.start(env.agt.sqr);
      seq2.start(env.agt2.sqr2);
    join
    phase.phase_done.set_drain_time(this,50);
    phase.drop_objection(this);
    
  endtask
endclass
