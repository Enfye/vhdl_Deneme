
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;



entity tb_rx_tx is
--  Port ( );
end tb_rx_tx;

architecture Behavioral of tb_rx_tx is
	component top_rx_tx is
		port(
			clk:	in	STD_LOGIC;
			button:	in STD_LOGIC;
			data_i:	in	STD_LOGIC_VECTOR (7 downto 0);
			data_o: out STD_LOGIC_VECTOR (7 downto 0)
		);
	end component;
	constant ClockFrequency 	: integer := 100_000_000;
	constant ClockPeriod    	: time := 1000 ms / ClockFrequency;
	constant baud_rate			: integer := 100_000_000/115_200;
	signal clk: STD_LOGIC := '0';
	signal data_transmit_flag:	STD_LOGIC;
	signal data_i:		STD_LOGIC_VECTOR (7 downto 0);
	signal data_o:  STD_LOGIC_VECTOR (7 downto 0);
	
begin
	clk <= not clk after ClockPeriod / 2; 
	uut: top_rx_tx port map(clk,data_transmit_flag, data_i, data_o);
	
	process
	begin
		wait for ClockPeriod;
		data_transmit_flag <= '1';
		data_i	<= x"65";
		wait for ClockPeriod;
		data_transmit_flag	<= '0';
		wait for 100 * baud_rate * ClockPeriod;
		
		wait for ClockPeriod;
		data_transmit_flag <= '1';
		data_i	<= x"FF";
		wait for ClockPeriod;
		data_transmit_flag	<= '0';
		wait for 100 * baud_rate * ClockPeriod;
		
		wait for ClockPeriod;
		data_transmit_flag <= '1';
		data_i	<= x"DC";
		wait for ClockPeriod;
		data_transmit_flag	<= '0';
		wait for 100 * baud_rate * ClockPeriod;
		
		wait for ClockPeriod;
		data_transmit_flag <= '1';
		data_i	<= x"55";
		wait for ClockPeriod;
		data_transmit_flag	<= '0';
		wait for 100 * baud_rate * ClockPeriod;
		
		wait for ClockPeriod;
		data_transmit_flag <= '1';
		data_i	<= x"DC";
		wait for ClockPeriod;
		data_transmit_flag	<= '0';
		wait for 100 * baud_rate * ClockPeriod;
		--wait for ClockPeriod;
		--data_transmit_flag <= '1';
		--wait for ClockPeriod;
		--data_transmit_flag	<= '0';
		wait;
	end process;
end Behavioral;
