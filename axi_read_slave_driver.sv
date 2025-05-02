class axi_read_slave_driver extends uvm_driver #(axi_read_slave_transaction);
  virtual read_interface vif;
  `uvm_component_utils(axi_read_slave_driver)

  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction

  function void build_phase(uvm_phase phase);
    if (!uvm_config_db #(virtual read_interface)::get(this, "", "vif", vif))
      `uvm_fatal("SLV_DRV", "Interface not found")
  endfunction

  task run_phase(uvm_phase phase);
    forever begin
      
      @(posedge vif.clk);
      if (vif.arvalid && vif.arready) begin
        int burst_len = vif.arlen;
        bit [3:0] read_id;
        read_id =vif.arid;

        
        for (int i = 0; i <= burst_len; i++) begin
          vif.rdata  <= vif.araddr+8;
          vif.rvalid <= 1;
          vif.rlast  <= (i == burst_len);
          vif.rid <=read_id;

          
          @(posedge vif.clk);
          while (!vif.rready) @(posedge vif.clk);

          vif.rvalid <= 0;
          vif.rlast  <= 0;
        end
      end
    end
  endtask
endclass
