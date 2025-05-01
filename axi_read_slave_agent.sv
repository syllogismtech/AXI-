class axi_read_slave_agent extends uvm_agent;
  axi_read_slave_driver s_driv;
  axi_read_slave_monitor s_mon; 
  axi_read_slave_sequencer s_seqr;

  `uvm_component_utils(axi_read_slave_agent)

  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction

  function void build_phase(uvm_phase phase);
    s_driv  = axi_read_slave_driver::type_id::create("s_driv", this);
    s_mon= axi_read_slave_monitor::type_id::create("s_mon", this);
    s_seqr = axi_read_slave_sequencer::type_id::create("s_seqr", this);

  endfunction

  function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    s_driv.seq_item_port.connect(s_mon.seq_item_export);
  endfunction
endclass
