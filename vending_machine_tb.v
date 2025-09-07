TestBench Code  

`timescale 1ns/1ps 
module vending_machine_tb; 
reg clk; 
reg reset; 
reg start; 
reg cancel; 
reg [2:0] product_code; 
reg online_payment; 
reg [6:0] total_coins; 
wire [3:0] state; 
wire dispense_product; 
wire [6:0] return_change; 
wire [6:0] product_price; 
// DUT Instantiation 
vending_machine dut ( 
.clk(clk), 
.reset(reset), 
.start(start), 
.cancel(cancel), 
.product_code(product_code), 
.online_payment(online_payment), 
.total_coins(total_coins), 
.state(state), 
.dispense_product(dispense_product), 
.return_change(return_change), 
.product_price(product_price) 
); 
// Clock Generation 
initial begin 
clk = 0; 
        forever #5 clk = ~clk; 
    end 
    // Stimulus Process 
    initial begin 
        // Initialization 
        reset = 1; 
        start = 0; 
        cancel = 0; 
        product_code = 3'b000; // Pen 
        online_payment = 0; 
        total_coins = 7'd0; 
        // Hold Reset for 100ns 
        #100; 
        reset = 0; 
        // Wait in idle 
        #100; 
        // Scenario 1: Online payment for Pen 
       start = 1; 
        online_payment = 1; 
        #30; 
        start = 0; 
        online_payment = 0; 
        // Wait between transactions 
        #50; 
       // Scenario 2: Coin payment for Notebook with change 
        start = 1; 
        product_code = 3'b001; // Notebook 
        total_coins = 7'd60;   // 60 Rupees, price is 50, expect 10 Rupees back 
        online_payment = 0; 
        #30; 
        start = 0; 
        total_coins = 7'd0; 
// Wait between transactions 
#50; 
// Scenario 3: Exact coin payment for Water bottle 
start = 1; 
product_code = 3'b100; // Water bottle 
total_coins = 7'd10;   // Exact money 
online_payment = 0; 
#30; 
start = 0; 
total_coins = 7'd0; 
// Wait between transactions 
#50; 
// Scenario 4: Overpayment for Water bottle (should get change) 
start = 1; 
product_code = 3'b100; // Water bottle 
total_coins = 7'd20;   // Overpay 
online_payment = 0; 
#30; 
start = 0; 
total_coins = 7'd0; 
// End simulation 
#100; 
$finish; 
end 
endmodule 
