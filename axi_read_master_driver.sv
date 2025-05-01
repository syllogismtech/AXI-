class axi_read_master_driver extends uvm_driver #(axi_read_master_transaction);
  virtual read_interface vif;
  `uvm_component_utils(axi_read_master_driver)

  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    if (!uvm_config_db #(virtual axi_if)::get(this, "", "vif", vif))
      `uvm_fatal("DRV", "Interface not found")
  endfunction

  task run_phase(uvm_phase phase);
    axi_read_master_transaction tr;
    forever begin
      seq_item_port.get_next_item(tr);
      vif.araddr <= tr.araddr;
      vif.arid   <= tr.arsize;
      vif.arlen  <= tr.arlen;
      vif.arburst  <= 2'b01;
      vif.arvalid <= tr.arvalid;
      @(posedge vif.clk);
      while (!vif.arready) @(posedge vif.clk);
      vif.arvalid <= 0;
      seq_item_port.item_done();
    end
  endtask
endclass
