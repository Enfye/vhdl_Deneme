----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity tb_vga_sync is

end tb_vga_sync;

architecture Behavioral of tb_vga_sync is
	component vga_control is
		Port ( clk,reset : in STD_LOGIC;
			   pixel_x_out, pixel_y_out : out STD_LOGIC_VECTOR (9 downto 0);
			   h_sync_out, v_sync_out, video_out : out STD_LOGIC);
	end component;
	
	signal clk,reset : STD_LOGIC := '0';
	signal pixel_x_out, pixel_y_out :  STD_LOGIC_VECTOR (9 downto 0);
	signal h_sync_out, v_sync_out, video_out :  STD_LOGIC;
	
	constant ClockFrequency 	: integer := 100_000_000;
	constant ClockPeriod    	: time := 1000 ms / ClockFrequency;
	
begin
	uut: vga_control	port map(clk,reset,pixel_x_out,pixel_y_out,h_sync_out,v_sync_out,video_out);
	clk <= not clk after ClockPeriod / 2; 

end Behavioral;
