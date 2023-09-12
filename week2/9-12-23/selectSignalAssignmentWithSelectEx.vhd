-- library declaration
library IEEE;
use IEEE.std_logic_1164.all;
-- entity
entity my_4t1_mux is
port (D3,D2,D1,D0 : in std_logic;
			SEL         : in std_logic_vector(1 down to 0);
			MX_OUT      : out std_logic);
end my_4t1_mux;
-- architecture
architecture mux4t1_2 of my_4t1_mux is
begin
with SEL select
	MX_OUT <= D3 when "11",
						D2 when "10",
						D1 when "01",
						D0 when "00",
						'0' when others;
end mux4t1_2;