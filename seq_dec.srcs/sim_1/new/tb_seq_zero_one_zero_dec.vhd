library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity tb_seq_zero_one_zero_dec is
end tb_seq_zero_one_zero_dec;

architecture Behavioral of tb_seq_zero_one_zero_dec is

    -- Component declaration for the Unit Under Test (UUT)
    component seq_zero_one_zero_dec is
       
        Port (
            data_in  : in  std_logic_vector (19 downto 0);
            clk      : in  std_logic;
            seq_counter: inout std_logic_vector(3 downto 0)
        );
    end component;

    -- Signal declarations for the testbench
    signal data_in  : std_logic_vector(19 downto 0);
    signal clk      : std_logic := '0';
    signal seq_counter : std_logic_vector(3 downto 0);
    

    -- Clock generation process
    constant ClockFrequency : integer := 100_000_000;
    constant ClockPeriod    : time := 1000 ms / ClockFrequency;

begin

    -- Instantiate the Unit Under Test (UUT)
    uut: seq_zero_one_zero_dec Port map (
		data_in => data_in,
		clk		=> clk,
		seq_counter	=>	seq_counter
	);
	
	 clk <= not clk after ClockPeriod / 2;
	
	process
    begin
		data_in <= "00000000000000000000";
        wait for ClockPeriod*20;
        data_in <= "10110011100111010101";
        wait for ClockPeriod*20;

        -- Insert test vectors
        data_in <= "00101000111010010100"; -- Example sequence with 0100 pattern
        wait for ClockPeriod*20;

        data_in <= "01010100100100011100"; -- Another example sequence with 0100 pattern
        wait for ClockPeriod*20;

        data_in <= "10010111100000111000"; -- Example with incorrect sequence
        wait for ClockPeriod*20;

        wait;
    end process;

end Behavioral;
