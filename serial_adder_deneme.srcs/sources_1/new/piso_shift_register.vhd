

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;



entity piso_shift_register is
    Port ( data_in : in STD_LOGIC_VECTOR (7 downto 0);
           clk_piso,enable_piso : in STD_LOGIC;
           serial_out : out STD_LOGIC);
end piso_shift_register;

architecture Behavioral of piso_shift_register is

	signal	shreg,temp	:STD_LOGIC_VECTOR(7	downto	0)	:=	(others	=>	'0');
	signal	counter	:integer range 0 to 8	:=	0;

begin
	
	process(clk_piso)
	begin
		if(enable_piso	= '1') then
			if(rising_edge(clk_piso)) then
				temp  <=	data_in;
				if(temp /= data_in) then
					shreg	<=	data_in;
					counter <=	0;
				else
					if(counter < 7) then
						shreg(6 downto 0)	<=	shreg(7 downto 1);
						counter		<=	counter + 1;
					end if;
				end if;
			end if;
		end if;
	end process;
	serial_out	<=	shreg(0);
end Behavioral;
