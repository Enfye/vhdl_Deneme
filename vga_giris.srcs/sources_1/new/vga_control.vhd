
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity vga_control is
    Port ( clk,reset : in STD_LOGIC;
           pixel_x_out, pixel_y_out : out STD_LOGIC_VECTOR (9 downto 0);
           h_sync_out, v_sync_out, video_out : out STD_LOGIC);
end vga_control;

architecture Behavioral of vga_control is

	constant	HF_PORCH	:	integer	:=	8;
	constant	H_SYNC		:	integer	:=	96;
	constant	HB_PORCH	:	integer	:=	40;
	constant	L_BORDER	:	integer	:=	8;
	constant	H_VIDEO		:	integer	:=	640;
	constant	R_BORDER	:	integer	:=	8;
	
	constant	VF_PORCH	:	integer	:=	2;
	constant	V_SYNC		:	integer	:=	2;
	constant	VB_PORCH	:	integer	:=	25;
	constant	T_BORDER	:	integer	:=	4;
	constant	V_VIDEO		:	integer	:=	480;
	constant	B_BORDER	:	integer	:=	8;
	
	constant	H_TOTAL		:	integer	:=	HF_PORCH + H_SYNC + HB_PORCH + L_BORDER + H_VIDEO + R_BORDER - 1;
	constant	V_TOTAL		:	integer	:=	VF_PORCH + V_SYNC + VB_PORCH + T_BORDER + V_VIDEO + B_BORDER - 1;
	
	signal		clk25MHz,pulse_V	:	STD_LOGIC	:=	'0';
	signal		counter_divider	:	integer	range 0 to 1:=	0;
	
	signal		counter_H	:	integer	range 0 to H_TOTAL	:=	0;
	signal		counter_V	:	integer	range 0 to H_TOTAL	:=	0;
	
	type		states		is	(PULSE,BACK,DISPLAY,FRONT);
	signal		H_state,V_state	:	states	:=	PULSE;
	
	
	signal		pixel_x, pixel_y : STD_LOGIC_VECTOR (9 downto 0) := (others =>	'0');
	
begin


	clock_25MHz:	
	process(clk)	begin
		if(rising_edge(clk)) then
			if(counter_divider = 1) then
				clk25MHz	<=	not	clk25MHz;
				counter_divider	<=	0;
			else
				counter_divider	<=	counter_divider	+ 1;
			end if;
		end if;
	end process;
	
	H_SYNC_GEN:
	process(clk25MHz) begin
		if(rising_edge(clk25MHz)) then
			case	H_state	is
				
				when	PULSE	=>
					pulse_V	<=	'0';
					video_out	<=	'0';
					if(counter_H	<	H_SYNC ) then
						counter_H	<=	counter_H + 1;
						h_sync_out	<=	'0';
					else
						h_sync_out	<=	'1';
						counter_H	<=	0;
						H_state		<=	BACK;
					end if;
				when	BACK	=>
					
					if(counter_H	<	HB_PORCH + L_BORDER ) then
						counter_H	<=	counter_H + 1;
					else
						counter_H	<=	0;
						H_state		<=	DISPLAY;
					end if;
				when	DISPLAY	=>
					
					if(counter_H	<	H_VIDEO ) then
						if(V_state = DISPLAY) then
							video_out	<=	'1';
						end if;
						counter_H	<=	counter_H + 1;
					else
						video_out	<=	'0';
						counter_H	<=	0;
						H_state		<=	FRONT;
					end if;
					if pixel_x = "1010000000" then -- 640 in binary
						pixel_x <= (others => '0');
					else
						pixel_x <= std_logic_vector(unsigned(pixel_x) + 1);
					end if;
				when	FRONT	=>
					
					if(counter_H	<	HF_PORCH + R_BORDER) then
						counter_H	<=	counter_H + 1;
					else
						counter_H	<=	0;
						H_state		<=	PULSE;
						pulse_V	<=	'1';
					end if;
				when	others	=>
					H_state		<=	PULSE;
			end case;
		end if;
	end process;
	
	V_SYNC_GEN:
	process(pulse_V) begin
		if(rising_edge(pulse_V)) then
			case	V_state	is
				when	PULSE	=>
					if(counter_V	<	V_SYNC ) then
						counter_V	<=	counter_V + 1;
						v_sync_out	<=	'0';
					else
						v_sync_out	<=	'1';
						counter_V	<=	0;
						V_state		<=	BACK;
					end if;
				when	BACK	=>
					if(counter_V	<	VB_PORCH + T_BORDER) then
						counter_V	<=	counter_V + 1;
					else
						counter_V	<=	0;
						V_state		<=	DISPLAY;
					end if;
				when	DISPLAY	=>
					if(counter_V	<	V_VIDEO ) then
						counter_V	<=	counter_V + 1;
					else
						counter_V	<=	0;
						V_state		<=	FRONT;
					end if;
					if pixel_y = "0111100000" then -- 480 in binary
						pixel_y <= (others => '0');
					else
						pixel_y <= std_logic_vector(unsigned(pixel_y) + 1);
					end if;
				when	FRONT	=>
					
					if(counter_V	<	VF_PORCH + B_BORDER) then
						counter_V	<=	counter_V + 1;
					else
						counter_V	<=	0;
						V_state		<=	PULSE;	
					end if;
				when	others	=>
					V_state		<=	PULSE;
			end case;
		end if;
	end process;
	pixel_x_out	<=	pixel_x;
	pixel_y_out	<=	pixel_y;


end Behavioral;
