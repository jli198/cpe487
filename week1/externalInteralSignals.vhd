entity compare is
port(x,y: in bit_vector(1 downto 0);
	eq: out bit);
end entity compare;

architecture cmp_alt of compare is
signal a1, a0: bit;
begin
	a1 <= x(1) xor y(1) after 2 ns;
	a0 <= x(0) xor y(0) after 2 ns;
	eq <= a0 nor a1 after 3 ns;
end architecture cmp_alth