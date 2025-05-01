interface read_interface #(parameter ADDR_WIDTH = 32, DATA_WIDTH = 64, ID_WIDTH = 4); 
  logic clk;
  logic reset;

  logic [ADDR_WIDTH-1:0]   ARADDR;
  logic [7:0]              ARLEN;
  logic [2:0]              ARSIZE;
  logic [1:0]              ARBURST;
  logic                    ARVALID;
  logic                    ARREADY;

  logic [DATA_WIDTH-1:0]   RDATA;
  //logic [1:0]              RRESP;
  logic                    RLAST;
  logic                    RVALID;
  logic                    RREADY;
  
endinterface
