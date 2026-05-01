module flipFlop #(
    parameter WIDTH = 4
) (
    input clk, rst,
    input logic [WIDTH-1:0] data_i,
    output logic [WIDTH-1:0] data_o
);

    //Define D and Q for all 3 stages
    logic [WIDTH-1:0] data1_d, data1_q;
    logic [WIDTH-1:0] data2_d, data2_q;
    logic [WIDTH-1:0] data3_d, data3_q;

  //The final output is dependent by the 3rd FF Q output
    assign data_o = data3_q;

    //Logic for the D-inputs for each stage
    always_comb begin : data_set
        data1_d = data_i;     // Stage 1 takes the module input
        data2_d = data1_q;    // Stage 2 takes Stage 1's output
        data3_d = data2_q;    // Stage 3 takes Stage 2's output
    end

    // async reset

    always_ff @(posedge clk or posedge rst) begin : data_ff
        if (rst) begin
            data1_q <= '0;
            data2_q <= '0;
            data3_q <= '0;
        end else begin
            data1_q <= data1_d;
            data2_q <= data2_d;
            data3_q <= data3_d;
        end
    end

endmodule
