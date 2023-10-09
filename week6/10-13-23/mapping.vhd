-- library declaration
library IEEE;
use IEEE.std_logic_1164.all;
-- entity
entity my_compare is
	Port ( A_IN : in std_logic_vector(2 downto 0);
			 ( B_IN : in std_logic_vector(2 downto 0);
				 EQ_OUT : out std_logic);
end my_compare;
-- architecture
architecture ckt2 of my_compare is
	component big_xnor is
		Port ( A,B : in std_logic;
						 F : out std_logic);
	end component;

	component big_and3 is
		Port ( A,B,C : in std_logic;
							 F : out std_logic);
	end component;
	signal p1_out,p2_out,p3_out : std_logic;

begin
	x1: big_xnor port map (A_IN(2), B_IN(2), p1_out);
	x2: big_xnor port map (A_IN(1), B_IN(2), p2_out);
	x3: big_xnor port map (A_IN(0), B_IN(0), p3_out);
	a1: big_and3 port map (p1_out, p2_out, p3_out, EQ_OUT);
end ckt2;