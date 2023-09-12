-- library declaration
library IEEE;
use IEEE.std_logic_1164.all;
-- entity
entity mux_8t1 is
	port ( Data_in : in std_logic_vector(7 downto 0);
				 SEL : in std_logic_vector(2 downto 0);
				 F_CTRL : out std_logic);
end mux_8t1;
-- architecture
architecture mux8_t1_arc of mux_8t1 is
begin
	my_mux: process (Data_in, SEL)
	begin
		if    (SEL = "111") then F_CTRL <= Data_in(7);
		elsif (SEL = "110") then F_CTRL <= Data_in(6);
    elsif (SEL = "101") then F_CTRL <= Data_in(5);
		elsif (SEL = "100") then F_CTRL <= Data_in(4);
		elsif (SEL = "011") then F_CTRL <= Data_in(3);
		elsif (SEL = "010") then F_CTRL <= Data_in(2);
		elsif (SEL = "001") then F_CTRL <= Data_in(1);
		elsif (SEL = "000") then F_CTRL <= Data_in(0);
		else F_CTRL <= '0';
		end if;
	end process my_mux;
end mux8_t1_arc;