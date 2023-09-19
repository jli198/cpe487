-- library declaration
library IEEE;
use IEEE.std_logic_1164.all; -- basic IEEE library
-- entity
entity testbench is
end testbench; 
-- architecture
architecture tb of testbench is
	component multiplexer8
    port(d : in std_logic_vector(7 downto 0);
    sel : in std_logic_vector(2 downto 0);
    Y : out std_logic);
  end component multiplexer8;
  signal data : std_logic_vector(7 downto 0);
  signal selekt : std_logic_vector (2 downto 0);
  signal why : std_logic;
begin
	quiz1tb: multiplexer8 port map (data, selekt, why);
    testing: process is
    begin
    	data <= "11111111";
      selekt <= "111";
      wait for 1 ns;
        
      assert false;
      wait;
      end process testing;
end tb;
