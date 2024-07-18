-----------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity tb_top is

end tb_top;

architecture Behavioral of tb_top is
	component top_vga is
		Port ( clk : in STD_LOGIC;
			   R,G,B : out STD_LOGIC;
			   h_sync,v_sync : out STD_LOGIC);
	end component;
	signal clk :  STD_LOGIC := '0';
    signal R,G,B :  STD_LOGIC;
    signal h_sync,v_sync :  STD_LOGIC;


	constant ClockFrequency 	: integer := 100_000_000;
	constant ClockPeriod    	: time := 1000 ms / ClockFrequency;
	
begin
	uut: top_vga	port map(clk,R,G,B,h_sync,v_sync);
	clk <= not clk after ClockPeriod / 2; 

end Behavioral;
