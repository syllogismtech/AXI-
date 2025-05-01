class axi_read_test extends uvm_test;
  axi_read_env env;

  `uvm_component_utils(axi_read_test)

  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    env = axi_read_env::type_id::create("env", this);
  endfunction

  task run_phase(uvm_phase phase);
    axi_read_master_sequence m_seq;
    axi_read_slave_sequence  s_seq;

    phase.raise_objection(this);
  
    m_seq = axi_read_master_sequence::type_id::create("master_seq");
    m_seq.start(env.m_agt.m_mon); 

    phase.drop_objection(this);
  endtask
endclass
