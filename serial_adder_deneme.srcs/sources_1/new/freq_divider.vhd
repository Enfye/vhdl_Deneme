
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity freq_divider is
    Port ( clk_input : in STD_LOGIC;
           clk_divided : out STD_LOGIC);
end freq_divider;

architecture Behavioral of freq_divider is
	constant	divider:	integer:=	1;
	signal	counter:	integer range 0 to divider:=	0;
	signal	temp:		STD_LOGIC:=	'0';
	
begin
	process(clk_input)
	begin
		if(rising_edge(clk_input)) then
			if(counter = divider) then
				counter	<=	0;
				temp	<=	not temp;
			else
				counter	<=	counter + 1;
			end if;
		end if;
	end process;
	clk_divided		<=	temp;
end Behavioral;
