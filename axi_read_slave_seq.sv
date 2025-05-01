class axi_read_slave_seq extends uvm_sequence #(axi_read_slave_transaction);
  `uvm_object_utils(axi_read_slave_seq)

  function new(string name = "axi_read_slave_seq");
    super.new(name);
  endfunction

  virtual task body();
  endtask
endclass
