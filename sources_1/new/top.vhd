-------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity top is
    Port ( clk,enable : in STD_LOGIC;
           data_out : out STD_LOGIC_VECTOR (3 downto 0));
end top;

architecture Behavioral of top is
	
	component freq_div is
		Port ( clk : in STD_LOGIC;
			   divider : in integer;
			   output : out STD_LOGIC);
	end component;
	
	signal	temp	:	STD_LOGIC_VECTOR(3 downto 0);

begin
	output_timer_1:	freq_div	Port map(clk,100_000_000,temp(0));
	output_timer_2:	freq_div	Port map(clk,200_000_000,temp(1));
	output_timer_3:	freq_div	Port map(clk,400_000_000,temp(2));
	output_timer_4:	freq_div	Port map(clk,800_000_000,temp(3));

	data_out	<=	temp;	

end Behavioral;
