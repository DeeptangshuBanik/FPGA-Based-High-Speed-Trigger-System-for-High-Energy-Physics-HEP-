module trigger_system_top (
    input clk,
    input reset,
    input [7:0] sensor_data,
    input [3:0] layer_bits,
    output final_trigger,
    output [31:0] event_count
);
    wire w_hit, w_pattern, w_combined;

    threshold_comparator comp_inst (.clk(clk), .data_in(sensor_data), .threshold_val(8'd180), .hit_out(w_hit));
    pattern_matcher pat_inst (.clk(clk), .layers_hit(layer_bits), .pattern_valid(w_pattern));

    // Combined Trigger Condition
    assign w_combined = w_hit && w_pattern;

    event_manager manager_inst (
        .clk(clk), .reset(reset), 
        .trigger_in(w_combined), 
        .trigger_out(final_trigger), 
        .total_events(event_count)
    );
endmodule
