library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL; 

entity uart_tx is
    Port ( txd : in STD_LOGIC_VECTOR (7 downto 0);
           baudrate_gen_tx : in STD_LOGIC;
           uart_txd_out : out STD_LOGIC;
		   r_flag_input: out STD_LOGIC;
		   empty_flag_input: in STD_LOGIC);
end uart_tx;

architecture Behavioral of uart_tx is
	signal counter : integer := 0;
	signal bit_counter : integer := 0;
	signal uart_txd :  STD_LOGIC_VECTOR (10 downto 0) := (others =>	'0');
	signal temp_txd : STD_LOGIC_VECTOR (7 downto 0);
	signal temp_out	:  STD_LOGIC;
	
	type   states is (IDLE,DATA_PROCESS,SEND);
	signal state : states := DATA_PROCESS;
begin
	process(baudrate_gen_tx)
	begin
		if(rising_edge(baudrate_gen_tx)) then
			case state is
				when IDLE	=>
					if(empty_flag_input = '0') then
						r_flag_input	<= '1';
						state	<= DATA_PROCESS;
					else
						temp_out <= '1';
					end if;
				when DATA_PROCESS   =>
					uart_txd(0) <=	'0';
					uart_txd(8 downto 1) <= txd;
					if(txd(0) xor txd(1) xor txd(2) xor txd(3) xor txd(4) xor txd(5) xor txd(6) xor txd(7) = '1') then
						uart_txd(9) <= '1';
					else
						uart_txd(9) <= '0';
					end if;
					uart_txd(10) <= '1';
					state <= SEND;
					r_flag_input <= '0';
					temp_out <= uart_txd(0);
				when SEND   =>
					if (counter < 9) then
						uart_txd(9 downto 0) <=	uart_txd(10 downto 1);
						temp_out <=	uart_txd(0);
						counter <= counter + 1;
					else 
						counter <= 0;
						state	<= IDLE;
					end if;
				when others		=>
					state	<= IDLE;
			end case;
		end if;
	end process;
	uart_txd_out	<=	temp_out;
end Behavioral;
