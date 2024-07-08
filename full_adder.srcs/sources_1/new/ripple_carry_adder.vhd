

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity ripple_carry_adder is
	generic(
		bit_width	:integer	:=	4
	);
    Port ( A_in,B_in: in STD_LOGIC_VECTOR (bit_width-1 downto 0);
		   C_in_zero: in STD_LOGIC;
           S_out : out STD_LOGIC_VECTOR (bit_width-1 downto 0);
           C_out_f : out STD_LOGIC);
end ripple_carry_adder;

architecture Behavioral of ripple_carry_adder is
	component full_adder is
		Port ( A,B,C_in : in STD_LOGIC;
			   S,C_out : inout STD_LOGIC);
	end component;
	
	signal	C		:STD_LOGIC_VECTOR(bit_width-1 downto 0);
	signal	S_temp	:STD_LOGIC_VECTOR(bit_width-1 downto 0);
	
begin
	adder_0:	full_adder	port map(A_in(0),B_in(0),C_in_zero,S_temp(0),C(0));
	
	ripple_carry_adder_gen:	for	i in 1 to bit_width-1 generate
		adder:	full_adder	port map(
			A		=>	A_in(i),
			B		=>	B_in(i),
			C_in	=>	C(i-1),
			S		=>	S_temp(i),
			C_out	=>	C(i)
		);
	end generate ripple_carry_adder_gen;
	S_out	<=	S_temp;
	C_out_f	<=	C(bit_width-1);

end Behavioral;
