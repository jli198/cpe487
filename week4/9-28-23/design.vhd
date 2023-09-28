-- library declaration
library IEEE;
use IEEE.std_logic_1164.all;
-- entity
entity dflipflop is
    port(S, R, D, CLK : in std_logic;
    Q, Qnot : out std_logic);
end dflipflop;
-- architecture
architecture dff of dflipflop is
	signal ff_tmp: std_logic;
begin
    ff: process(S, R, CLK) is
    begin
-- insert your code here
		if (S = '0') then
        	ff_tmp <= '1';
        elsif (R = '0') then
        	ff_tmp <= '0';
        elsif (rising_edge(CLK)) then
        	ff_tmp <= D;
        end if;
   end process ff;
   Q <= ff_tmp;
   Qnot <= not(ff_tmp);
end dff;
