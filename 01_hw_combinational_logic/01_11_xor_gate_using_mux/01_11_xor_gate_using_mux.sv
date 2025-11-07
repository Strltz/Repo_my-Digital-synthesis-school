//----------------------------------------------------------------------------
// Example
//----------------------------------------------------------------------------

module mux
(
  input  d0, d1,
  input  sel,
  output y
);

  assign y = sel ? d1 : d0;

endmodule

module xor_gate_using_mux
(
    input  a,
    input  b,
    output o
);

  logic not_a;
  mux mux_not_a (
    .d0(1),
    .d1(0),
    .sel(a),
    .y(not_a)
  );

  logic not_b;
  mux mux_not_b (
    .d0(1),
    .d1(0),
    .sel(b),
    .y(not_b)
  );

  logic a__AND__not_b;
  mux mux_a__AND__not_b (
    .d0(0),
    .d1(not_b),
    .sel(a),
    .y(a__AND__not_b)
  );

  logic not_a__AND__b;
  mux mux_not_a__AND__b (
    .d0(0),
    .d1(not_a),
    .sel(b),
    .y(not_a__AND__b)
  );

  mux final_mux (
    .d0(not_a__AND__b),
    .d1(1),
    .sel(a__AND__not_b),
    .y(o)
  );

  // Task:
  // Implement xor gate using instance(s) of mux,
  // constants 0 and 1, and wire connections

endmodule
