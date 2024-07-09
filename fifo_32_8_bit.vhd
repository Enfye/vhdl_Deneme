library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;  
entity fifo_32_8_bit is
    Port (
        clk, w_en, r_en : in STD_LOGIC;
        data_in : in STD_LOGIC_VECTOR(7 downto 0);
        full, empty : out STD_LOGIC;
        data_out : out STD_LOGIC_VECTOR(7 downto 0)
    );
end fifo_32_8_bit;

architecture Behavioral of fifo_32_8_bit is
    type fifo_array is array (0 to 31) of STD_LOGIC_VECTOR(7 downto 0);
    signal fifo_reg : fifo_array := (others => (others => '0'));
    signal w_ptr, r_ptr : integer range 0 to 31 := 0;
    signal counter : integer range 0 to 32 := 0; 
begin
    process(clk)
    begin
        if rising_edge(clk) then
            --if rest = '1' then
            --    w_ptr <= 0;
            --    r_ptr <= 0;
            --    counter <= 0;
            --    fifo_reg <= (others => (others => '0'));
            --    full <= '0';
            --    empty <= '1';
            --    data_out <= (others => '0');
            --else
                if w_en = '1' and r_en = '0' then
					full	<=	'0';
					empty	<=	'0';
                    if counter < 32 then
                        fifo_reg(w_ptr) <= data_in;
                        w_ptr <= (w_ptr + 1) mod 32;
                        counter <= counter + 1;
                    end if;
                elsif w_en = '0' and r_en = '1' then
                    if counter > 0 then
                        data_out <= fifo_reg(r_ptr);
                        r_ptr <= (r_ptr + 1) mod 32;
                        counter <= counter - 1;
                    end if;
                end if;
                if(counter = 8) then
					full	<=	'1';
				elsif(counter = 0) then
					empty	<=	'1';
				end if;
            --end if;
        end if;
    end process;
end Behavioral;
