
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
entity full_adder is
    Port ( A,B,C_in : in STD_LOGIC;
           S,C_out : out STD_LOGIC);
end full_adder;

architecture Behavioral of full_adder is
	signal	A_xor_B:		STD_LOGIC;
	signal	A_and_B:		STD_LOGIC;
	signal	A_xor_B_and_C:	STD_LOGIC;
begin
	A_xor_B			<=		A xor B							;	
	A_and_B			<=		A and B						;
	A_xor_B_and_C	<=		A_xor_B and C_in			;
	S				<=		A_xor_B	xor C_in				;
	C_out			<=		A_xor_B_and_C or A_and_B	;

end Behavioral;
