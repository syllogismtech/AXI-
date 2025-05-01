class axi_read_slave_transaction extends uvm_sequence_item;
  'uvm_object_utils(axi_read_slave_transaction)
  bit [63:0] rdata;
  bit[1:0] rresp;
  bit rlast;
  bit rready;
  
  function new(string name="axi_read_slave_transaction");
    super.new(name);
  endfunction
endclass
