library IEEE;
use IEEE.std_logic_1164.all;

entity my_parity_chk is
Port(input : in std_logic_vector(3 downto 0);
     output : out std_logic);
end my_parity_chk;

architecture arch of my_parity_chk is
	component gen_parity_check is
    	generic(N : positive);
        port (X : in std_logic_vector(N-1 downto 0);
        Y : out std_logic);
    end component;
    
begin
	cp1: gen_parity_check generic map (4) port map (input, output);
end arch;