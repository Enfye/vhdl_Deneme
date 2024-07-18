

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity tb_son is

end tb_son;

architecture Behavioral of tb_son is
component top_letter_display is
    Port ( clk : in STD_LOGIC;
           rx_in : in STD_LOGIC;
           R,G,B : out STD_LOGIC;
           h_sync_out,v_sync_out : out STD_LOGIC);
end component;
	signal	clk :  STD_LOGIC := '0' ;
	signal	rx_in :  STD_LOGIC;
	signal	R,G,B :  STD_LOGIC;
	signal	h_sync_out,v_sync_out :  STD_LOGIC;
	constant ClockFrequency 	: integer := 100_000_000;
	constant ClockPeriod    	: time := 1000 ms / ClockFrequency;
	constant baud_rate			: integer := 100_000_000/115_200;

begin
clk <= not clk after ClockPeriod / 2; 
uut:	top_letter_display port map(clk,rx_in,R,G,B,h_sync_out,v_sync_out);

	process begin
		wait for 10 * baud_rate * ClockPeriod;
		rx_in <= '0'; wait for baud_rate * ClockPeriod;
		rx_in <= '0'; wait for baud_rate * ClockPeriod; rx_in <= '1'; wait for baud_rate * ClockPeriod;
		rx_in <= '0'; wait for baud_rate * ClockPeriod; rx_in <= '0'; wait for baud_rate * ClockPeriod;
		rx_in <= '0'; wait for baud_rate * ClockPeriod; rx_in <= '0'; wait for baud_rate * ClockPeriod;
		rx_in <= '1'; wait for baud_rate * ClockPeriod; rx_in <= '0'; wait for baud_rate * ClockPeriod;
		rx_in <= '0'; wait for baud_rate * ClockPeriod;                                  
		rx_in <= '1'; wait for baud_rate * ClockPeriod;
		wait for 10 * baud_rate * ClockPeriod;
		wait for 200ms;
		wait for 10 * baud_rate * ClockPeriod;
		rx_in <= '0';  wait for baud_rate * ClockPeriod;
		rx_in <= '0'; wait for baud_rate * ClockPeriod; rx_in <= '1'; wait for baud_rate * ClockPeriod;
		rx_in <= '0'; wait for baud_rate * ClockPeriod; rx_in <= '0'; wait for baud_rate * ClockPeriod;
		rx_in <= '1'; wait for baud_rate * ClockPeriod; rx_in <= '0'; wait for baud_rate * ClockPeriod;
		rx_in <= '1'; wait for baud_rate * ClockPeriod; rx_in <= '0'; wait for baud_rate * ClockPeriod;
		rx_in <= '0'; wait for baud_rate * ClockPeriod;
		rx_in <= '1'; wait for baud_rate * ClockPeriod;
		wait for 10 * baud_rate * ClockPeriod;
		wait for 200ms;
			
	end process;
end Behavioral;
