-- Model of simple D Flip-Flop
-- library declaration
library IEEE;
use IEEE.std_logic_1164.all;
-- entity
entity d_ff is
	port ( D, CLK : in std_logic;
				 Q : out std_logic);
end d_ff;
-- architecture
architecture my_d_ff of d_ff is
begin
	dff: process(CLK)
	begin
			if (rising_edge(CLK)) then
-- or if (CLK'event and CLK='1') then
				Q <= D;
		  end if;
	end process dff;
end my_d_ff;