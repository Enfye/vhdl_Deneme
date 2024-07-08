library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity seq_detector is
    Port (
        data_in      : in  std_logic_vector (19 downto 0);
        clk          : in  std_logic;
        seq_counter  : inout std_logic_vector(3 downto 0)
    );
end seq_detector;

architecture Behavioral of seq_detector is
    
    type states is (START, A, B, C);
    signal state        : states := START;
    signal shreg        : std_logic_vector(19 downto 0);
	signal bit_counter	: integer range 0 to 19 := 0;
    signal MSB          : std_logic := '0';

begin
--process(data_in)
--begin
--	shreg	<=	data_in;
--	seq_counter <= "0000";
--end process;
    process(clk)
    begin
        if rising_edge(clk) then
			--MSB <= shreg(19);
			shreg(19 downto 1) <= shreg(18 downto 0);
			bit_counter	<= bit_counter + 1;
		end if;
		if data_in'event then
			shreg	<=	data_in;
			seq_counter <= "0000";
		end if;
	end process;
	process(MSB)
	begin
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
					seq_counter <= seq_counter + 1;
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
	end process;

end Behavioral;

