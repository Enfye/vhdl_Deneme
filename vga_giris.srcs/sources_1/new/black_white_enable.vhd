

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;



entity black_white_enable is
    Port ( clk : in STD_LOGIC;
           enable : in STD_LOGIC;
           R,G,B : out STD_LOGIC);
end black_white_enable;

architecture Behavioral of black_white_enable is

begin
	process(clk) begin
		if(rising_edge(clk)) then
			if(enable = '1') then
				R 	<=	'1';
				G 	<=	'1';
				B 	<=	'1';
			else
				R 	<=	'1';
				G 	<=	'1';
				B 	<=	'1';
			end if;      
		end if;
	end process;
 
end Behavioral;
