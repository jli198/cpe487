architecture ckt1 of my_compare is
-- XNOR Gate
component big_xnor is
	Port ( A,B : in std_logic;
					 F : out std_logic);
end component;

-- 3-input AND gate
component big_and3 is
	Port ( A,B,C : in std_logic;
						 F : out std_logic);
end component;