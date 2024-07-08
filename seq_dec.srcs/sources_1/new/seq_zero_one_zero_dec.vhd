library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity seq_zero_one_zero_dec is
	Port (
        data_in      : in  std_logic_vector (19 downto 0);
        clk          : in  std_logic;
        seq_counter  : inout std_logic_vector(3 downto 0)
    );
end seq_zero_one_zero_dec;

architecture Behavioral of seq_zero_one_zero_dec is

	type states is (START, A, B, C);
    signal state        : states := START;
    signal shreg        : std_logic_vector(19 downto 0);
	signal bit_counter	: integer range 0 to 20 := 0;
    signal MSB          : std_logic := '0';
	
	
begin
	process(clk,data_in)
	begin
		if(rising_edge(clk)) then
			MSB <= shreg(19);
			shreg(19 downto 1) <= shreg(18 downto 0);
			if(bit_counter /= 0) then
				
				case state is
				when START =>
					if MSB = '0' then
						state <= A;
					end if;
				when A =>
					if MSB = '1' then
						state <= B;
					end if;
				when B =>
					if MSB = '0' then
						state <= C;
						seq_counter <= std_logic_vector(unsigned(seq_counter) + 1);
					else
						state <= START;
					end if;
				when C =>
					if MSB = '0' then
						state <= A;
					else
						state <= B;
					end if;
				end case;
			end if;
			bit_counter	<= bit_counter + 1;
		elsif(data_in'event or bit_counter = 20) then
			shreg	<=	data_in;
			seq_counter <= "0000";
			state <= START;
			bit_counter <= 0;
		end if;
	end process;

end Behavioral;
