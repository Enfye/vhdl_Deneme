

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity tb_shift_reg is
--  Port ( );
end tb_shift_reg;

architecture Behavioral of tb_shift_reg is

	component shift_register is
		Port ( data_in : in STD_LOGIC_VECTOR (7 downto 0);
			   clk : in STD_LOGIC;
			   serial_out : out STD_LOGIC);
	end component;
	signal	data_in:	STD_LOGIC_VECTOR (7 downto 0);
	signal	clk:		STD_LOGIC	:=	'0';
	signal	serial_out:	STD_LOGIC;
	
	constant ClockFrequency 	: integer := 100_000_000;
    constant ClockPeriod    	: time := 1000 ms / ClockFrequency;
	
begin
	clk <= not clk after ClockPeriod / 2;
	
	uut:	shift_register	port map(data_in,clk,serial_out);
	
	process
	begin
		data_in		<=	"00100100";
		wait for ClockPeriod*10;
		
		data_in		<=	"10100100";
		wait for ClockPeriod*10;
		
		data_in		<=	"11000111";
		wait for ClockPeriod*10;
		
		wait;
	end process;

end Behavioral;
