class axi_read_master_agent extends uvm_agent;
  axi_read_master_driver m_driv;
  axi_read_master_monitor m_mon; 
  axi_read_master_sequencer m_seqr;

  `uvm_component_utils(axi_read_master_agent)

  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction

  function void build_phase(uvm_phase phase);
    m_driv  = axi_read_master_driver::type_id::create("m_driv", this);
    m_mon = axi_read_master_monitor::type_id::create("m_mon", this);
    m_seqr = axi_read_master_sequencer::type_id::create("m_seqr", this);

  endfunction

  function void connect_phase(uvm_phase phase);
    m_driv.seq_item_port.connect(m_mon.seq_item_export);
  endfunction
endclass
