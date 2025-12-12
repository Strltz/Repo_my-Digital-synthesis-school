//----------------------------------------------------------------------------
// Example
//----------------------------------------------------------------------------

module add
(
  input  [3:0] a, b,
  output [3:0] sum
);

  assign sum = a + b;

endmodule

//----------------------------------------------------------------------------
// Task
//----------------------------------------------------------------------------

module signed_add_with_saturation
(
  input  [3:0] a, b,
  output [3:0] sum
);

  logic [4:0] help_sum;
  logic [3:0] sum2;

  assign help_sum = a + b;

  always_comb begin
    if (a[3] == b[3]) begin
      if (a[3] == 1) begin
        if (a[3] != help_sum[3]) begin
          sum2 = 4'b1000;
        end else begin
          sum2 = help_sum[3:0];
        end
      end else begin
        if (a[3] != help_sum[3]) begin
          sum2 = 4'b0111;
        end else begin
          sum2 = help_sum[3:0];
        end
      end
    end else begin
      sum2 = help_sum[3:0];
    end
  end

  assign sum = sum2;

  // Task:
  //
  // Implement a module that adds two signed numbers with saturation.
  //
  // "Adding with saturation" means:
  //
  // When the result does not fit into 4 bits,
  // and the arguments are positive,
  // the sum should be set to the maximum positive number.
  //
  // When the result does not fit into 4 bits,
  // and the arguments are negative,
  // the sum should be set to the minimum negative number.


endmodule
