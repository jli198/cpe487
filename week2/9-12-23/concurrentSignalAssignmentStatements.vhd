-- library declaration
library IEEE;
use IEEE.std_logic_1164.all;
-- entity
entity my_nand3 is
	port ( A,B,C : in std_logic;
				 F     : out std_logic);
end my_nand3;
-- architecture
architecture exa_nand3 of my_nand3 is
begin
	F <= NOT(A AND B AND C);
end exa_nand3;