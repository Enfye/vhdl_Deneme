

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;



entity control_unit is
    Port ( data_in : in STD_LOGIC_VECTOR (7 downto 0);
		   data_enable_button : in STD_LOGIC;
           clk,empty_rx_fifo,full_tx_fifo : in STD_LOGIC;
           w_en_tx,r_en_rx: out STD_LOGIC;
           data_out_tx : out STD_LOGIC_VECTOR (7 downto 0);
		   data_in_rx : in STD_LOGIC_VECTOR (7 downto 0);
           data_out_rx : out STD_LOGIC_VECTOR (7 downto 0));
end control_unit;

architecture Behavioral of control_unit is
	signal temp_button : STD_LOGIC := '0';
	signal temp_data_in: STD_LOGIC_VECTOR(7 downto 0) := (others => '0');
begin
	process(clk)
	begin
		if(rising_edge(clk)) then
			temp_button	<= data_enable_button;
			if(temp_button /= data_enable_button and full_tx_fifo = '0') then
				if(temp_button = '1') then
					temp_data_in <= data_in;
				else 
					w_en_tx <= '1';
					data_out_tx	<= temp_data_in;
					if(rising_edge(clk)) then
						w_en_tx	<= '0';
					end if;
				end if;
			end if;
			if(empty_rx_fifo = '0') then
				r_en_rx	<= '1';
				data_out_rx<=data_in_rx;
				if(rising_edge(clk)) then
					r_en_rx <= '0';
				end if;
			end if;
		end if;
	end process;

end Behavioral;
