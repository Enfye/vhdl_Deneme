 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity top is
    Port ( button_in : in STD_LOGIC;
		   clk : in STD_LOGIC;
           rx_in : in STD_LOGIC;
           tx_out : out STD_LOGIC;
           led : out STD_LOGIC_VECTOR (7 downto 0));
end top;

architecture Behavioral of top is
	component debouncer is
		Port ( clk_in : in STD_LOGIC;
			   button : in STD_LOGIC;
			   output : out STD_LOGIC);
	end component;

	component tx is
		Port ( data_in : in STD_LOGIC_VECTOR (7 downto 0);
			   clk : in STD_LOGIC;
			   data_transmit_flag : in STD_LOGIC;
			   data_out : out STD_LOGIC);
	end component;

	component rx is
		Port ( data_in : in STD_LOGIC;
			   clk : in STD_LOGIC;
			   data_receive_flag : out STD_LOGIC;
			   data_out : out STD_LOGIC_VECTOR (7 downto 0));
	end component;

	component fifo_32_8_bit is
		Port (
			clk, w_en, r_en : in STD_LOGIC;
			data_in : in STD_LOGIC_VECTOR(7 downto 0);
			full, empty : out STD_LOGIC;
			data_out : out STD_LOGIC_VECTOR(7 downto 0)
		);
	end component;
	signal debounced_button_out: STD_LOGIC;
	signal temp_button: STD_LOGIC;
	type states is (IDLE,SEND);
	signal state : states := IDLE;
	signal data_send: STD_LOGIC := '0';
	
	signal data_tx: STD_LOGIC_VECTOR(7 downto 0);
	signal data_rx: STD_LOGIC_VECTOR(7 downto 0);
	signal data_receive_flag,data_transmit_flag: STD_LOGIC;
	signal full,empty: STD_LOGIC := '0';
begin
debounced_button: debouncer port map (clk,button_in,debounced_button_out);

fifo: fifo_32_8_bit port map(clk,data_receive_flag,data_send,data_rx,full,empty,led);
rx_module: rx port map(rx_in,clk,data_receive_flag,data_rx);
tx_module: tx port map(data_tx,clk,data_transmit_flag,tx_out);
	process(clk)
	begin
		if(rising_edge(clk)) then
			case state is
				when IDLE => 
					temp_button <= debounced_button_out;
					if(temp_button /= debounced_button_out) then
						data_send <= '1';
						state <= SEND;
					end if;
					if(full = '1') then
						data_tx <= x"46";
						data_transmit_flag <= '1';
						state <= SEND;
					elsif(empty = '1') then
						data_tx <= x"45";
						data_transmit_flag <= '1';
						state <= SEND;
					end if;
				when SEND =>
					data_send <= '0';
					data_transmit_flag <= '0';
					state <= IDLE;
				when others => 
			end case;
			
		end if;
	end process;
end Behavioral;
