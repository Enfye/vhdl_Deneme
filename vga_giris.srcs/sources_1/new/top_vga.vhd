-----------
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity top_vga is
    Port ( clk : in STD_LOGIC;
           R,G,B : out STD_LOGIC;
           h_sync,v_sync : out STD_LOGIC);
end top_vga;

architecture Behavioral of top_vga is

	component vga_control is
		Port ( clk,reset : in STD_LOGIC;
			   pixel_x_out, pixel_y_out : out STD_LOGIC_VECTOR (9 downto 0);
			   h_sync_out, v_sync_out, video_out : out STD_LOGIC);
	end component;
	
	component vga_color is
		Port ( clk : in STD_LOGIC;
			   pixel_x,pixel_y : in STD_LOGIC_VECTOR (9 downto 0);
			   R,G,B : out STD_LOGIC);
	end component;
	signal reset: STD_LOGIC:= '0';
	signal pixel_x, pixel_y: STD_LOGIC_VECTOR (9 downto 0);
	signal counter: integer:= 0;
begin
	control:	vga_control port map(clk,reset,pixel_x,pixel_y,h_sync,v_sync);
	color:		vga_color	port map(clk,pixel_x,pixel_y,R,G,B);
	

end Behavioral;
