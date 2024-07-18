---------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;


entity rom_alphabet_chars is
    Port ( ascii_in : in STD_LOGIC_VECTOR(7 downto 0);
           clk : in STD_LOGIC;
		   take_data_enable	: in STD_LOGIC;
		   pixel_x,pixel_y : in STD_LOGIC_VECTOR (9 downto 0);
           bit_enable : out STD_LOGIC);
end rom_alphabet_chars;

architecture Behavioral of rom_alphabet_chars is

	type	square_8_8_bitmap	is	array (0 to 7) of STD_LOGIC_VECTOR(7 downto 0);
	type	bitmap_8_8_rom is array  (0 to 25) of square_8_8_bitmap;
	
	type	bit_map	is array (0 to 79, 0 to 59) of square_8_8_bitmap;
	signal	displayMap	:bit_map:=	(others => (others => (others => (others => '0'))));
	
	signal	temp_square		:	square_8_8_bitmap;
	
	signal	temp_row		:	STD_LOGIC_VECTOR(7 downto 0) 	:= (others => '0');
	signal	temp_out		:	STD_LOGIC_VECTOR(63 downto 0)	:= (others => '0');
	
	signal	letters_rom		:	bitmap_8_8_rom	:=	(
	0	=>	(x"00", x"3C", x"66", x"66", x"7E", x"66", x"66", x"00"),

	1	=>	(x"00", x"7C", x"66", x"66", x"7C", x"66", x"66", x"7C"),

	2	=>	(x"00", x"3C", x"66", x"60", x"60", x"60", x"66", x"3C"),

	3	=>	(x"00", x"7C", x"66", x"66", x"66", x"66", x"66", x"7C"),

	4	=>	(x"00", x"7E", x"60", x"60", x"7C", x"60", x"60", x"7E"),

	5	=>	(x"00", x"7E", x"60", x"60", x"7C", x"60", x"60", x"60"),

	6	=>	(x"00", x"3C", x"66", x"60", x"6E", x"66", x"66", x"3C"),

	7	=>	(x"00", x"66", x"66", x"66", x"7E", x"66", x"66", x"66"),

	8	=>	(x"00", x"3C", x"18", x"18", x"18", x"18", x"18", x"3C"),

	9	=>	(x"00", x"1E", x"0C", x"0C", x"0C", x"0C", x"6C", x"38"),

	10	=>	(x"00", x"66", x"66", x"6C", x"78", x"6C", x"66", x"66"),

	11	=>	(x"00", x"60", x"60", x"60", x"60", x"60", x"60", x"7E"),

	12	=>	(x"00", x"63", x"77", x"7F", x"7F", x"6B", x"63", x"63"),

	13	=>	(x"00", x"66", x"66", x"76", x"7E", x"6E", x"66", x"66"),

	14	=>	(x"00", x"3C", x"66", x"66", x"66", x"66", x"66", x"3C"),

	15	=>	(x"00", x"7C", x"66", x"66", x"7C", x"60", x"60", x"60"),

	16	=>	(x"00", x"3C", x"66", x"66", x"66", x"6E", x"3C", x"0E"),

	17	=>	(x"00", x"7C", x"66", x"66", x"7C", x"6C", x"66", x"66"),

	18	=>	(x"00", x"3E", x"60", x"60", x"3C", x"06", x"06", x"7C"),

	19	=>	(x"00", x"7E", x"18", x"18", x"18", x"18", x"18", x"18"),

	20	=>	(x"00", x"66", x"66", x"66", x"66", x"66", x"66", x"3C"),
            
	21	=>	(x"00", x"66", x"66", x"66", x"66", x"66", x"3C", x"18"),
            
	22	=>	(x"00", x"63", x"63", x"63", x"6B", x"7F", x"77", x"63"),
            
	23	=>	(x"00", x"66", x"66", x"3C", x"18", x"3C", x"66", x"66"),
            
	24	=>	(x"00", x"66", x"66", x"66", x"3C", x"18", x"18", x"18"),
            
	25	=>	(x"00", x"7E", x"06", x"0C", x"18", x"30", x"60", x"7E")

	
	);
	
	signal	index_no, temp_index	:	integer	range 0 to 26;
	signal	counter		:	integer	range 0 to 8	:= 0;
	
	type	states is (IDLE,PROCESS_LETTER);
	signal	state	:	states	:=	IDLE;
	signal	zeros	: STD_LOGIC_VECTOR(2 downto 0) := (others => '0');
	signal	coloumn	: integer range 0 to 79 := 0;
	signal	row		: integer range 0 to 59 := 0;
	
	signal int_pixel_x,int_pixel_y	: STD_LOGIC_VECTOR(9 downto 0) := (others => '0');
	signal in_pixel_x,in_pixel_y	: STD_LOGIC_VECTOR(9 downto 0) := (others => '0');
	signal int_int_pixel_x,int_int_pixel_y	: integer range 0 to 640:= 0;
	signal control	: STD_LOGIC_VECTOR(7 downto 0) := (others	=>	'0');
begin
	process(take_data_enable) begin
		if(rising_edge(take_data_enable)) then
			index_no	<=	to_integer(unsigned(ascii_in)) - 65;
		end if;
	end process;
	LETTER_PLACEMENT:
	process(clk)	begin
		
		if(rising_edge(clk)) then
			case	state	is
				when	IDLE	=>
					temp_index	<=	index_no;
					if(temp_index /= index_no) then
						state	<=	PROCESS_LETTER;
						temp_square	<=	letters_rom(index_no);
					end if;
				when	PROCESS_LETTER	=>
						if(coloumn < 79) then
							displayMap(coloumn,row) <=	temp_square;
							coloumn	<=	coloumn + 1;
						else
							coloumn	<=	0;
							row		<=	row + 1;
						end if;
						state	<=	IDLE;
					
				when	others	=>
					state	<=	IDLE;
			end case;
		end if;
	end process;
	in_pixel_x	<=	pixel_x;
	in_pixel_y	<=	pixel_y;
	BITMAP_READ:
	process(clk) begin
		if(rising_edge(clk)) then

			
			int_pixel_y(9 downto 7)	<= zeros;	 
			int_pixel_y(6 downto 0)	<= in_pixel_y(9 downto 3);
			int_pixel_x(9 downto 7)	<= zeros;	 
			int_pixel_x(6 downto 0)	<= in_pixel_x(9 downto 3);
			int_int_pixel_x	<=	to_integer(unsigned(pixel_x));
			int_int_pixel_y	<=	to_integer(unsigned(pixel_y));
			control <= displayMap(to_integer(unsigned(int_pixel_x)) , to_integer(unsigned(int_pixel_y)))((int_int_pixel_y) mod 8);
			if(control((int_int_pixel_x)mod 8) = '1') then
				bit_enable	<=	'1';
			else
				bit_enable	<=	'0';
			end if;
		end if;
	end process;
	
	

end Behavioral;
