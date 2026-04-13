module sync_2ff (
    input        clk,
    input        rst,
    input        async_in,
    output logic sync_out
);
    logic ff1, ff2;

    assign sync_out = ff2;

    always_ff @(posedge clk or posedge rst) begin
        if (rst) begin
            ff1 <= 1'b1;
            ff2 <= 1'b1;
        end else begin
            ff1 <= async_in;
            ff2 <= ff1;
        end
    end

endmodule
