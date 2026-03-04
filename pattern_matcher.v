module pattern_matcher (
    input clk,
    input [3:0] layers_hit, // 4-bit bus (1 bit per layer)
    output reg pattern_valid
);
    // 4'b1111 indicates that all layers fired in a straight line
    parameter TRACK_PATTERN = 4'b1111;

    always @(posedge clk) begin
        pattern_valid <= (layers_hit == TRACK_PATTERN);
    end
endmodule
