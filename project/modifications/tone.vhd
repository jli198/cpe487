LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;

-- Generates a 16-bit signed triangle wave sequence at a sampling rate determined
-- by input clk and with a frequency of (clk*pitch)/65,536
ENTITY tone IS
	PORT (
		clk : IN STD_LOGIC; -- 48.8 kHz audio sampling clock
		pitch : IN UNSIGNED (13 DOWNTO 0); -- frequency (in units of 0.745 Hz)
	  data : OUT SIGNED (31 DOWNTO 0); -- signed triangle wave out
	  wspeed : IN UNSIGNED (7 DOWNTO 0);
	  SW8 : IN STD_LOGIC;
    SW9 : IN STD_LOGIC;
    SW10 : IN STD_LOGIC;
    high_pass: IN unsigned  (7 DOWNTO 0) := "00111111";
    low_pass: IN unsigned  (7 DOWNTO 0) := "00001111";
	bt_square: IN STD_LOGIC;
	bt_lowpass: IN STD_LOGIC;
	bt_highpass: IN STD_LOGIC;
	bt_reset_high: IN STD_LOGIC;
	bt_reset_low: IN STD_LOGIC);
	
END tone;

ARCHITECTURE Behavioral OF tone IS
	SIGNAL count : unsigned (31 DOWNTO 0); -- represents current phase of waveform default 25 to 0
	SIGNAL quad : std_logic_vector (1 DOWNTO 0); -- current quadrant of phase
	SIGNAL index : signed (31 DOWNTO 0); -- index into current quadrant
	SIGNAL triangle_wave : signed (31 DOWNTO 0);
	SIGNAL triangle_wave_lowpass : signed (31 DOWNTO 0);
	SIGNAL triangle_wave_highpass : signed (31 DOWNTO 0);
	SIGNAL square_wave : signed (31 DOWNTO 0);
	SIGNAL square_wave_lowpass : signed (31 DOWNTO 0);
	SIGNAL square_wave_highpass : signed (31 DOWNTO 0);
BEGIN
	-- This process adds "pitch" to the current phase every sampling period. Generates
	-- an unsigned 16-bit sawtooth waveform. Frequency is determined by pitch. For
	-- example when pitch=1, then frequency will be 0.745 Hz. When pitch=16,384, frequency
	-- will be 12.2 kHz.
	cnt_pr : PROCESS
	BEGIN
		WAIT UNTIL rising_edge(clk);
--		IF SW8 = '1' AND SW9 = '1' THEN
--		      IF (wspeed > "00001111" AND wspeed < "00111111") THEN
--		          count <= count + pitch;
--		      ELSE
--		          count <= "0000000000000000";
--		      END IF;
--		 END IF;
		IF wspeed > "00001111" AND SW8 = '1' THEN -- 00001111
		      count <= "00000000000000000000000000000000";
		      IF wspeed < "00111111" AND SW9 = '1' THEN
		          count <= count + pitch;
		      END IF;
		ELSIF wspeed < "00111111" AND SW9 = '1' THEN -- 00111111
		      count <= "00000000000000000000000000000000";
		      IF wspeed > "00001111" AND SW8 = '1' THEN
		          count <= count + pitch;
		      END IF;
		 ELSE
		      count <= count + pitch;
		 END IF;
	END PROCESS;
	quad <= std_logic_vector (count (15 DOWNTO 14)); -- splits count range into 4 phases
	index <= signed ("00" & count (29 DOWNTO 0)); -- 14-bit index into the current phase
	-- This select statement converts an unsigned 16-bit sawtooth that ranges from 65,535
	-- into a signed 12-bit triangle wave that ranges from -16,383 to +16,383
	WITH quad SELECT
	triangle_wave <= index WHEN "00", -- 1st quadrant
	        1073741823 - index WHEN "01", -- 2nd quadrant
	        0 - index WHEN "10", -- 3rd quadrant
	        index - 1073741823 WHEN OTHERS; -- 4th quadrant
    WITH quad SELECT
	square_wave <= "00111111111111111111111111111111" WHEN "00", -- 1st quadrant
	         "11000000000000000000000000000001" WHEN "01", -- 2nd quadrant
	        "00111111111111111111111111111111" WHEN "10", -- 3rd quadrant
	        "11000000000000000000000000000001" WHEN OTHERS; -- 4th quadrant
	WITH quad SELECT
	triangle_wave_lowpass <= "00000000000000000000000000000000" WHEN "00", -- 1st quadrant
	        "00000000000000000000000000000000" WHEN "01", -- 2nd quadrant
	        0 - index WHEN "10", -- 3rd quadrant
	        index - 1073741823 WHEN OTHERS; -- 4th quadrant
	WITH quad SELECT
	triangle_wave_highpass <= index WHEN "00", -- 1st quadrant
	        1073741823 - index WHEN "01", -- 2nd quadrant
	        "00000000000000000000000000000000" WHEN "10", -- 3rd quadrant
	        "00000000000000000000000000000000" WHEN OTHERS; -- 4th quadrant
	WITH quad SELECT
	square_wave <= "00111111111111111111111111111111" WHEN "00", -- 1st quadrant
	         "11000000000000000000000000000001" WHEN "01", -- 2nd quadrant
	        "00111111111111111111111111111111" WHEN "10", -- 3rd quadrant
	        "11000000000000000000000000000001" WHEN OTHERS; -- 4th quadrant
	WITH quad SELECT
	square_wave_lowpass <= "00000000000000000000000000000000" WHEN "00", -- 1st quadrant
	         "11000000000000000000000000000001" WHEN "01", -- 2nd quadrant
	        "00000000000000000000000000000000" WHEN "10", -- 3rd quadrant
	        "11000000000000000000000000000001" WHEN OTHERS; -- 4th quadrant
	WITH quad SELECT
	square_wave_highpass <= "00111111111111111111111111111111" WHEN "00", -- 1st quadrant
	         "00000000000000000000000000000000" WHEN "01", -- 2nd quadrant
	        "00111111111111111111111111111111" WHEN "10", -- 3rd quadrant
	        "00000000000000000000000000000000" WHEN OTHERS; -- 4th quadrant 
	button: PROCESS(square_wave, square_wave_lowpass, square_wave_highpass, triangle_wave)
--	button: PROCESS(square_wave, triangle_wave)
	BEGIN
	   IF bt_square = '1' THEN
           IF bt_lowpass = '1' THEN
               data <= square_wave_lowpass; -- cut off high frequency
               --data <= square_wave if square_wave = '1100000000000001' else '0000000000000000';
           ELSIF bt_highpass = '1' THEN
               data <= square_wave_highpass; -- cut off low frequency
           ELSE
               data <= square_wave;
           END IF;
       ELSE
           IF bt_lowpass = '1' THEN
               data <= triangle_wave_lowpass; -- cut off high frequency
           ELSIF bt_highpass = '1' THEN
               data <= triangle_wave_highpass; -- cut off low frequency
           ELSE
               data <= triangle_wave;
           END IF;
       END IF;
--        IF bt_square = '1' THEN
--               data <= square_wave;
--        ELSE
--                data <= triangle_wave;
--        END IF; 
    END PROCESS;
END Behavioral;