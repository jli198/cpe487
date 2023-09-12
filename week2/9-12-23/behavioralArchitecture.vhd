-- library declaration
library IEEE
use IEEE.std_logic_1164.all;
-- entity
entity my_xor is
port ( A,B : in std_logic;
			 F   : out std_logic);
end my_xor;
-- architecture
architecture behav of my_xor is
begin
	xor_proc: process(A,B) is
	begin
		F <= A XOR B;
	end process xor_proc;
end behav;