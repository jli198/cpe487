signal abc: std_logic_vector (1 to 5);
signal xx, yy: std_logic;

abc <="01001"; -- string literal
abc <=('0','1','0','0','1'); -- positional

abc <=(2=>'1', 5=>'1', others =>'0') -- named

abc <=(others => '0'); -- sets all bits to '0'

abc <=(1=> xx, 4=>'0', others => yy); -- other signals