type data_16 is array (15 downto 0) of std_logic;
type reg_file is array (31 downto 0) of data_16;
signal abc: reg_file;
-- note that: abc (30) is of type data_16
-- whereas: abc (30) (5) is of type std_logic

type row_4 is array (1 to 4) of integer;
type matrix_4x4 is array (1 to 4) of row_4;