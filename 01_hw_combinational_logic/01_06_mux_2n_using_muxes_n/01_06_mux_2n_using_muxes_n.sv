//----------------------------------------------------------------------------
// Example
//----------------------------------------------------------------------------

module mux_2_1
(
  input  [3:0] d0, d1,
  input        sel,
  output [3:0] y
);

  assign y = sel ? d1 : d0;

endmodule

//----------------------------------------------------------------------------
// Task
//----------------------------------------------------------------------------

module mux_4_1
(
  input  [3:0] d0, d1, d2, d3,
  input  [1:0] sel,
  output [3:0] y
);

  logic [3:0] y_first;

  mux_2_1 mux_first (
    .d0(d0),
    .d1(d1),
    .sel(sel[0]),
    .y(y_first)
  );

  logic[3:0] y_second;

  mux_2_1 mux_second (
    .d0(d2),
    .d1(d3),
    .sel(sel[0]),
    .y(y_second)
  );

  mux_2_1 mux_last (
    .d0(y_first),
    .d1(y_second),
    .sel(sel[1]),
    .y(y)
  );

  // Task:
  // Implement mux_4_1 using three instances of mux_2_1

endmodule
