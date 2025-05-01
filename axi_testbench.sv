  import uvm_pkg::*;
  `include "uvm_macros.svh" 

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
    run_test("axi_read_test");
  end

endmodule
