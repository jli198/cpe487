-- library declaration
library IEEE;
use IEEE.std_logic_1164.all;
-- entity
entity testbench is
end testbench;
-- architecture
architecture tb of testbench is
  component quiz1
    port(B, C, D : in std_logic;
    Y : out std_logic);
  end component quiz1;
  signal B,C,D,Y : std_logic;
begin
  quiz1tb: quiz1 port map (B => B, C => C, D => D);
  testing: process is
  begin
    B <= 'X';
    C <= 'X';
    D <= 'X';
    wait for 1 ns;

    B <= '0';
    C <= '0';
    D <= '0';
    wait for 1 ns;

    C <= '1';
    wait for 1 ns;

    assert false;
    wait;
    end process testing;
end tb;