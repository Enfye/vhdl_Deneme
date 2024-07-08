

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;



entity sipo_shift_register is
    Port ( serial_in : in STD_LOGIC;
           clk_sipo : in STD_LOGIC;
		   enable_sipo	: in STD_LOGIC;
           paralel_out : out STD_LOGIC_VECTOR (7 downto 0));
end sipo_shift_register;

architecture Behavioral of sipo_shift_register is
	signal	counter	:integer range 0 to 8:= 0;
begin
	process(clk_sipo)
	begin
		if(rising_edge(clk_sipo) and enable_sipo = '1') then
			if(counter = 8) then
				counter <= 0;
			else
				counter	<= counter + 1;
				paralel_out(counter) <= serial_in;
			end if;
		end if;
	end process;
	
end Behavioral;
