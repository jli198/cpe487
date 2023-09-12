-- library declaration
library IEEE;
use IEEE.std_logic_1164.all;
-- entity
entity my_4t1_mux is
port (D3, D2, D1, D0 : in std_logic;
			SEL            : in std_logic_vector(1 downto 0);
			MX_OUT         : out std_logic);
end my_4t1_mux;
-- architecture
architecture mux4t1 of my_4t1_mux is
begin
	MX_OUT <= D3 when (SEL(1) = '1' and SEL(0) ='1') else
						D2 when (SEL(1) = '1' and SEL(0) ='0') else
						D1 when (SEL(1) = '0' and SEL(0) ='1') else
						D0 when (SEL(1) = '0' and SEL(0) ='0') else
						'0';
end mux4t1;