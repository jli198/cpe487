-- library declaration
library IEEE;
use IEEE.std_logic_1164.all; -- basic IEEE library
-- entity
entity testbench is
end testbench; 
-- architecture
architecture tb of testbench is
	component dflipflop
    	port(S, R, D, CLK : in std_logic;
    	Q, Qnot : out std_logic);
  	end component dflipflop;
    signal D, Q, Qnot : std_logic;
    signal S : std_logic := '1';
    signal R : std_logic := '1';
    signal CLK : std_logic := '0';
    signal finished : std_logic;
begin
	quiz2tb: dflipflop port map (S, R, D, CLK, Q, Qnot);
    CLK <= not CLK after 10 ns when finished /= '1' else '0';
    testing: process is
    begin
    	--CLK <= not CLK after 10 ns;
        finished <= '0';
    	D <= 'X';
        wait for 11 ns;
        
        D <= '1';
        wait for 21 ns;
        
        D <= '0';
        wait for 21 ns;
        
        S <= '0';
        wait for 1 ns;
        
        S <= '1';
        wait for 1 ns;
        
        R <= '0';
        wait for 1 ns;
        
        finished <= '1';
        assert false;
        wait;
        end process testing;
end tb;
