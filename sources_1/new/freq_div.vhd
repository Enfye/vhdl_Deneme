library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity freq_div is
    Port ( clk : in STD_LOGIC;
           divider : in integer;
           output : out STD_LOGIC);
end freq_div;

architecture Behavioral of freq_div is
    signal counter: integer range 0 to integer'high := 0;
    signal temp: STD_LOGIC := '0';
begin
    process(clk)
    begin
        if rising_edge(clk) then
            if counter = divider  then
                temp <= not temp;
                counter <= 0;
            else
                counter <= counter + 1;
            end if;
        end if;
    end process;
    output <= temp;
end Behavioral;
