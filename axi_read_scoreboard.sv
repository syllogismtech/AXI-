class axi_read_scoreboard extends uvm_scoreboard;
  `uvm_component_utils(axi_read_scoreboard)

  uvm_analysis_imp #(axi_read_item, axi_read_scoreboard) master_ap;
  uvm_analysis_imp #(axi_read_item, axi_read_scoreboard) slave_ap;

  axi_read_item master_q[$]; 
  axi_read_item slave_q[$];  

  function new(string name, uvm_component parent);
    super.new(name, parent);
    master_ap = new("master_ap", this);
    slave_ap  = new("slave_ap", this);
  endfunction

  function void write(input axi_read_item t);
    if (t.is_read_address) begin
      master_q.push_back(t);
    end
    else begin
      slave_q.push_back(t);
    end
  endfunction

  task run_phase(uvm_phase phase);
    forever begin
      wait (master_q.size() > 0 && slave_q.size() > 0);

      axi_read_item master_txn;
      axi_read_item slave_txn;

      master_txn = master_q.pop_front();
      int burst_len = master_txn.arlen + 1;

      for (int i = 0; i < burst_len; i++) begin
        wait (slave_q.size() > 0);
        slave_txn = slave_q.pop_front();

    
        if (slave_txn.rdata !== master_txn.expected_rdata[i]) begin
          `uvm_error("SCOREBOARD", $sformatf("Data mismatch at beat %0d: expected %0h, got %0h",
                        i, master_txn.expected_rdata[i], slave_txn.rdata))
        end else begin
          `uvm_info("SCOREBOARD", $sformatf("Read matched at beat %0d: %0h", i, slave_txn.rdata), UVM_LOW)
        end
      end
    end
  endtask
endclass
