Source Code
 
module vending_machine( 
input wire clk, 
input wire reset, // Active high 
input wire start, 
input wire cancel, 
input wire [2:0] product_code, // 3 bits to select product 
input wire online_payment, 
input wire [6:0] total_coins, // 7 bits to represent deposited coins 
output reg [3:0] state, 
output reg dispense_product, 
output reg [6:0] return_change, 
output reg [6:0] product_price 
); 
// Product prices - 7 bits 
parameter [6:0] PRICE_PEN     = 7'd20; 
parameter [6:0] PRICE_NOTEBOOK= 7'd50; 
parameter [6:0] PRICE_COKE    = 7'd35; 
parameter [6:0] PRICE_LAYS    = 7'd20; 
parameter [6:0] PRICE_WATER   = 7'd10; 
// State definitions - 4 bits 
localparam [3:0] 
S_IDLE            = 4'b0000, 
S_SELECT_PRODUCT  = 4'b0001, 
S_PEN_SELECTED    = 4'b0010, 
S_NOTEBOOK_SEL    = 4'b0011, 
S_COKE_SEL
 S_LAYS_SEL
        =
        =
 4'b0100, 
 4'b0101, 
S_WATER_SEL       = 4'b0110, 
S_DISPENSE        = 4'b0111; 
reg [3:0] next_state; 
reg [6:0] next_return_change, next_product_price; 
reg next_dispense_product; 
// State update (sequential) 
always @(posedge clk or posedge reset) begin 
if (reset) begin 
state
           <= S_IDLE; 
return_change   <= 7'd0; 
product_price   <= 7'd0; 
dispense_product<= 1'b0; 
end else begin 
state
           <= next_state; 
return_change   <= next_return_change; 
product_price   <= next_product_price; 
dispense_product<= next_dispense_product; 
end 
end 
// FSM & output logic (combinational) 
always @(*) begin 
// Defaults 
next_state = state; 
next_return_change = return_change; 
next_product_price = product_price; 
next_dispense_product = 1'b0; 
case (state) 
S_IDLE: begin 
if (start) 
next_state = S_SELECT_PRODUCT; 
else if (cancel) 
next_state = S_IDLE; 
end 
        S_SELECT_PRODUCT: begin 
            case (product_code) 
                3'b000: begin 
                    next_state = S_PEN_SELECTED; 
                    next_product_price = PRICE_PEN; 
                end 
                3'b001: begin 
                    next_state = S_NOTEBOOK_SEL; 
                    next_product_price = PRICE_NOTEBOOK; 
                end 
                3'b010: begin 
                    next_state = S_COKE_SEL; 
                    next_product_price = PRICE_COKE; 
                end 
                3'b011: begin 
                    next_state = S_LAYS_SEL; 
                    next_product_price = PRICE_LAYS; 
                end 
                3'b100: begin 
                    next_state = S_WATER_SEL; 
                    next_product_price = PRICE_WATER; 
                end 
                default: next_state = S_IDLE; // invalid product 
            endcase 
        end 
        S_PEN_SELECTED, 
        S_NOTEBOOK_SEL, 
        S_COKE_SEL, 
        S_LAYS_SEL, 
        S_WATER_SEL: begin 
            // If cancel, go to idle, return coins 
            if (cancel) begin 
next_state = S_IDLE; 
next_return_change = total_coins; 
end 
// If enough coins or online payment 
else if ((total_coins >= product_price) || online_payment) begin 
next_state = S_DISPENSE; 
next_dispense_product = 1'b1; 
next_return_change = total_coins >= product_price ? (total_coins - product_price) : 
7'd0; 
end 
// Not enough; stay 
else begin 
next_state = state; 
next_return_change = 7'd0; 
next_dispense_product = 1'b0; 
end 
end 
S_DISPENSE: begin 
next_state = S_IDLE; 
// Outputs carried from previous state 
end 
default: next_state = S_IDLE; 
endcase 
end 
endmodule