//----------------------------------------------------------------------------
// Task
//----------------------------------------------------------------------------

module round_robin_arbiter_with_2_requests
(
    input        clk,
    input        rst,
    input  [1:0] requests,
    output [1:0] grants
);

    enum logic[1:0] {
        first_g  = 2'b01,
        second_g = 2'b10,
        no_grant = 2'b00
    } this_state, next_state;

    always_comb begin
        case (requests)
            2'b00: next_state <= requests;
            2'b01: next_state <= requests;
            2'b10: next_state <= requests;
            2'b11: if (this_state == 2'b10) next_state <= 2'b01;
                   else                     next_state <= 2'b10;
        endcase
    end

    always_ff @ (posedge clk or posedge rst) begin
        if (rst) begin
            this_state <= no_grant;
        end else begin
            this_state <= next_state;
        end
    end

    assign grants = next_state;
    
    // Task:
    // Implement a "arbiter" module that accepts up to two requests
    // and grants one of them to operate in a round-robin manner.
    //
    // The module should maintain an internal register
    // to keep track of which requester is next in line for a grant.
    //
    // Note:
    // Check the waveform diagram in the README for better understanding.
    //
    // Example:
    // requests -> 01 00 10 11 11 00 11 00 11 11
    // grants   -> 01 00 10 01 10 00 01 00 10 01

endmodule
