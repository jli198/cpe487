-- Interface description of 3-bit comparator
entity my_compare is
	Port ( A_IN : in std_logic_vector(2 downto 0);
				 B_IN : in std_logic_vector(2 downto 0);
				 EQ_OUT : out std_logic);
end my_compare