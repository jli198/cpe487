-- library declaration
library IEEE;
use IEEE.std_logic_1164.all;
-- entity
entity reg8 is
	Port ( REG_IN : in std_logic_vector(7 downto 0);
				 LD_CLK : in std_logic;
				 REG_OUT : out std_logic_vector(7 downto 0));
end reg8;
-- architecture
architecture reg8 of reg8 is
begin
	reg: process(CLK)
	begin
		if (rising_edge(CLK)) then
			if (LD = '1') then
				REG_OUT <= REG_IN;
			end if;
		end if;
	end process;
end reg8;