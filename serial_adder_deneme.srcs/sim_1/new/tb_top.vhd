

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity tb_top is

end tb_top;

architecture Behavioral of tb_top is
	component top is
		Port ( clk : in STD_LOGIC;
			   A_in,B_in : in STD_LOGIC_VECTOR (7 downto 0);
			   Start : in STD_LOGIC;
			   S_out : out STD_LOGIC_VECTOR (7 downto 0));
	end component;
	
	
	constant ClockFrequency 	: integer := 100_000_000;
    constant ClockPeriod    	: time := 1000 ms / ClockFrequency;
	signal clk : STD_LOGIC := '0';
	signal A_in,B_in : STD_LOGIC_VECTOR (7 downto 0);
	signal Start : STD_LOGIC;
	signal S_out : STD_LOGIC_VECTOR (7 downto 0);
	
begin
	clk <= not clk after ClockPeriod / 2;

	uut: top port map(clk,A_in,B_in,Start,S_out);
	
	process
	begin
	
		Start	<= '1';	wait for 50ns;	A_in	<= "01010001";	wait for 50ns;	B_in	<= "10101011"; wait for 50ns; Start	<= '0'; wait for 40*ClockPeriod;
		
		Start	<= '1';	wait for 50ns;	A_in	<= "10111011";	wait for 50ns;	B_in	<= "00110001"; wait for 50ns; Start	<= '0'; wait for 40*ClockPeriod;
		
		Start	<= '1';	wait for 50ns;	A_in	<= "00111011";	wait for 50ns;	B_in	<= "10100011"; wait for 50ns; Start	<= '0'; wait for 40*ClockPeriod;
		
		Start	<= '1';	wait for 50ns;	A_in	<= "11010110";	wait for 50ns;	B_in	<= "00000111"; wait for 50ns; Start	<= '0'; wait for 40*ClockPeriod;
		
		Start	<= '1';	wait for 50ns;	A_in	<= "11001101";	wait for 50ns;	B_in	<= "11010001"; wait for 50ns; Start	<= '0'; wait for 40*ClockPeriod;
		
		wait;
		
	
	end process;
	
	
end Behavioral;
