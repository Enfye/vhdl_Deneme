library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;  

entity rx is
    Port ( data_in : in STD_LOGIC;
           clk : in STD_LOGIC;
		   data_receive_flag : out STD_LOGIC;
           data_out : out STD_LOGIC_VECTOR (7 downto 0));
end rx;

architecture Behavioral of rx is
	constant bit_limit: integer := 100_000_000/115_200;
	signal counter_timer: integer range 0 to bit_limit:= 0;
	signal counter: integer range 0 to 10 := 0;
	
	constant sample_counter: integer := bit_limit/16;
	signal sample_timer: integer range 0 to sample_counter := 0;

	type states is (IDLE, DATA_INCOME, PARITY, STOP);
	signal state : states:= IDLE;
	signal zeros, ones: integer range 0 to 7 := 0;
	signal ones_count: integer range 0 to 7 := 0;
	signal temp_out: STD_LOGIC_VECTOR (7 downto 0) := (others => '0');
	signal status: STD_LOGIC:= '1';
	signal temp_data_in : STD_LOGIC;
	
	--type states	is (IDLE, WAIT_START, RECEIVE, PARITY, STOP);
	--signal state: states:= IDLE;	
begin
	temp_data_in	<=	not data_in;
	process(clk)
	begin
		if(rising_edge(clk)) then
			case state is 
				when IDLE	=>
					data_receive_flag <= '0';
					if(counter_timer = bit_limit/2) then
						if(temp_data_in = '0') then
							zeros <= zeros + 1;
						elsif(temp_data_in = '1') then
							ones <= ones + 1;
						end if;
						counter_timer <= counter_timer + 1;
					elsif(counter_timer > bit_limit - 1) then
						if(zeros > ones) then
							state <= DATA_INCOME;
							zeros <= 0;
							ones <= 0;
						else
							zeros <= 0;
							ones <= 0;
						end if;
						counter_timer <= 0;
					else
						counter_timer <= counter_timer + 1;
					end if;
				when DATA_INCOME	=>
					if(counter_timer = bit_limit/2) then
						if(temp_data_in = '0') then
							zeros <= zeros + 1;
						elsif(temp_data_in = '1') then
							ones <= ones + 1;
						end if;
						counter_timer <= counter_timer + 1;
					elsif(counter_timer > bit_limit - 1) then
						if(zeros < ones) then
							temp_out(counter) <= '1';
							ones_count <= ones_count + 1;
							zeros <= 0;
							ones <= 0;
						elsif(zeros > ones) then
							temp_out(counter) <= '0';
							zeros <= 0;
							ones <= 0;
						end if;
						if(counter < 7) then
							counter <= counter + 1;
						else
							counter <= 0;
							state <= PARITY;
						end if;
						counter_timer <= 0;
					else
						counter_timer <= counter_timer + 1;
					end if;
				when PARITY	=>
					if(counter_timer = bit_limit/2) then
						if(temp_data_in = '0') then
							zeros <= zeros + 1;
						elsif(temp_data_in = '1') then
							ones <= ones + 1;
						end if;
						counter_timer <= counter_timer + 1;
					elsif(counter_timer > bit_limit - 1) then
						if(zeros < ones) then
							if((ones_count)mod 2 = 0) then
								status <= '0';
							end if;
							zeros <= 0;
							ones <= 0;
						elsif(zeros > ones) then
							if((ones_count)mod 2 = 1) then
								status <= '0';
							end if;
							zeros <= 0;
							ones <= 0;
						end if;
						state <= STOP;
						counter_timer <= 0;
					else
						counter_timer <= counter_timer + 1;
					end if;
				when STOP =>
					ones_count	<= 0;
					if(counter_timer = bit_limit/2) then
						if(temp_data_in = '0') then
							zeros <= zeros + 1;
						elsif(temp_data_in = '1') then
							ones <= ones + 1;
						end if;
						counter_timer <= counter_timer + 1;
					elsif(counter_timer > bit_limit - 1) then
						if(zeros < ones) then
							if(status = '1') then
								data_receive_flag <= '1';
								data_out <= temp_out;
								state <= IDLE;
							else
								status <= '1';
								state <= IDLE;
							end if;
							zeros <= 0;
							ones <= 0;
						end if;
						counter_timer <= 0;
					else
						counter_timer <= counter_timer + 1;
					end if;
				when others =>
					state <= IDLE;
		    end case;
			
			
	
		end if;
	end process;


	--process(clk)
	--begin
	--	if(rising_edge(clk)) then
	--		case	state	is
	--			when	IDLE	=>
	--				if(data_in	=	'0') then
	--					state	<=	WAIT_START;
	--				else
	--					state	<=	IDLE;
	--				end if;
	--			when	WAIT_START	=>
	--				if(counter_timer	<	bit_limit/2 - 1) then
	--					
	--				else
	--				end if;
	--			when	RECEIVE	=>
	--			when	PARITY	=>
	--			when	STOP	=>
	--			when	others	=>
	--			
	--		end case;
	--	end if;
	--end process;
end Behavioral;
