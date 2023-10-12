-- full encoded appraoch
entity my_fsm4 is
	port ( X, CLK, RESET : in std_logic;
				 Y : out std_logic_vector(1 downto 0);
				 Z1, Z2 : out std_logic);
end my_fsm4;
-- one hot encoding approach
entity my_fsm4 is
	port ( X, CLK, RESET : in std_logic;
				 Y : out std_logic_vector(1 downto 0);
				 Z1, Z2 : out std_logic);
end my_fsm4;

-- approach for enumeration types
type state_type is (ST0,ST1,ST2,ST3);
signal PS,NS : state_type;
-- approach used for explicitly specifying state bit patterns
type state_type is (ST0,ST1,ST2,ST3);
attribute ENUM_ENCODING : STRING;
attribute ENUM_ENCODING of state_type type is "1000 0100 0010 0001";
signal PS,NS : state_type;

-- fake full encoded approach
with PS select
	Y <= "00" when ST0,
			 "01" when ST1,
			 "10" when ST2,
			 "11" when ST3,
			 "00" when others;
end fsm4;

-- one-hot encoded approach
with PS select
	Y <= "1000" when ST0,
			 "0100" when ST1,
			 "0010" when ST2,
			 "0001" when ST3,
			 "1000" when others,
end fsm4;