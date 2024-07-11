library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity tb_top is
--  Port ( );
end tb_top;

architecture Behavioral of tb_top is

	component top is
		Port ( button_in : in STD_LOGIC;
		       clk : in STD_LOGIC;
			   rx_in : in STD_LOGIC;
			   tx_out : out STD_LOGIC;
			   led : out STD_LOGIC_VECTOR (7 downto 0));
	end component;
	signal button_in : STD_LOGIC;
	signal rx_in : STD_LOGIC;
	signal tx_out :  STD_LOGIC;
	signal led :  STD_LOGIC_VECTOR (7 downto 0);
	signal clk : STD_LOGIC := '0';
	constant ClockFrequency 	: integer := 100_000_000;
	constant ClockPeriod    	: time := 1000 ms / ClockFrequency;
	constant baud_rate			: integer := 100_000_000/115_200;
begin
	uut: top port map(button_in,clk,rx_in,tx_out,led);
	clk <= not clk after ClockPeriod / 2; 
	
	process
	begin
		rx_in <= '1';
		wait for 10 * baud_rate * ClockPeriod;
		rx_in <= '0'; wait for baud_rate * ClockPeriod;
		rx_in <= '1'; wait for baud_rate * ClockPeriod; rx_in <= '1'; wait for baud_rate * ClockPeriod;
		rx_in <= '1'; wait for baud_rate * ClockPeriod; rx_in <= '0'; wait for baud_rate * ClockPeriod;
		rx_in <= '0'; wait for baud_rate * ClockPeriod; rx_in <= '1'; wait for baud_rate * ClockPeriod;
		rx_in <= '1'; wait for baud_rate * ClockPeriod; rx_in <= '0'; wait for baud_rate * ClockPeriod;
		rx_in <= '1'; wait for baud_rate * ClockPeriod;                                  
		rx_in <= '1'; wait for baud_rate * ClockPeriod;
		wait for 10 * baud_rate * ClockPeriod;
		wait for 10 * baud_rate * ClockPeriod;
		rx_in <= '0';  wait for baud_rate * ClockPeriod;
		rx_in <= '0'; wait for baud_rate * ClockPeriod; rx_in <= '1'; wait for baud_rate * ClockPeriod;
		rx_in <= '1'; wait for baud_rate * ClockPeriod; rx_in <= '1'; wait for baud_rate * ClockPeriod;
		rx_in <= '0'; wait for baud_rate * ClockPeriod; rx_in <= '1'; wait for baud_rate * ClockPeriod;
		rx_in <= '0'; wait for baud_rate * ClockPeriod; rx_in <= '0'; wait for baud_rate * ClockPeriod;
		rx_in <= '0'; wait for baud_rate * ClockPeriod;
		rx_in <= '1'; wait for baud_rate * ClockPeriod;
		wait for 10 * baud_rate * ClockPeriod;
		wait for 10 * baud_rate * ClockPeriod;
		rx_in <= '0'; wait for baud_rate * ClockPeriod;
		rx_in <= '1'; wait for baud_rate * ClockPeriod; rx_in <= '1'; wait for baud_rate * ClockPeriod;
		rx_in <= '0'; wait for baud_rate * ClockPeriod; rx_in <= '0'; wait for baud_rate * ClockPeriod;
		rx_in <= '0'; wait for baud_rate * ClockPeriod; rx_in <= '1'; wait for baud_rate * ClockPeriod;
		rx_in <= '1'; wait for baud_rate * ClockPeriod; rx_in <= '0'; wait for baud_rate * ClockPeriod;
		rx_in <= '0'; wait for baud_rate * ClockPeriod;
		rx_in <= '1'; wait for baud_rate * ClockPeriod;
		wait for 10 * baud_rate * ClockPeriod;
		wait for 10 * baud_rate * ClockPeriod;
		rx_in <= '0'; wait for baud_rate * ClockPeriod;
		rx_in <= '1'; wait for baud_rate * ClockPeriod; rx_in <= '1'; wait for baud_rate * ClockPeriod;
		rx_in <= '1'; wait for baud_rate * ClockPeriod; rx_in <= '1'; wait for baud_rate * ClockPeriod;
		rx_in <= '0'; wait for baud_rate * ClockPeriod; rx_in <= '1'; wait for baud_rate * ClockPeriod;
		rx_in <= '1'; wait for baud_rate * ClockPeriod; rx_in <= '0'; wait for baud_rate * ClockPeriod;
		rx_in <= '1'; wait for baud_rate * ClockPeriod;
		rx_in <= '1'; wait for baud_rate * ClockPeriod;
		wait for 10 * baud_rate * ClockPeriod;
		wait for 10 * baud_rate * ClockPeriod;
		rx_in <= '0'; wait for baud_rate * ClockPeriod;
		rx_in <= '1'; wait for baud_rate * ClockPeriod; rx_in <= '1'; wait for baud_rate * ClockPeriod;
		rx_in <= '0'; wait for baud_rate * ClockPeriod; rx_in <= '1'; wait for baud_rate * ClockPeriod;
		rx_in <= '0'; wait for baud_rate * ClockPeriod; rx_in <= '1'; wait for baud_rate * ClockPeriod;
		rx_in <= '0'; wait for baud_rate * ClockPeriod; rx_in <= '1'; wait for baud_rate * ClockPeriod;
		rx_in <= '1'; wait for baud_rate * ClockPeriod;
		rx_in <= '1'; wait for baud_rate * ClockPeriod;
		wait for 10 * baud_rate * ClockPeriod;
		wait; 
	end process;
end Behavioral;
