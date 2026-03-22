
module room_fsm( 
	input logic clk,
	input logic rst,
	input logic north,
	input logic south,
	input logic east,
	input logic west,
	
	output logic has_sword,
	output logic Haydar_with_us,
	output logic in_DD
	
);

	typedef enum logic[2:0]{
		CC = 3'b000 , // Cave of Cacophany
		TT = 3'b001 , // Twisty Tunnel
		HD = 3'b010 , // Haydar's Dorm
		RR = 3'b011  ,// Rapid River
		SSS = 3'b100 ,// Secret Sword Stash
		DD = 3'b101  , // Dragon's Den
		VV = 3'b110 , // Victory Vault
		GG = 3'b111  // Grevious Graveyard
	} room_state; 
	
	room_state state, next_state ; 
	
	always_ff @(posedge clk or posedge rst) begin
		if (rst) 
			state <= CC;
		else 
			state <= next_state; 
	end 
	// Sword register
	always_ff @(posedge clk or posedge rst) begin
		 if (rst)
			  has_sword <= 0;
		 else if (state == SSS)
			  has_sword <= 1;
	end

	// Haydar register
	always_ff @(posedge clk or posedge rst) begin
		 if (rst)
			  Haydar_with_us <= 0;
		 else if (state == HD)
			  Haydar_with_us <= 1;
	end
	
	always_comb begin
		next_state = state; 
		
		case (state)
        CC: begin
            if (east)
                next_state = TT;
			end
		 
		  TT: begin
				if (north)
					next_state = HD; 
				else if (south)
					next_state = RR;
			end
			
			HD: begin
				if (south)
					next_state = TT;
			end
			
			RR: begin
				if (west)
					next_state = SSS;
				else if(east)
					next_state = DD; 
			end
			
			SSS: begin
				if (east)
					next_state = RR;
			end	
			endcase	
	end

	assign in_DD = (state == DD);
	
	endmodule 
	
			
				
	




