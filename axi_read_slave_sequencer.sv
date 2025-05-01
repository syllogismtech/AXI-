class axi_read_slave_sequencer extends uvm_sequencer #(axi_read_slave_transaction);
  `uvm_component_utils(axi_read_slave_sequencer)

  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction
endclass
