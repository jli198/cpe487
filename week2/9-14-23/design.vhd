-- library declaration
library IEEE;
use IEEE.std_logic_1164.all;
-- entity
entity quiz1 is
	port(B,C,D : in std_logic;
    Y : out std_logic);
end quiz1;
-- architecture
architecture q1 of quiz1 is
begin
	Y <= (B or C) and (not(B) or D) and (C or D);
end q1;