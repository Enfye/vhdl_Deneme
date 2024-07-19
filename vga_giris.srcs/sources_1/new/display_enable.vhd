

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;



entity black_white_enable is
    Port ( clk : in STD_LOGIC;
           enable : in STD_LOGIC;
           R,G,B : out STD_LOGIC);
end black_white_enable;

architecture Behavioral of black_white_enable is
	signal	temp_R,temp_G,temp_B	:STD_LOGIC:= '1';
begin
	process(clk) begin
		if(rising_edge(clk)) then
			if(enable = '1') then
				temp_R 	<=	'0';
				temp_G 	<=	'0';
				temp_B 	<=	'0';
			else
				temp_R 	<=	'1';
				temp_G 	<=	'1';
				temp_B 	<=	'1';
			end if;      
		end if;
	end process;
	R	<=	temp_R;
	G	<=	temp_G;
	B	<=	temp_B;
end Behavioral;
