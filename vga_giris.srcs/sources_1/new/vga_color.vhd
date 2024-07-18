


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity vga_color is
    Port ( clk : in STD_LOGIC;
           pixel_x,pixel_y : in STD_LOGIC_VECTOR (9 downto 0);
           R,G,B : out STD_LOGIC);
end vga_color;

architecture Behavioral of vga_color is

begin
	process(clk) begin
		if(rising_edge(clk)) then
			if(pixel_x	< "0101000000") then
				R	<=	'1';
				G	<=	'0';
				B	<=	'0';
			else
				R	<=	'0';
				G	<=	'1';
				B	<=	'0';
			end if;
		end if;
	end process;

end Behavioral;
