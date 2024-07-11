
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity tx is
    Port ( data_in : in STD_LOGIC_VECTOR (7 downto 0);
           clk : in STD_LOGIC;
		   data_transmit_flag : in STD_LOGIC;
           data_out : out STD_LOGIC);
end tx;

architecture Behavioral of tx is
	constant bit_limit: integer := 100_000_000/115_200;
	signal counter_timer: integer range 0 to bit_limit:= 0;
	signal counter: integer range 0 to 10 := 0;
	signal ctr_bit: STD_LOGIC := '0';
	signal temp_out: STD_LOGIC := '1';
	type states is (IDLE,DATA_SEND);
	signal state : states := IDLE;
	signal  temp_data_in :  STD_LOGIC_VECTOR (7 downto 0);
begin
	process(clk)
	begin
		if(rising_edge(clk)) then
			case state is
				when IDLE =>
					if(data_transmit_flag = '1') then
						temp_data_in <= data_in;
					end if;
					if(temp_data_in /= data_in) then
						state <= DATA_SEND;
					end if;
					temp_out <= '1';
				when DATA_SEND => 
					if(counter_timer = bit_limit) then
						if(counter = 0) then
							temp_out <= '0';
						elsif(counter > 1 and counter < 8) then
							temp_out <= temp_data_in(8 - counter);
							ctr_bit <= ctr_bit xor temp_data_in(8 - counter);
						elsif(counter = 9) then
							temp_out <= ctr_bit;
						elsif(counter = 10) then
							counter  <= 0;
							temp_out <= '1';
						else
							counter <= counter + 1;
						end if;
					else
						counter_timer <= counter_timer + 1;
					end if;
				when others => 
					state <= DATA_SEND;
			end case;
		end if;
	end process;
	data_out <= temp_out;

end Behavioral;
