-- library declaration
library IEEE;
use IEEE.std_logic_1164.all;
-- entity
entity my_ckt_f3 is
port ( L,M,N : in std_logic;
			 F3    : out std_logic);
end my_ckt_f3
-- architecture
architecture f3_1 of my_ckt_f3 is
	signal A1, A2 : std_logic; -- intermediate signals
begin
	A1 <= ((NOT L) AND (NOT M) AND N);
	A2 <= L AND M;
	F3 <= A1 OR A2;
end f3_1;