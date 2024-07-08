

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity tb_clock_Div is

end tb_clock_Div;

architecture Behavioral of tb_clock_Div is
	component clock_Div
		Port(
				clk_in			:in STD_LOGIC;
				freq_div		:in STD_LOGIC_VECTOR(7 downto 0);
				timer_select	:in	STD_LOGIC_VECTOR(3 downto 0);
				clk_out			:out STD_LOGIC_VECTOR(3 downto 0)
			   );
	end component;
	
	signal	clk_in			:STD_LOGIC	:=	'0';
	signal	freq_div		:STD_LOGIC_VECTOR(7 downto 0);
	signal	timer_select	:STD_LOGIC_VECTOR(3 downto 0);
	signal	clk_out			:STD_LOGIC_VECTOR(3 downto 0);
	
	constant ClockFrequency : integer := 100_000_000;
    constant ClockPeriod    : time := 1000 ms / ClockFrequency;

	
begin
	uut:	clock_Div	port map(
	clk_in	=>	clk_in,
	freq_div =>	freq_div,
	timer_select	=>	timer_select,
	clk_out	=>	clk_out
	);
	
	clk_in <= not clk_in after ClockPeriod / 2;
	
	process
	begin
		freq_div	<=	"00001000";
		wait for ClockPeriod;
		timer_select	<=	"1111";
		
	end process;
end Behavioral;
