

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity top_letter_display is
    Port ( clk : in STD_LOGIC;
           rx_in : in STD_LOGIC;
           R,G,B : out STD_LOGIC;
		   LED	 : out STD_LOGIC_VECTOR(7 downto 0);
           h_sync_out,v_sync_out : out STD_LOGIC);
end top_letter_display;

architecture Behavioral of top_letter_display is
	component vga_control is
		Port ( clk,reset : in STD_LOGIC;
			   pixel_x_out, pixel_y_out : out STD_LOGIC_VECTOR (9 downto 0);
			   h_sync_out, v_sync_out, video_out : out STD_LOGIC);
	end component;
	
	component black_white_enable is
		Port ( clk : in STD_LOGIC;
			   enable : in STD_LOGIC;
			   R,G,B : out STD_LOGIC);
	end component;

	component rom_alphabet_chars is
		Port ( ascii_in : in STD_LOGIC_VECTOR(7 downto 0);
			   clk : in STD_LOGIC;
			   take_data_enable	: in STD_LOGIC;
			   pixel_x,pixel_y : in STD_LOGIC_VECTOR (9 downto 0);
			   bit_enable : out STD_LOGIC);
	end component;
	
	--component display_bitmap is
	--	Port ( clk : in STD_LOGIC;
	--		   letter_in : in STD_LOGIC_VECTOR (63 downto 0);
	--		   pixel_x,pixel_y : in STD_LOGIC_VECTOR (9 downto 0);
	--		   white_out : out STD_LOGIC);
	--end component;
	
	component rx is
		Port ( data_in : in STD_LOGIC;
			   clk : in STD_LOGIC;
			   data_receive_flag : out STD_LOGIC;
			   data_out : out STD_LOGIC_VECTOR (7 downto 0));
	end component;
	
	component fifo_32_8_bit is
		Port (
			clk, w_en, r_en : in STD_LOGIC;
			data_in : in STD_LOGIC_VECTOR(7 downto 0);
			full, empty : out STD_LOGIC;
			data_out : out STD_LOGIC_VECTOR(7 downto 0)
		);
	end component;

	signal	fifo_w_enable,	fifo_r_enable,	fifo_empty_f,	fifo_full_f:	STD_LOGIC:=	'0';
	signal	fifo_data_input:	STD_LOGIC_VECTOR(7 downto 0) := (others => '0');
	signal	letter_hex_value:	STD_LOGIC_VECTOR(7 downto 0) := (others	=> '0');
	
	signal	letter_bitmap:	STD_LOGIC_VECTOR(63 downto 0);
	
	signal	pixel_x_inner,pixel_y_inner :  STD_LOGIC_VECTOR (9 downto 0);
	
	signal	pixel_enable:	STD_LOGIC;
	
	signal	bos:	STD_LOGIC;
	
	type	states is (IDLE,SEND);
	signal	state	:	states	:=	IDLE;
	
	signal 	counter :	integer	range 0 to 10:= 0;
	signal	enable	:	STD_LOGIC := '0';
begin


	uart_rx_data_in:
	rx	 port map(
		data_in				=>	rx_in,
		clk					=>	clk,
		data_receive_flag	=>	fifo_w_enable,
		data_out			=>	fifo_data_input
	);
	
	fifo_letter_input:
	fifo_32_8_bit	port map(
		clk					=>	clk,
		w_en				=>	fifo_w_enable,
		r_en				=>	fifo_r_enable,
		data_in				=>	fifo_data_input,
		full				=>	fifo_full_f,
		empty				=>	fifo_empty_f,
		data_out			=>	letter_hex_value
		
	);
	
	hex_to_bitmap:
	rom_alphabet_chars	port map(
		ascii_in			=>	letter_hex_value,
		clk					=>	clk,
		take_data_enable	=>	fifo_r_enable,
		pixel_x				=>	pixel_x_inner,
		pixel_y				=>	pixel_y_inner,
		bit_enable			=>	enable
	);
	
	--display_output_signal:
	--display_bitmap	port map(
	--	clk					=>	clk,
	--	letter_in			=>	letter_bitmap,
	--	pixel_x				=>	pixel_x_inner,
	--	pixel_y				=>	pixel_y_inner,
	--	white_out			=>	pixel_enable
	--);
	
	R_G_B_out:	
	black_white_enable	port map(
		clk					=>	clk,
		enable				=>	enable,
		R					=>	R,
		G					=>	G,
		B					=>	B
	);
	VGA_control_unit:
	vga_control	port map(
		clk					=>	clk,
		reset				=>	'0',
		pixel_x_out			=>	pixel_x_inner,
		pixel_y_out			=>	pixel_y_inner,
		h_sync_out			=>	h_sync_out,
		v_sync_out			=>	v_sync_out,
		video_out			=>	bos
	);


	process(clk) begin
		if(rising_edge(clk)) then
			case state	is
				when	IDLE	=>
					if(fifo_empty_f = '0') then 
						fifo_r_enable	<=	'1';
						state			<=	SEND;
						
					end if;
				when	SEND	=>
					LED <= letter_hex_value;
					fifo_r_enable	<=	'0';
					if(counter < 10) then 
						counter <= counter + 1;
					else
						counter <= 0;
						state	<= IDLE;
					end if;
				when	others	=>
					state	<= IDLE;
			end case;
		end if;
	end process;
end Behavioral;
