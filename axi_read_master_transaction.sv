class axi_read_master_transaction extends uvm_sequence_item;
  'uvm_object_utils(axi_read_master_transaction)
  rand bit[31:0] araddr;
  rand bit [7:0] arlen;
  rand bit [2:0] arsize;
  rand bit [1:0] arburst;
  rand bit arready;
  bit arvalid;
  
  function new(string name ="axi_read_master_transaction");
    super.new(name);
  endfunction
endclass																								
