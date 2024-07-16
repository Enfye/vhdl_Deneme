library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;


-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity tb_rx is
--  Port ( );
end tb_rx;

architecture Behavioral of tb_rx is
	component rx is
		Port ( rx_in : in STD_LOGIC;
			   clk : in STD_LOGIC;
			   --data_receive_flag : out STD_LOGIC;
			   led : out STD_LOGIC_VECTOR (7 downto 0));
	end component;
	signal rx_in :  STD_LOGIC;
	signal clk :  STD_LOGIC := '0';
	signal led :  STD_LOGIC_VECTOR (7 downto 0);
	constant ClockFrequency 	: integer := 100_000_000;
	constant ClockPeriod    	: time := 1000 ms / ClockFrequency;
	constant baud_rate			: integer := 100_000_000/9600;
	
begin
	clk <= not clk after ClockPeriod / 2; 
	uut: rx port map(rx_in,clk,led);
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
		wait for 200ms;
		wait for 10 * baud_rate * ClockPeriod;
		rx_in <= '0';  wait for baud_rate * ClockPeriod;
		rx_in <= '0'; wait for baud_rate * ClockPeriod; rx_in <= '1'; wait for baud_rate * ClockPeriod;
		rx_in <= '1'; wait for baud_rate * ClockPeriod; rx_in <= '1'; wait for baud_rate * ClockPeriod;
		rx_in <= '0'; wait for baud_rate * ClockPeriod; rx_in <= '1'; wait for baud_rate * ClockPeriod;
		rx_in <= '0'; wait for baud_rate * ClockPeriod; rx_in <= '0'; wait for baud_rate * ClockPeriod;
		rx_in <= '0'; wait for baud_rate * ClockPeriod;
		rx_in <= '1'; wait for baud_rate * ClockPeriod;
		wait for 10 * baud_rate * ClockPeriod;
		wait for 200ms;
		wait for 10 * baud_rate * ClockPeriod;
		rx_in <= '0'; wait for baud_rate * ClockPeriod;
		rx_in <= '1'; wait for baud_rate * ClockPeriod; rx_in <= '1'; wait for baud_rate * ClockPeriod;
		rx_in <= '0'; wait for baud_rate * ClockPeriod; rx_in <= '0'; wait for baud_rate * ClockPeriod;
		rx_in <= '0'; wait for baud_rate * ClockPeriod; rx_in <= '1'; wait for baud_rate * ClockPeriod;
		rx_in <= '1'; wait for baud_rate * ClockPeriod; rx_in <= '0'; wait for baud_rate * ClockPeriod;
		rx_in <= '0'; wait for baud_rate * ClockPeriod;
		rx_in <= '1'; wait for baud_rate * ClockPeriod;
		wait for 10 * baud_rate * ClockPeriod;
		wait for 200ms;
		wait for 10 * baud_rate * ClockPeriod;
		rx_in <= '0'; wait for baud_rate * ClockPeriod;
		rx_in <= '1'; wait for baud_rate * ClockPeriod; rx_in <= '1'; wait for baud_rate * ClockPeriod;
		rx_in <= '1'; wait for baud_rate * ClockPeriod; rx_in <= '1'; wait for baud_rate * ClockPeriod;
		rx_in <= '0'; wait for baud_rate * ClockPeriod; rx_in <= '1'; wait for baud_rate * ClockPeriod;
		rx_in <= '1'; wait for baud_rate * ClockPeriod; rx_in <= '0'; wait for baud_rate * ClockPeriod;
		rx_in <= '1'; wait for baud_rate * ClockPeriod;
		rx_in <= '1'; wait for baud_rate * ClockPeriod;
		wait for 10 * baud_rate * ClockPeriod;
		wait for 200ms;
		wait for 10 * baud_rate * ClockPeriod;
		rx_in <= '0'; wait for baud_rate * ClockPeriod;
		rx_in <= '1'; wait for baud_rate * ClockPeriod; rx_in <= '1'; wait for baud_rate * ClockPeriod;
		rx_in <= '0'; wait for baud_rate * ClockPeriod; rx_in <= '1'; wait for baud_rate * ClockPeriod;
		rx_in <= '0'; wait for baud_rate * ClockPeriod; rx_in <= '1'; wait for baud_rate * ClockPeriod;
		rx_in <= '0'; wait for baud_rate * ClockPeriod; rx_in <= '1'; wait for baud_rate * ClockPeriod;
		rx_in <= '1'; wait for baud_rate * ClockPeriod;
		rx_in <= '1'; wait for baud_rate * ClockPeriod;
		wait for 10 * baud_rate * ClockPeriod;
	
	end process;
end Behavioral;
