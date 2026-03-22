
module inventory_fsm(
	input logic clk,
	input logic rst,
	input logic has_sword,
	input logic Haydar_with_us,
	input logic in_DD,
	
	output logic win_goto_VV,
	output logic die_goto_GG,
	output logic win_with_treasure,
	output logic Haydar_win_you_lose
);

	typedef enum logic{
		wait_t = 1'b0 ,
		in_Dragon = 1'b1
	} inventory_state_t;

	inventory_state_t state , next_state ; 

	always_ff @(posedge clk or posedge rst) begin
			if (rst) 
				state <= wait_t;
			else 
				state <= next_state; 
		end 
		
	always_comb begin
			next_state = state; 
			win_goto_VV = 0;
			die_goto_GG = 0;
			win_with_treasure = 0;
			Haydar_win_you_lose = 0;
			case (state)
				wait_t:  begin
					if (in_DD == 1)
						next_state = in_Dragon ;
				end
				in_Dragon: begin
					if ((has_sword == 0)&&(Haydar_with_us == 0))
						die_goto_GG  = 1 ; 
					else if ((has_sword == 0)&&(Haydar_with_us == 1))
						Haydar_win_you_lose = 1; 
					else if ((has_sword == 1)&&(Haydar_with_us == 0))
						win_goto_VV = 1 ; 
					else if ((has_sword == 1)&&(Haydar_with_us == 1))
						win_with_treasure = 1 ; 
				end
			endcase
			end
	endmodule
				
	