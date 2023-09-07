entity nand2 is
port(a,b: in bit;
  z: out bit);
end entity nand2;

architecture ngate of nand2 is
begin
  z <= not(a and b) after 5 ns;
end architecture ngate;