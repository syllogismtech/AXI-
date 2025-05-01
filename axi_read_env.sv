class axi_read_env extends uvm_env;
  axi_read_master_agent m_agt;
  axi_read_slave_agent  s_agt;
  axi_read_scoreboard   scb;

  `uvm_component_utils(axi_read_env)

  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);   
    m_agt    = axi_read_master_agent::type_id::create("m_agt", this);
    s_agt    = axi_read_slave_agent::type_id::create("s_agt", this);
    scb = axi_read_scoreboard::type_id::create("scb", this);
  endfunction

  function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    m_agt.m_mon.m_ap.connect(scb.m_scb);
    s_agt.s_mon.s_ap.connect(scb.s_scb);
  endfunction
  
endclass

