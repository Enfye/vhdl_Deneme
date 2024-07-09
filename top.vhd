

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity top is
    Port ( data_sw_in : in STD_LOGIC_VECTOR (7 downto 0);
           clk_in,rst : in STD_LOGIC;
           button_in : in STD_LOGIC;
           baud_rate_switch : in STD_LOGIC_VECTOR (2 downto 0);
           data_led_out : out STD_LOGIC_VECTOR (7 downto 0);
		   rx_in : in STD_LOGIC;
		   tx_out: out STD_LOGIC);	   
end top;

architecture Behavioral of top is

	component control_unit is
		Port ( data_in : in STD_LOGIC_VECTOR (7 downto 0);
			   data_enable_button : in STD_LOGIC;
			   clk,empty_rx_fifo,full_tx_fifo : in STD_LOGIC;
			   w_en_tx,r_en_rx: out STD_LOGIC;
			   data_out_tx : out STD_LOGIC_VECTOR (7 downto 0);
			   data_in_rx : in STD_LOGIC_VECTOR (7 downto 0);
			   data_out_rx : out STD_LOGIC_VECTOR (7 downto 0));
	end component;
	
	component fifo_32_8_bit is
		Port (
			clk, w_en, r_en : in STD_LOGIC;
			data_in : in STD_LOGIC_VECTOR(7 downto 0);
			full, empty : out STD_LOGIC;
			data_out : out STD_LOGIC_VECTOR(7 downto 0)
		);
	end component;
	
	component debouncer is
		Port ( clk_in : in STD_LOGIC;
			   button : in STD_LOGIC;
			   output : out STD_LOGIC);
	end component;
	
	component freq_div is
		generic(divider : integer := 100_000_000/115200);
		Port ( clk : in STD_LOGIC;
			   output : out STD_LOGIC);
	end component;
	
	component uart_tx is
		Port ( txd : in STD_LOGIC_VECTOR (7 downto 0);
			   baudrate_gen_tx : in STD_LOGIC;
			   uart_txd_out : out STD_LOGIC;
			   r_flag_input: out STD_LOGIC;
			   empty_flag_input: in STD_LOGIC);
	end component;
	
	component uart_rx is
		Port ( uart_rxd : in STD_LOGIC;
			   baudrate_gen_rx : in STD_LOGIC;
			   full_flag : in STD_LOGIC;
			   uart_rxd_out : out STD_LOGIC_VECTOR (7 downto 0);
			   w_enable: out STD_LOGIC);
	end component;
	
	signal debounced_button: STD_LOGIC;
	signal bauded_clk: STD_LOGIC;
	signal uart_rxd_out: STD_LOGIC_VECTOR(7 downto 0);
	signal w_en_rx_fifo: STD_LOGIC;
	signal r_en_rx_fifo: STD_LOGIC;
	signal full_flag_rx_fifo,empty_flag_rx_fifo : STD_LOGIC;
begin
	debouncer: debouncer port map(clk_in,button_in,debounced_button);
	baud_rate_gen: freq_div generic map (divider) port map(clk_in,bauded_clk);
	control_part: control_unit port map(data_sw_in,debounced_button,bauded_clk);

	rx_fifo: fifo_32_8_bit port map(bauded_clk,w_en_rx_fifo,r_en_rx_fifo,uart_rxd_out,full_flag_rx_fifo,empty_flag_rx_fifo);
	rx: uart_rx port map(rx_in,bauded_clk,full_flag_rx_fifo,uart_rxd_out,w_en_rx_fifo);
end Behavioral;
