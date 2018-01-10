`timescale 1ns / 1ps

module cpu_riscv_min_sopc_tb ();

    reg CLOCK_50;
    reg rst;

    // 100MHz
    initial begin
        CLOCK_50 = 1'b0;
        forever #5 CLOCK_50 = ~CLOCK_50;
    end

    initial begin
        rst = `RstEnable;
        #195 rst = `RstDisable;
        #100000 $stop;
    end

    cpu_riscv_min_sopc cpu_riscv_min_sopc0(
            .clk(CLOCK_50),
            .rst(rst)
        );

endmodule // cpu_riscv_min_sopc_tb
