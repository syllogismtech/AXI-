class axi_read_scoreboard extends uvm_scoreboard;

  `uvm_component_utils(axi_read_scoreboard)

  uvm_analysis_imp#(axi_read_master_transaction, axi_read_scoreboard) m_scb;
  uvm_analysis_imp#(axi_read_slave_transaction,  axi_read_scoreboard) s_scb;

  axi_read_master_transaction master_q[$];
  axi_read_slave_transaction  slave_q[$];

  function new(string name, uvm_component parent);
    super.new(name, parent);
    master_ap = new("master_ap", this);
    slave_ap  = new("slave_ap", this);
  endfunction

  function void write(axi_read_master_transaction t);
    master_q.push_back(t);
  endfunction

  function void write(axi_read_slave_transaction t);
    slave_q.push_back(t);
  endfunction

  task run_phase(uvm_phase phase);
    super.run_phase(phase);

    axi_read_master_transaction master_txn;
    axi_read_slave_transaction  slave_txn;

    forever begin
      wait (master_q.size() > 0 && slave_q.size() > 0);

      master_txn = master_q.pop_front();
      int burst_len = master_txn.arlen + 1;

      for (int i = 0; i < burst_len; i++) begin
        wait (slave_q.size() > 0);
        slave_txn = slave_q.pop_front();

        if (slave_txn.rid !== master_txn.arid) begin
          `uvm_error("SCOREBOARD", $sformatf("ID mismatch: Expected ID = %0h, Got = %0h",
                      master_txn.arid, slave_txn.rid))
        end

        if (slave_txn.rdata !== master_txn.expected_rdata[i]) begin
          `uvm_error("SCOREBOARD", $sformatf("Data mismatch at beat %0d: Expected = %0h, Got = %0h",
                      i, master_txn.expected_rdata[i], slave_txn.rdata))
        end
        else begin
          `uvm_info("SCOREBOARD", $sformatf("Beat %0d match: Data = %0h", i, slave_txn.rdata), UVM_LOW)
        end
      end
    end
  endtask

endclass
