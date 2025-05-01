class axi_read_slave_monitor extends uvm_monitor;
  virtual read_interface vif;
  uvm_analysis_port #(axi_read_slave_transaction) s_ap;

  `uvm_component_utils(axi_read_slave_monitor)

  function new(string name, uvm_component parent);
    super.new(name, parent);
    s_ap = new("s_ap", this);
  endfunction

  function void build_phase(uvm_phase phase);
    if (!uvm_config_db #(virtual axi_if)::get(this, "", "vif", vif))
      `uvm_fatal("S_MON", "Interface not found")
  endfunction

  task run_phase(uvm_phase phase);
    axi_read_slave_transaction rx;
    forever begin
      @(posedge vif.clk);
      if (vif.rvalid && vif.rready) begin
        rx = axi_read_slave_transaction::type_id::create("rx");
        rx.rdata = vif.rdata;
        rx.rlast = vif.rlast;
        s_ap.write(rx);
      end
    end
  endtask
endclass
