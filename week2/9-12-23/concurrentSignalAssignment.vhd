-- library declaration
library IEEE;
use IEEE.std_logic_1164.all;

-- entity
entity my_circuit is
port ( A_1,A_2,B_1,B_2,D_1 : in std_logic;
			 E_out                 out std_logic);
end my_circuit;

-- architecture
architecture my_circuit_arc of my_circuit is
	signal A_out, B_out, C_out : std_logic;
begin
	A_out <= A_1 and A_2
	B_out <= B_1 or B_2
	C_out <= (not D_1) and B_2;
	E_out <= A_out or B_out or C_out;
end my_circuit_arc;