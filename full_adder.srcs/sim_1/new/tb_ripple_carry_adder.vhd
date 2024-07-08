

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity tb_ripple_carry_adder is
--  Port ( );
end tb_ripple_carry_adder;

architecture Behavioral of tb_ripple_carry_adder is
	component ripple_carry_adder is
		Port ( A_in,B_in: in STD_LOGIC_VECTOR (3 downto 0);
			   C_in_zero: in STD_LOGIC;
			   S_out : out STD_LOGIC_VECTOR (3 downto 0);
			   C_out_f : out STD_LOGIC);
	end component;
	
	signal	A_in,B_in: STD_LOGIC_VECTOR (3 downto 0) := (others	=>	'0');
	signal	C_in_zero: STD_LOGIC	:= '0';
    signal	S_out :  STD_LOGIC_VECTOR (3 downto 0);
    signal	C_out_f :  STD_LOGIC;
	
begin
	uut:	ripple_carry_adder	port map(A_in,B_in,C_in_zero,S_out,C_out_f);
	process
	begin
		wait for 100ns;
		A_in <= "1011";
		B_in <= "0111";
		C_in_zero <= '1';

		wait for 100ns;
		A_in <= "0101";
		B_in <= "0010";
		C_in_zero <= '1';

		wait for 100ns;
		A_in <= "0010";
		B_in <= "1011";
		C_in_zero <= '1';

		wait for 100ns;
		A_in <= "1101";
		B_in <= "0111";
		C_in_zero <= '1';

		wait for 100ns;
		A_in <= "0111";
		B_in <= "0001";
		C_in_zero <= '1';

		wait for 100ns;
		A_in <= "0001";
		B_in <= "1110";
		C_in_zero <= '0';

		wait for 100ns;
		A_in <= "1110";
		B_in <= "1100";
		C_in_zero <= '0';

		wait for 100ns;
		A_in <= "0110";
		B_in <= "1001";
		C_in_zero <= '0';

		wait for 100ns;
		A_in <= "1010";
		B_in <= "1110";
		C_in_zero <= '0';

		wait for 100ns;
		A_in <= "1111";
		B_in <= "1010";
		C_in_zero <= '0';

		wait for 100ns;
		A_in <= "1010";
		B_in <= "1001";
		C_in_zero <= '1';

		wait for 100ns;
		A_in <= "1000";
		B_in <= "1111";
		C_in_zero <= '0';

		wait for 100ns;
		A_in <= "0000";
		B_in <= "1001";
		C_in_zero <= '1';

		wait for 100ns;
		A_in <= "1011";
		B_in <= "0000";
		C_in_zero <= '0';

		wait for 100ns;
		A_in <= "1111";
		B_in <= "0011";
		C_in_zero <= '1';

		wait for 100ns;
		A_in <= "0100";
		B_in <= "0110";
		C_in_zero <= '0';
		
		wait for 100ns;
		A_in <= "1011";
		B_in <= "0100";
		C_in_zero <= '0';
		
		wait for 100ns;
		A_in <= "1111";
		B_in <= "1101";
		C_in_zero <= '1';
		
		wait for 100ns;
		A_in <= "0000";
		B_in <= "1111";
		C_in_zero <= '1';

		wait;
	end process;

	
end Behavioral;
