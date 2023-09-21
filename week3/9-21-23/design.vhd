-- Code your design here
library IEEE;
use IEEE.std_logic_1164.all;
entity logic is
	port(A,B,C : in std_logic;
	Fout : out std_logic);
end logic;

architecture classdemo of logic is
	signal ABC : out std_logic_vector(2 downto 0);
    begin
    ABC <= A & B & C;
    cd: process(ABC) is
    	begin
        case(ABC) is
        	when "1--" => Fout <= '1';
            when "011" => Fout <= '1';
            when others => Fout <= '0';
        end case;
    end process cd;
end classdemo;