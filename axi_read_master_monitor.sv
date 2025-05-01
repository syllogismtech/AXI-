class axi_read_master_monitor extends uvm_monitor;
  virtual axi_if vif;
  uvm_analysis_port #(axi_read_master_transaction) m_ap;

  `uvm_component_utils(axi_read_master_monitor)

  function new(string name, uvm_component parent);
    super.new(name, parent);
    m_ap = new("m_ap", this);
  endfunction

  function void build_phase(uvm_phase phase);
    if (!uvm_config_db #(virtual axi_if)::get(this, "", "vif", vif))
      `uvm_fatal("M_MON", "Interface not found")
  endfunction

  task run_phase(uvm_phase phase);
    axi_read_master_transaction tx;
    forever begin
      tr=axi_read_master_transaction::type_id::create("tr");
      @(posedge vif.clk);
      if (vif.arvalid && vif.arready) begin
        tx = axi_read_item::type_id::create("tx");
        tx.araddr  = vif.araddr;
        tx.arlen   = vif.arlen;
        tx.arburst = vif.arburst;
        tx.arvalid = vif.arvalid;
        m_ap.write(tx);
      end
    end
  endtask
endclass
