

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity tb_fifo is

end tb_fifo;

architecture Behavioral of tb_fifo is
	component fifo is
		Port ( clk,rest,w_en,r_en,data_in : in STD_LOGIC;
			   full,empty,data_out : out STD_LOGIC);
	end component;
	signal clk,rest,w_en,r_en,data_in : STD_LOGIC	:= '0';
	signal full,empty,data_out :  STD_LOGIC;
	constant ClockFrequency 	: integer := 100_000_000;
	constant ClockPeriod    	: time := 1000 ms / ClockFrequency;
	
begin
	uut: fifo	port map(clk,rest,w_en,r_en,data_in,full,empty,data_out);
	clk <= not clk after ClockPeriod / 2; 
	process
	begin
		wait for ClockPeriod;
		w_en	<=	'1'; r_en	<=	'0';
		data_in	<=	'1'; wait for ClockPeriod; data_in	<=	'0'; wait for ClockPeriod; data_in	<=	'1'; wait for ClockPeriod;
		
		wait for ClockPeriod;
		w_en	<=	'0'; r_en	<=	'1'; wait for 4*ClockPeriod;
		
		w_en	<=	'1'; r_en	<=	'0';
		data_in	<=	'0'; wait for ClockPeriod; data_in	<=	'0'; wait for ClockPeriod; data_in	<=	'1'; wait for ClockPeriod;
		
		w_en	<=	'0'; r_en	<=	'1'; wait for 8*ClockPeriod;
		wait;
	end process;
end Behavioral;

   