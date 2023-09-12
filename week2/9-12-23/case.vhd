-- library declaration
library IEEE;
use IEEE.std_logic_1164.all;
-- entity
entity my_example is
port (A,B,C : in std_logic;
			F_OUT : out std_logic);
end my_example;
-- architecture
architecture my_soln_exam of my_example is
	signal ABC : std_logic_vector(2 downto 0);
begin
	ABC <= A & B & C; -- group signals for case statement
	my_proc: process (ABC)
	begin
		case (ABC) is
		when "100" => F_OUT <= '1';
		when "011" => F_OUT <= '1';
		when "111" => F_OUT <= '0';
		when others => F_OUT <= '0';
		end case;
	end process my_proc;
end my_soln_exam;