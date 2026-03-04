module event_manager (
    input clk,
    input reset,
    input trigger_in,
    output reg trigger_out,
    output reg [31:0] total_events
);
    parameter VETO_PERIOD = 4'd10; // Ignore new hits for 10 clock cycles
    reg [3:0] veto_counter;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            trigger_out <= 0;
            total_events <= 0;
            veto_counter <= 0;
        end else begin
            if (veto_counter > 0) begin
                // System is in "VETO" state - ignore hits
                trigger_out <= 0;
                veto_counter <= veto_counter - 1;
            end else if (trigger_in) begin
                // Accept new trigger
                trigger_out <= 1;
                total_events <= total_events + 1;
                veto_counter <= VETO_PERIOD;
            end else begin
                trigger_out <= 0;
            end
        end
    end
endmodule
