-- library declaration
library IEEE;
use IEEE.std_logic_1164.all;
-- entity
entity my_system is
port ( A,B,C : in std_logic;
			 F,Q   : out std_logic);
end my_system;
-- architecture
architecture behav of my_system is
	signal A1 : std_logic;
begin
	some_proc: process(A,B,C) is
		variable x,y : integer;
	begin
		x:=74;
		y:=67;
		A1 <= A and B and C;
		if x>y then
			F <= A1 or B;
		end if;
	end process some_proc;
	-- are outside process body
	Q <= not A;
end behav;