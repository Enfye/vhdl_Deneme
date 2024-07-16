----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity top_rx_tx is
	port(
		clk:	in	STD_LOGIC;
		button:	in STD_LOGIC;
		data_i:	in	STD_LOGIC_VECTOR (7 downto 0);
		data_o: out STD_LOGIC
	);
end top_rx_tx;

architecture Behavioral of top_rx_tx is
	component uart_rx is
		Port ( 	clk		: in std_logic;
				rx_i	: in std_logic;
				dout_o	: out std_logic_vector (7 downto 0));
	end component;
	
	component tx is
		Port ( data_in : in STD_LOGIC_VECTOR (7 downto 0);
			   clk : in STD_LOGIC;
			   data_transmit_flag : in STD_LOGIC;
			   data_out : out STD_LOGIC);
	end component;
	
	component debouncer is
		Port ( clk_in : in STD_LOGIC;
			   button : in STD_LOGIC;
			   output : out STD_LOGIC);
	end component;
	
	signal data_receive_flag, data_transmit_flag: STD_LOGIC	:= '0';
	signal data_out  :STD_LOGIC;
	
begin
	debouncer_button: debouncer port map(clk, button, data_transmit_flag);
	tx_test	:	tx	port map(data_i, clk, data_transmit_flag, data_o);
	--rx_test	:	uart_rx	port map(clk, data_out, data_o);

	

end Behavioral;
