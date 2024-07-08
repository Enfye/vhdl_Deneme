
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity clk_gen is
    Port ( clk,enable : in STD_LOGIC;
           clk_out: inout STD_LOGIC;
		   );
end clk_gen;

architecture Behavioral of clk_gen is
	
begin
	process(clk)
	begin
		if(clk'event and enable = '1') then
			clk_out <= clk;
		end if;
	end process;

end Behavioral;
