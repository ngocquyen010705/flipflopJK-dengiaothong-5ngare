module traffic_light_fsm(
    input clk,          
    input rst_n,     
   
    // Nhom1
    output reg G1,      //Xanh
    output reg Y1,      //Vang
    output reg R1,      // Do
    
    //Nhom2
    output reg G2,      //Xanh
    output reg Y2,      //Vang
    output reg R2,      //Do
    
    output [2:0] state_out 
    );

        parameter [2:0] S0 = 3'b000,
                    S1 = 3'b001,
                    S2 = 3'b010,
                    S3 = 3'b011,
                    S4 = 3'b100,
                    S5 = 3'b101,
                    S6 = 3'b110,
                    S7 = 3'b111;

    
    reg [2:0] state;      
    reg [2:0] next_state; 

    //Mach dem 8
    always @(*) begin
        case (state)
            S0: next_state = S1;
            S1: next_state = S2;
            S2: next_state = S3;
            S3: next_state = S4;
            S4: next_state = S5;
            S5: next_state = S6;
            S6: next_state = S7;
            S7: next_state = S0;
            default: next_state = S0;
        endcase
    end

    //Tuan tu
    always @(posedge clk or negedge rst_n) begin
        if(!rst_n)
            state <= S0;
        else
            state <= next_state;
    end

   
    always @(*) begin
        {G1, Y1, R1} = 3'b000;
        {G2, Y2, R2} = 3'b000;

        case (state)
            // Giai doan 1
            S0, S1, S2: begin 
                //Nhom1 xanh
                G1 = 1; Y1 = 0; R1 = 0;
                // Nhom2 do 
                G2 = 0; Y2 = 0; R2 = 1;
            end

            // Giai doan 2
            S3: begin
                //Nhom1 vang 
                G1 = 0; Y1 = 1; R1 = 0;
                //Nhom2 do 
                G2 = 0; Y2 = 0; R2 = 1;
            end

            
            S4, S5, S6: begin
                //Nhom1 do
                G1 = 0; Y1 = 0; R1 = 1;
                //Nhom2 xanh 
                G2 = 1; Y2 = 0; R2 = 0;
            end

           
            S7: begin
                //Nhom1 do 
                G1 = 0; Y1 = 0; R1 = 1;
                //Nhom2 vang 
                G2 = 0; Y2 = 1; R2 = 0;
            end
            
            default: begin
                {G1, Y1, R1} = 3'b000;
                {G2, Y2, R2} = 3'b000;
            end
        endcase
    end

    assign state_out = state;

endmodule