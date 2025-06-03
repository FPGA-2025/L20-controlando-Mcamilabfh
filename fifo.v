module fifo(
    input   clk,
    input   rst_n, //Ativo em zero

    input   wr_en, //habilita a escrita
    input   [7:0] data_in, // dado a ser escrito na FIFO
    output  full, // diz se a FIFO está cheia

    input   rd_en, //habilita a leitur
    output  reg [7:0] data_out, //dado lido da FIFO
    output  empty, //indica se a FIFO está vazia

    
    output reg [3:0] fifo_words  //mostra quantos elementos tem dentro da FIFO (de 0 a 8).
);

reg [2:0] write_ptr; // onde o próximo dado será escrito (0 a 7)
reg [2:0] read_ptr; // onde o próximo dado será lido (0 a 7)
reg [7:0] mem [0:7]; //memória da FIFO

always @(posedge clk) begin
    if (!rst_n) begin
        write_ptr = 0;
        read_ptr = 0;
        fifo_words = 0;

    end else if (wr_en && !full) begin
        mem[write_ptr] <= data_in; //Escreve data_in na posição apontada por write_ptr
        write_ptr = write_ptr + 1; //Avança o ponteiro
        fifo_words = fifo_words + 1; //Incrementa o contador

    end 
    if (rd_en && !empty) begin
        data_out <= mem[read_ptr]; //Lê da posição read_ptr e joga pra data_out
        read_ptr = read_ptr +1; //Avança read_ptr
        fifo_words = fifo_words -1; //Decrementa fifo_words
    end
end

assign full = (fifo_words == 8); //full será 1 quando fifo_words for 8
assign empty = (fifo_words == 0); //empty será 1 quando fifo_words for 0

endmodule