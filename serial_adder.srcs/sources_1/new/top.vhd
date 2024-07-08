

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity top is
    Port ( clk : in STD_LOGIC;
           A_in,B_in : in STD_LOGIC_VECTOR (7 downto 0);
           Start : in STD_LOGIC;
           S_out : out STD_LOGIC_VECTOR (7 downto 0));
end top;

architecture Behavioral of top is
	component piso_shift_register is
		Port ( data_in : in STD_LOGIC_VECTOR (7 downto 0);
			   clk_piso,enable_piso : in STD_LOGIC;
			   serial_out : out STD_LOGIC);
	end component;
	
	component full_adder is
		Port ( A,B,C_in : in STD_LOGIC;
			   S,C_out : out STD_LOGIC);
	end component;
	
	component sipo_shift_register is
		Port ( serial_in : in STD_LOGIC;
			   clk_sipo : in STD_LOGIC;
			   enable_sipo	: in STD_LOGIC;
			   paralel_out : out STD_LOGIC_VECTOR (7 downto 0));
	end component;
	
	component freq_divider is
		Port ( clk_input : in STD_LOGIC;
			   clk_divided : out STD_LOGIC);
	end component;

	signal	A,B,S,C_out	 	:  STD_LOGIC;
	signal enable_in,enable_out	: STD_LOGIC:=	'0';
	signal	prev_C_in	:  STD_LOGIC	:= '0';
	signal clk_div		: STD_LOGIC;
	signal temp_out		: STD_LOGIC_VECTOR(7 downto	0);
	
	signal counter		: integer range 0 to 1:= 0;
	signal A_inner,B_inner :STD_LOGIC_VECTOR (7 downto 0) := (others => '0');
	
	
	type	states	is (IDLE,DATA_SEND,DATA_PROCESS);
	signal	state	:states	:=	IDLE;
begin
	freq_divider_40ns:	freq_divider		port map(clk,clk_div);
	shift_register_A:	piso_shift_register	port map(A_inner,clk_div,enable_in,A);
	shift_register_B:	piso_shift_register	port map(B_inner,clk_div,enable_in,B);
	full_adder_1:		full_adder			port map(A,B,prev_C_in,S,C_out);	
	shift_register_out:	sipo_shift_register port map(S,clk_div,enable_out,temp_out);

	
	process(clk_div)
	begin
		if(rising_edge(clk_div) and Start = '0') then
			case state is
				when	DATA_SEND =>	
					A_inner	<=	A_in;
					B_inner	<=	B_in;
					state	<=	DATA_PROCESS;
				when	DATA_PROCESS =>
					enable_in	<=	'1';
					prev_C_in	<=	C_out;
					counter <= counter + 1;
					if(counter > 0 and counter < 8) then
						enable_out	<=	'1';
					elsif(counter > 8) then
						state	<=	IDLE;
						enable_in 	<=	'0';
						counter		<=	0;
					end if;
				when 	IDLE	=>
					enable_out	<=	'0';
				when	others	=>
					enable_out	<=	'0';
			end case;
		elsif(Start = '1') then
			state	<=	DATA_SEND;
		end if;
		
	end process;
	S_out	<=	temp_out;
end Behavioral;
