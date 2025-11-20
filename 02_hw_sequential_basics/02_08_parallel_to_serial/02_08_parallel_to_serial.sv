//----------------------------------------------------------------------------
// Task
//----------------------------------------------------------------------------

module parallel_to_serial
# (
    parameter width = 8
)
(
    input                      clk,
    input                      rst,

    input                      parallel_valid,
    input        [width - 1:0] parallel_data,

    output                     busy,
    output logic               serial_valid,
    output logic               serial_data
);
    // Task:
    // Implement a module that converts multi-bit parallel value to the single-bit serial data.
    //
    // The module should accept 'width' bit input parallel data when 'parallel_valid' input is asserted.
    // At the same clock cycle as 'parallel_valid' is asserted, the module should output
    // the least significant bit of the input data. In the following clock cycles the module
    // should output all the remaining bits of the parallel_data.
    // Together with providing correct 'serial_data' value, module should also assert the 'serial_valid' output.
    //
    // Note:
    // Check the waveform diagram in the README for better understanding.

    logic busy_1;
    logic [$clog2(width) - 1:0] number_bit;

    always_ff @ (posedge clk) begin
        if (rst) begin
            busy_1     <= '0;
            number_bit <= '0;
        end else begin
            if (serial_valid) begin
                busy_1 <= 1'b1;
                number_bit <= number_bit + 1'b1;
            end
            if (number_bit == (width - 1)) begin
                busy_1  <= '0;
            end
        end
    end

    always_comb begin
        serial_valid = parallel_valid | busy_1;
        if (serial_valid) begin
            serial_data <= parallel_data[number_bit];
        end
    end

    assign busy = busy_1;

endmodule
