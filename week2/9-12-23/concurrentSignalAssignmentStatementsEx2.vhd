-- library declaration
library IEEE;
use IEEE.std_logic_1164.all;
-- entity
entity my_ckt_f3 is
port ( L,M,N : in std_logic;
			 F3    : out std_logic);
end my_ckt_f3;
-- architecture
architecture f3_2 of my_ckt_3 is
begin
F3<=((NOT L) AND (NOT M) AND N) OR (L AND M);
end f3_2;