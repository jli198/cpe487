-- Description of XNOR function
entity big_xnor is
	Port ( A,B : in std_logic;
					 F : out std_logic);
end big_xnor;

architecture ckt1 of big_xnor is
begin
	F <= not ( (A and (not B)) or ( (not A) and B) );
end ckt1;
-- Desription of 3-input AND function
entity big_and3 is
	Port ( A,B,C : in std_logic;
						 F : out std_logic);
end big_and3;

architecture ckt1 of big_and3 is
begin
	F <= ( A and B and C);
end ckt1;