-- library declaration
library IEEE;
use IEEE.std_logic_1164.all;
-- entity
entity my_fsm1 is
	port ( TOG_EN : in std_logic;
				 CLK,CLR : in std_logic;
				 Z1 : out std_logic);
end my_fsm1;
-- architecture
architecture fsm1 of my_fsm1 is
	type state_type is (ST0,ST1);
	signal PS, NS : state_type;
begin
	sync_proc: process(CLK,NS,CLR)
	begin
		-- take care of asynchronous input
		if (CLR = '1') then
			PS <= ST0;
		elsif (rising_edge(CLK)) then
			PS <= NS;
		end if;
	end process sync_proc;
	comb_proc: process(PS, TOG_EN)
	begin
		Z1 <= '0'; -- pre-assign output
		case PS is
			when ST0 =>  -- items regarding state ST0
				Z1 <= '0'; -- Moore output
				if (TOG_EN = '1') then NS <= ST1;
				else NS <= ST0;
			when ST1 => -- items regarding state ST1
				Z1 <= '1'; -- Moore output
				if (TOG_EN = '1') then NS <= ST0;
				else NS <= ST1;
				end if;
			when others => -- catch-all condition
				Z1 <= '0'; -- arbitrary; it should never
				NS <= ST0; -- make it to these two statements
		end case;
	end process comb_proc;
end fsm1;