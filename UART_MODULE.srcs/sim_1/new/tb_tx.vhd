library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity tb_tx is
--  Port ( );
end tb_tx;

architecture Behavioral of tb_tx is
	component tx is
		Port ( data_in : in STD_LOGIC_VECTOR (7 downto 0);
			   clk : in STD_LOGIC;
			   data_transmit_flag : in STD_LOGIC;
			   data_out : out STD_LOGIC);
	end component;
	signal data_in :  STD_LOGIC_VECTOR (7 downto 0);
	signal clk :  STD_LOGIC:= '0';
	signal data_transmit_flag : STD_LOGIC;
	signal data_out :  STD_LOGIC;
	constant ClockFrequency 	: integer := 100_000_000;
	constant ClockPeriod    	: time := 1000 ms / ClockFrequency;
	constant baud_rate			: integer := 100_000_000/115_200;
	
begin
	clk <= not clk after ClockPeriod / 2; 
	uut: tx port map(data_in,clk,data_transmit_flag,data_out);
	process
	begin
		data_transmit_flag	<=  '1';
		wait for baud_rate * ClockPeriod;
		data_in	<= x"66";
		wait for baud_rate * ClockPeriod;
		data_transmit_flag	<=	'0';
		wait for baud_rate * 15 * ClockPeriod;
		data_transmit_flag	<=  '1';
		wait for baud_rate * ClockPeriod;
		data_in	<= x"FA";
		wait for baud_rate * ClockPeriod;
		data_transmit_flag	<=	'0';
		wait for baud_rate * 15 * ClockPeriod;
		data_transmit_flag	<=  '1';
		wait for baud_rate * ClockPeriod;
		data_in	<= x"BB";
		wait for baud_rate * ClockPeriod;
		data_transmit_flag	<=	'0';
		wait for baud_rate * 15 * ClockPeriod;
		data_transmit_flag	<=  '1';
		wait for baud_rate * ClockPeriod;
		data_in	<= x"AE";
		wait for baud_rate * ClockPeriod;
		data_transmit_flag	<=	'0';
		wait for baud_rate * 15 * ClockPeriod;
		data_transmit_flag	<=  '1';
		wait for baud_rate * ClockPeriod;
		data_in	<= x"6A";
		wait for baud_rate * ClockPeriod;
		data_transmit_flag	<=	'0';
		wait for baud_rate * 15 * ClockPeriod;
		wait;
	end process;
end Behavioral;
