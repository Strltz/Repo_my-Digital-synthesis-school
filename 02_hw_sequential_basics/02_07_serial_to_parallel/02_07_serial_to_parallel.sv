//----------------------------------------------------------------------------
// Task
//----------------------------------------------------------------------------

module serial_to_parallel
# (
    parameter width = 8
)
(
    input                      clk,
    input                      rst,

    input                      serial_valid,
    input                      serial_data,

    output logic               parallel_valid,
    output logic [width - 1:0] parallel_data
);
    // Task:
    // Implement a module that converts single-bit serial data to the multi-bit parallel value.
    //
    // The module should accept one-bit values with valid interface in a serial manner.
    // After accumulating 'width' bits and receiving last 'serial_valid' input,
    // the module should assert the 'parallel_valid' at the same clock cycle
    // and output 'parallel_data' value.
    //
    // Note:
    // Check the waveform diagram in the README for better understanding.

    logic [width - 1:0] reg_out;
    logic [3:0] count_bits;

    always_ff @ (posedge clk) begin
        if (rst) begin
            reg_out <= '0;
            count_bits <= '0;
            parallel_valid <= '0;
        end
        else begin
            parallel_valid <= 1'b0;
            if (serial_valid) begin
                reg_out = {serial_data, reg_out[width - 1:1]};
                count_bits = count_bits + 1'b1;
                if (count_bits == 4'd8) begin
                    parallel_data = reg_out;
                    count_bits <= '0;
                    parallel_valid <= 1'b1;
                    reg_out <= '0;
                end
            end
        end
    end

endmodule
