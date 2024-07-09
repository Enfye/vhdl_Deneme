

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity uart_rx is
    Port ( uart_rxd : in STD_LOGIC;
           baudrate_gen_rx : in STD_LOGIC;
		   full_flag : in STD_LOGIC;
           uart_rxd_out : out STD_LOGIC_VECTOR (7 downto 0);
		   w_enable: out STD_LOGIC);
end uart_rx;

architecture Behavioral of uart_rx is
	type   states is (START,DATA,PARITY,STOP,SEND_DATA);
	signal state : states := START;
	signal counter : integer range 0 to 7:= 7;
	signal temp_out: STD_LOGIC_VECTOR(7 downto 0) := (others => '0');
	signal temp_sub,status: STD_LOGIC:= '0';
begin
	process(baudrate_gen_rx)
	begin
		if(rising_edge(baudrate_gen_rx)) then
			case state is
				when START =>
					if(uart_rxd	= '0') then
						state <= DATA;
					end if;
				when DATA  =>
					if(counter = 0) then
						state <= PARITY;
						counter <= 7;
					else
						temp_sub	<=	temp_sub + uart_rxd;
						temp_out(counter) <= uart_rxd;
						counter	<=	counter - 1;
					end if;
				when PARITY =>
					if(temp_sub = '0') then
						if(uart_rxd = '0') then
							status <= '0';
						else
							status <= '1';
						end if;
					else
						if(uart_rxd = '0') then
							status <= '1';
						else
							status <= '0';
						end if;
					end if;
					state <= STOP;
				when STOP  =>
					if (uart_rxd = '1') then
						if(status = '1') then
							state <= START;
						else
							state <= SEND_DATA;
							w_enable <= '1';
						end if;
					end if;
				when SEND_DATA => 
					uart_rxd_out  <=  temp_out;
					w_enable	<= '0';
					state	<= START;
				when others =>
					state <= START;
			end case;
		end if;
	end process;
	

end Behavioral;
