library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity debouncer is
    Port ( clk_in : in STD_LOGIC;
           button : in STD_LOGIC;
           output : out STD_LOGIC);
end debouncer;

architecture Behavioral of debouncer is
	
	constant	debounce_limit:	integer	:=	5_500_000;
	
	type		states	is	(ZERO_TO_ONE,PUSH_TOGGLE,STABLE_BUTTON,RELEASE_TOGGLE);
	signal		state	:	states	:=	ZERO_TO_ONE;
	
	signal		temp	:	STD_LOGIC:=	'0';
	signal		temp_out:	STD_LOGIC:=	'0';
	signal		counter	:	integer range 0 to integer'high	:=	0;
	
begin
	process(clk_in)
	begin
		if(rising_edge(clk_in)) then
			case	state	is
				when	ZERO_TO_ONE	=>
					temp	<=	button;
					counter	<=	0;
					if(temp /= button) then
						state	<=	PUSH_TOGGLE;
						temp_out	<=	not temp_out;
					end if;
				when	PUSH_TOGGLE =>
					temp	<=	button;
					if(temp /= button and counter < debounce_limit) then
						counter <=	0;
					elsif(counter > debounce_limit) then
						state	<=	STABLE_BUTTON;
					else
						counter	<=	counter + 1;
					end if;
				when	STABLE_BUTTON =>
					temp	<=	button;
					if(temp /=	button) then
						state	<=	RELEASE_TOGGLE;
						counter	<=	0;
					end if;
				when	RELEASE_TOGGLE =>
					temp	<=	button;
					
					if(temp /= button and counter < debounce_limit) then
						counter <=	0;
					elsif(counter > debounce_limit) then
						state	<=	ZERO_TO_ONE;
					else
						counter	<=	counter + 1;
					end if;
				when others	=>
					state	<=	ZERO_TO_ONE;
			end case;
		end if;
	end process;
	output	<=	temp_out;

end Behavioral;
