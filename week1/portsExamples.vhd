entity example is
port (
	a,b : in std_logic := '0';
	c : in integer := 15;
	x,y : out std_logic;
	z : out std_logic_vector (7 down 0);
end entity example;

architecture exarcl of example is
signal s1, s2: std_logic; signal k: integer;
Begin
	s1 <= a and b; -- read in ports
	y <= s1 nor a; -- assign out ports
	q <= c + 3; -- assign buffer port
	k <= q - 1; -- read buffer port
end architecture exarcl;