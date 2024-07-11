--------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;



entity tb_new_fifo is
--  Port ( );
end tb_new_fifo;

architecture Behavioral of tb_new_fifo is
	component fifo_32_8_bit is
		Port (
			clk, w_en, r_en : in STD_LOGIC;
			data_in : in STD_LOGIC_VECTOR(7 downto 0);
			full, empty : out STD_LOGIC;
			data_out : out STD_LOGIC_VECTOR(7 downto 0)
		);
	end component;
	signal clk : STD_LOGIC := '0';
	signal w_en, r_en :  STD_LOGIC := '0';
	signal data_in :  STD_LOGIC_VECTOR(7 downto 0);
	signal full, empty :  STD_LOGIC := '0';
	signal data_out :  STD_LOGIC_VECTOR(7 downto 0);
	constant ClockFrequency 	: integer := 100_000_000;
	constant ClockPeriod    	: time := 1000 ms / ClockFrequency;
begin
	uut: fifo_32_8_bit port map (clk,w_en,r_en,data_in,full,empty,data_out);
	clk <= not clk after ClockPeriod / 2; 
	process
	begin
		wait for ClockPeriod;
		w_en	<=	'1'; r_en	<=	'0';
		data_in	<=	"01001001"; wait for ClockPeriod; data_in	<=	"11001001"; wait for ClockPeriod; data_in	<=	"10011011"; wait for ClockPeriod;
		
		wait for ClockPeriod;
		w_en	<=	'0'; r_en	<=	'1'; wait for 4*ClockPeriod;
		
		w_en	<=	'1'; r_en	<=	'0';
		data_in	<=	"11011000"; wait for ClockPeriod; data_in	<=	"11001101"; wait for ClockPeriod; data_in	<=	"11111101"; wait for ClockPeriod;
		
		
		w_en	<=	'1'; r_en	<=	'0';
		data_in	<=	"11011010"; wait for ClockPeriod; data_in	<=	"11000001"; wait for ClockPeriod; data_in	<=	"10111101"; wait for ClockPeriod; 
		data_in	<=	"11100101"; wait for ClockPeriod; data_in	<=	"11101101"; wait for ClockPeriod; data_in	<=	"11001101"; wait for ClockPeriod; 
		data_in	<=	"11011101"; wait for ClockPeriod; data_in	<=	"10011101"; wait for ClockPeriod; data_in	<=	"11011101"; wait for ClockPeriod; 
		w_en	<=	'0'; r_en	<=	'1'; wait for 8*ClockPeriod;
		
		w_en	<=	'1'; r_en	<=	'1';
		data_in	<=	"11011010"; wait for ClockPeriod; data_in	<=	"11000001"; wait for ClockPeriod; data_in	<=	"10111101"; wait for ClockPeriod; 
		data_in	<=	"11100101"; wait for ClockPeriod; data_in	<=	"11101101"; wait for ClockPeriod; data_in	<=	"11001101"; wait for ClockPeriod; 
		data_in	<=	"11011101"; wait for ClockPeriod; data_in	<=	"10011101"; wait for ClockPeriod; data_in	<=	"11011101"; wait for ClockPeriod; 
		w_en	<=	'0'; r_en	<=	'1'; wait for 8*ClockPeriod;
		wait;
	end process;

end Behavioral;
