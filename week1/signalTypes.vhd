signal abus: bit_vector (0 to 7); -- 8-bit bus, abus(0) is msb
signal instr: bit_vector (15 downto 0); -- 16-bit bus, instr(15) is msb
signal opcode: bit_vector (6 downto 3); -- 4-bit bus, opcode(6) is msb

opcode <= instr(12 downto 9); -- bit_vector used in assignment statement