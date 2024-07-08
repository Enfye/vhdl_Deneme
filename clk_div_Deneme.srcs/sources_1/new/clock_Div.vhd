library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity clock_Div is
    Port(
        clk_in          : in  STD_LOGIC;
        freq_div        : in  STD_LOGIC_VECTOR(7 downto 0);
        timer_select    : in  STD_LOGIC_VECTOR(3 downto 0);
        clk_out         : out STD_LOGIC_VECTOR(3 downto 0)
       );
end clock_Div;

architecture Behavioral of clock_Div is

    signal clk_out_1   : STD_LOGIC := '0';
    signal clk_out_2   : STD_LOGIC := '0';
    signal clk_out_3   : STD_LOGIC := '0';
    signal clk_out_4   : STD_LOGIC := '0';

    component clk_gen is
        Port ( 
            clk      : in STD_LOGIC;
            enable   : in STD_LOGIC;
            clk_out  : out STD_LOGIC
        );
    end component;

    signal counter      : integer range 0 to 255 := 0;
    signal div_value    : integer := 0;
	
	signal	clk_in_1	: STD_LOGIC := '0';
	signal	clk_in_2	: STD_LOGIC := '0';
	signal	clk_in_3	: STD_LOGIC := '0';
	signal	clk_in_4	: STD_LOGIC := '0';

begin

    clk_1	:	clk_gen	Port map(clk_in_1,timer_select(0),clk_out_1);
	clk_2	:	clk_gen	Port map(clk_in_2,timer_select(1),clk_out_2);
	clk_3	:	clk_gen	Port map(clk_in_3,timer_select(2),clk_out_3);
	clk_4	:	clk_gen	Port map(clk_in_4,timer_select(3),clk_out_4);

    process(clk_in)
    begin
        if rising_edge(clk_in) then
            div_value <= to_integer(unsigned(freq_div));

            counter <= counter + 1;

            if counter = div_value then
                clk_in_1 <= not clk_in_1;
                counter <= 0;
            elsif counter = div_value / 2 then
                clk_in_2 <= not clk_in_2;
            elsif counter = div_value / 4 then
                clk_in_3 <= not clk_in_3;
            elsif counter = div_value / 8 then
                clk_in_4 <= not clk_in_4;
            end if;
        end if;
    end process;

    clk_out <= clk_out_1 & clk_out_2 & clk_out_3 & clk_out_4;

end Behavioral;
