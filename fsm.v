module fsm(
    input   clk,
    input   rst_n,
    input [3:0] fifo_words,

    output reg wr_en,
    output reg [7:0] fifo_data
    

);

localparam  [1:0] 
    WRITE = 2'b00,
    WAIT = 2'b01;

    reg [1:0] estado;

always @(posedge clk) begin
    if(!rst_n) begin 
        estado <=WRITE;
        fifo_data <= 8'hAA;
        wr_en <= 1;
    end else if((estado == WRITE) && (fifo_words == 5)) begin
        estado <= WAIT;
        wr_en = 1;
        fifo_data <= 8'hAA;
    end else if((estado == WAIT) && (fifo_words <=2)) begin
        estado <= WRITE;
        wr_en = 1;
        fifo_data <= 8'hAA;
    end else if(estado == WRITE) begin
        wr_en = 1;
        fifo_data <= 8'hAA;
    end else begin
        wr_en <= 0;
        fifo_data <= 8'h00;
    end
end


endmodule