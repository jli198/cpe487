-- library declaration
library IEEE;
use IEEE.std_logic_1164.all;
-- entity
entity my_ex is
port (A,B,C : in std_logic;
			F_out : out std_logic);
end my_ex;
-- architecture
architecture silly_example of my_ex is
begin
	proc1: process(A,B,C) is
	begin
		if (A = '1' and B = '0' and C = '0') then
			F_OUT <= '1';
		elsif (B = '1' and C = '1') then
			F_OUT <= '1';
		else
			F_OUT <= '0';
		end if;
	end process proc1;
end silly_example;