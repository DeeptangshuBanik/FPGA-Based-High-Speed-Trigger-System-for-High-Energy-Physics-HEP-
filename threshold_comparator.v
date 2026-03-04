module threshold_comparator (
    input clk,
    input [7:0] data_in,
    input [7:0] threshold_val,
    output reg hit_out
);
    always @(posedge clk) begin
        // Pipelined comparison for high-speed timing closure
        hit_out <= (data_in >= threshold_val);
    end
endmodule
