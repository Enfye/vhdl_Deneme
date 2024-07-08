library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;  

entity fifo is
    Port (
        clk, rest, w_en, r_en : in STD_LOGIC;
        data_in : in STD_LOGIC;
        full, empty : out STD_LOGIC;
        data_out : out STD_LOGIC
    );
end fifo;

architecture Behavioral of fifo is

    signal fifo_reg  : STD_LOGIC_VECTOR (7 downto 0):= (others => '0');
    signal w_ptr, r_ptr : integer range 0 to 7 := 0;
    signal counter : integer range 0 to 8 := 0; 
begin
    process(clk, rest)
    begin
        if rising_edge(clk) then
            if rest = '1' then
                w_ptr <= 0;
                r_ptr <= 0;
                counter <= 0;
                fifo_reg <= (others => '0');
                full <= '0';
                empty <= '1';
                data_out <= '0';
            else
                if w_en = '1' and r_en = '0' then
					full	<=	'0';
					empty	<=	'0';
                    if counter < 8 then
                        fifo_reg(w_ptr) <= data_in;
                        w_ptr <= (w_ptr + 1) mod 8;
                        counter <= counter + 1;
                    end if;
                elsif w_en = '0' and r_en = '1' then
                    if counter > 0 then
                        data_out <= fifo_reg(r_ptr);
                        r_ptr <= (r_ptr + 1) mod 8;
                        counter <= counter - 1;
                    end if;
                end if;
				if(counter = 8) then
					full	<=	'1';
				elsif(counter = 0) then
					empty	<=	'1';
				end if;
            end if;
        end if;
    end process;
end Behavioral;
