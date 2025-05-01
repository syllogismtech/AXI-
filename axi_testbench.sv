 import uvm_pkg::*;
`include "uvm_macros.svh" 
`include "axi_read_slave_transaction.sv"
`include "axi_read_master_transaction.sv"
`include "axi_read_master_seq.sv"
`include "axi_read_slave_seq.sv"
`include "axi_read_master_sequencer.sv"
`include "axi_read_read_sequencer.sv"
`include "axi_read_master_agent.sv"
`include "axi_read_slave_agent.sv"
`include "axi_read_master_driver.sv"
`include "axi_read_slave_driver.sv"
`include "axi_read_master_monitor.sv"
`include "axi_read_slave_monitor.sv"
`include "axi_read_env.sv"
`include "axi_read_scoreboard.sv"
`include "axi_read_test.sv"


module testbench;
  read_interface in();  

  dut u_dut (
    .araddr   (in.araddr),
    .arlen    (in.arlen),
    .arvalid  (in.arvalid),
    .arready  (in.arready),
    .arburst  (in.arburst),
    .rdata    (in.rdata),
    .rvalid   (in.rvalid),
    .rready   (in.rready),
    .rlast    (in.rlast)
  );

  initial begin
    uvm_config_db#(virtual axi_read_if)::set(null, "*", "vif", in);
  end
  
  initial begin
    run_test("axi_read_test");
  end

endmodule
