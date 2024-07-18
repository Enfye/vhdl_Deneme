

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity tb_letter_gen is
--  Port ( );
end tb_letter_gen;

architecture Behavioral of tb_letter_gen is
	
	component rom_alphabet_chars is
		Port ( ascii_in : in STD_LOGIC_VECTOR(7 downto 0);
			   clk : in STD_LOGIC;
			   letter_bitmap_out : out  STD_LOGIC_VECTOR(63 downto 0));
	end component;
	signal	ascii_in :  STD_LOGIC_VECTOR(7 downto 0);
	signal	clk :  STD_LOGIC := '0';
	signal	letter_bitmap_out :   STD_LOGIC_VECTOR(63 downto 0);
	
	constant ClockFrequency 	: integer := 100_000_000;
	constant ClockPeriod    	: time := 1000 ms / ClockFrequency;
begin
	uut:	rom_alphabet_chars port map(ascii_in, clk, letter_bitmap_out);
	clk <= not clk after ClockPeriod / 2; 
	process	begin
		ascii_in	<= x"47";
		wait for 20*ClockPeriod;
		
		wait for ClockPeriod;
		ascii_in	<= x"42";
		wait for 20*ClockPeriod;
		
		wait for ClockPeriod;
		ascii_in	<= x"51";
		wait for 20*ClockPeriod;
		wait;
	end process;
end Behavioral;
