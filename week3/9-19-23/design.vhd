-- library declaration
library IEEE;
use IEEE.std_logic_1164.all;
-- entity
entity multiplexer8 is
	port(d : in std_logic_vector(7 downto 0);
    sel : in std_logic_vector(2 downto 0);
    Y : out std_logic);
end multiplexer8;
-- architecture
architecture mux8 of multiplexer8 is
begin
	m8: process(SEL) is
    begin
    	if (SEL="111") then
        	Y <= D(7);
        elsif (SEL="110") then
          Y <= D(6);
        elsif (SEL="101") then
        	Y <= D(5);
        elsif (SEL="100") then
        	Y <= D(4);
        elsif (SEL="011") then
        	Y <= D(3);
        elsif (SEL="010") then
        	Y <= D(2);
        elsif (SEL="001") then
        	Y <= D(1);
        elsif (SEL="000") then
        	Y <= D(0);
        end if;
   end process m8;
end mux8;
