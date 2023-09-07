library IEEE;
use IEEE.std_logic_1164.all;

entity half_adder is
	port( a,b: in std_logic;
		sum, cout: out std_logic);
end entity half_adder

signal addr: std_logic_vector (0 to 7)
signal dataout: std_logic