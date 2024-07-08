library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL; 

entity uart_tx is
    Port ( txd : in STD_LOGIC_VECTOR (7 downto 0);
           ctrl_tx,baudrate_gen_tx : in STD_LOGIC;
           uart_txd : out STD_LOGIC_VECTOR (10 downto 0));
end uart_tx;

architecture Behavioral of uart_tx is
	signal counter : integer := 0;
	signal bit_counter : integer := 0;
	type   states is (START,DATA,PARITY,STOP);
	signal state : states := START;
begin
	process
	begin
		for i in 0 to 7 loop
			if(txd(i) = '1') then
				counter <= counter + 1;
			end if;
		end loop;
	end process;
	process(baudrate_gen_tx)
	begin
		if(rising_edge(baudrate_gen_tx)) then
			case state is
				when START => 
					uart_txd(0) <=	'0';
					state	<=  DATA;
				when DATA  =>
					uart_txd(8 downto 1) <= txd;
					state  <=	PARITY;
				when PARITY =>
					if((counter) mod 2 = 1) then
						uart_txd(9) <= '1';
					else
						uart_txd(9) <= '0';
					state <=	STOP;
					end if;
				when STOP =>
					uart_txd(10) <= '1';
				when others =>
					uart_txd <= (others => '0');
					state <= START;
			end case;
		end if;
	end process;
end Behavioral;
