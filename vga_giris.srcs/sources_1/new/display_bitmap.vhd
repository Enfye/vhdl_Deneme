
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;



entity display_bitmap is
    Port ( clk : in STD_LOGIC;
           letter_in : in STD_LOGIC_VECTOR (63 downto 0);
           pixel_x,pixel_y : in STD_LOGIC_VECTOR (9 downto 0);
           color_bit : out STD_LOGIC);
end display_bitmap;

architecture Behavioral of display_bitmap is
	type	square_8_8_bitmap	is	array (0 to 7) of STD_LOGIC_VECTOR(7 downto 0);
	type	bit_map	is array (0 to 79, 0 to 59) of square_8_8_bitmap;
	signal	displayMap	:bit_map:=	(others	=>	'0');
	
	signal	coloumn	: integer range 0 to 79 := 0;
	signal	row		: integer range 0 to 59 := 0;
begin

	letter_placement:
	process(clk) begin
		if(coloumn	<	79) then
			
		else
		end if;
	end process;
	

end Behavioral;
