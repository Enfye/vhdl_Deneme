
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
	signal temp_transmit_flag : STD_LOGIC;
begin
	process(clk)
	begin
		if(rising_edge(clk)) then
			temp_transmit_flag	<=	data_transmit_flag;
			case state is
				when IDLE =>
					if(data_transmit_flag = '0' and temp_transmit_flag /= data_transmit_flag) then
						temp_data_in <= data_in;
						state <= DATA_SEND;
					end if;
					temp_out <= '0';
				when DATA_SEND => 
					if(counter_timer = bit_limit-1) then
						if(counter = 0) then
							temp_out <= '1';
							counter <= counter + 1;
						elsif(counter > 0 and counter < 9) then
							temp_out <= not temp_data_in(counter - 1);
							ctr_bit <= ctr_bit xor temp_data_in(counter - 1);
							counter <= counter + 1;
						--elsif(counter = 9) then
						--	temp_out <= ctr_bit;
						--	counter <= counter + 1;
						elsif(counter = 9) then
							counter  <= 0;
							temp_out <= '0';
							state <= IDLE;
							ctr_bit	<=	'0';
							--temp_data_in <= not temp_data_in;
						end if;
						counter_timer <= 0;
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
