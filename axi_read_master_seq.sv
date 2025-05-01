class axi_read_master_seq extends uvm_sequence #(axi_read_master_transaction);
  `uvm_object_utils(axi_read_master_seq)

  function new(string name = "axi_read_master_seq");
    super.new(name);
  endfunction

  virtual task body();
    repeat(5) begin
      req = axi_read_master_transaction::type_id::create("req");
      wait_for_grant();
      assert(req.randomize());
      wait_for_item_done();

    end
  endtask
endclass
