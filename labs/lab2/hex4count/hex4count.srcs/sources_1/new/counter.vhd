-- counter.vhd --

LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;



ENTITY counter IS
	PORT (
		clk : IN STD_LOGIC;
		count : OUT STD_LOGIC_VECTOR (15 DOWNTO 0); -- NEED REVISE! 16 bits
		--reset : IN std_logic;
		--X : IN std_logic;
		--Y : out std_logic_vector(2 downto 0);
		--Z : out std_logic;
		mpx : OUT STD_LOGIC_VECTOR (2 DOWNTO 0)); -- NEW ONE ADD! send signal to select displays

		  
END counter;

ARCHITECTURE Behavioral OF counter IS
	SIGNAL cnt : STD_LOGIC_VECTOR (41 DOWNTO 0); -- 39-bit counter
	
    signal PS : std_logic_vector(2 downto 0) := "000";
    signal NS : std_logic_vector(2 downto 0);
    signal X : std_logic;
    signal Y : std_logic_vector(2 downto 0);
    signal Z : std_logic;
BEGIN
        X <= cnt(31);
        
        NS(2) <= '1' when (PS(2) = '0' AND PS(1) = '1' AND PS(0) = '1' AND X = '0') OR 
                          (PS(2) = '1' AND PS(1) = '0' AND PS(0) = '0' AND X = '0') else '0';
        NS(1) <= '1' when (PS(2) = '0' AND PS(1) = '0' AND PS(0) = '1' AND X = '1') OR 
                          (PS(2) = '0' AND PS(1) = '1' AND PS(0) = '0' AND X = '0') OR
		                  (PS(2) = '0' AND PS(1) = '1' AND PS(0) = '0' AND X = '1') OR
                          (PS(2) = '1' AND PS(1) = '0' AND PS(0) = '1' AND X = '0') else '0';
        NS(0) <= '0' when (PS(2) = '0' AND PS(1) = '0' AND PS(0) = '0' AND X = '0') OR 
                          (PS(2) = '0' AND PS(1) = '0' AND PS(0) = '1' AND X = '0') OR
                          (PS(2) = '0' AND PS(1) = '0' AND PS(0) = '1' AND X = '1') OR
		                  (PS(2) = '0' AND PS(1) = '1' AND PS(0) = '0' AND X = '1') OR
                          (PS(2) = '0' AND PS(1) = '1' AND PS(0) = '1' AND X = '0') OR
                          (PS(2) = '1' AND PS(1) = '0' AND PS(0) = '1' AND X = '0') else '1';

        Z <= '1' when (PS(2) = '1' AND PS(1) = '0' AND PS(0) = '1' AND X = '0') OR
                  (PS(2) = '1' AND PS(1) = '0' AND PS(0) = '1' AND X = '0') else '0';

    Y <= PS;

	PROCESS (clk)
	BEGIN
		IF clk'EVENT AND clk = '1' THEN -- on rising edge of clock
			IF Z = '0' THEN 
			     cnt <= cnt + 1; -- increment counter
			 END IF;
			 IF Z = '1' THEN		     
			     cnt <= cnt - 1;
			 END IF;
			 PS <= NS;
		END IF;
	END PROCESS;
	count <= cnt (41 DOWNTO 26); -- 16 bits
	mpx <= cnt (19 DOWNTO 17); -- 3 bits
END Behavioral;