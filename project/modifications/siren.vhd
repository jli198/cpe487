library IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;

ENTITY siren IS
	PORT (
		clk_50MHz : IN STD_LOGIC; -- system clock (50 MHz)
		dac_MCLK : OUT STD_LOGIC; -- outputs to PMODI2L DAC
		dac_LRCK : OUT STD_LOGIC;
		dac_SCLK : OUT STD_LOGIC;
		dac_SDIN : OUT STD_LOGIC;
		bt_square : IN STD_LOGIC;
		bt_lowpass : IN STD_LOGIC;
		bt_highpass : IN STD_LOGIC;
		bt_reset_high: IN STD_LOGIC;
	    bt_reset_low: IN STD_LOGIC;
        SW0 : IN STD_LOGIC;
        SW1 : IN STD_LOGIC;
        SW2 : IN STD_LOGIC;
        SW3 : IN STD_LOGIC;
        SW4 : IN STD_LOGIC;
        SW5 : IN STD_LOGIC;
        SW6 : IN STD_LOGIC;
        SW7 : IN STD_LOGIC;
        SW8 : IN STD_LOGIC;
        SW9 : IN STD_LOGIC;
        SW10 : IN STD_LOGIC;
        SEG7_anode : OUT STD_LOGIC_VECTOR (7 DOWNTO 0); -- anodes of eight 7-seg displays
		SEG7_seg : OUT STD_LOGIC_VECTOR (6 DOWNTO 0); -- common segments of 7-seg displays
        KB_col : OUT STD_LOGIC_VECTOR (4 DOWNTO 1); -- keypad column pins
	    KB_row : IN STD_LOGIC_VECTOR (4 DOWNTO 1) -- keypad row pins
	);
END siren;

ARCHITECTURE Behavioral OF siren IS
	CONSTANT lo_tone : UNSIGNED (13 DOWNTO 0) := to_unsigned (344, 14); -- lower limit of siren = 256 Hz
	CONSTANT hi_tone : UNSIGNED (13 DOWNTO 0) := to_unsigned (687, 14); -- upper limit of siren = 512 Hz
	SIGNAL wail_speed : UNSIGNED (7 DOWNTO 0) := to_unsigned (8, 8); -- sets wailing speed
	COMPONENT dac_if IS
		PORT (
			SCLK : IN STD_LOGIC;
			L_start : IN STD_LOGIC;
			R_start : IN STD_LOGIC;
			L_data : IN signed (31 DOWNTO 0);
			R_data : IN signed (31 DOWNTO 0);
			SDATA : OUT STD_LOGIC
		);
	END COMPONENT;
	COMPONENT wail IS
		PORT (
			lo_pitch : IN UNSIGNED (13 DOWNTO 0);
			hi_pitch : IN UNSIGNED (13 DOWNTO 0);
			wspeed : IN UNSIGNED (7 DOWNTO 0);
			wclk : IN STD_LOGIC;
			audio_clk : IN STD_LOGIC;
			audio_data : OUT SIGNED (31 DOWNTO 0);
			SW8 : IN STD_LOGIC;
            SW9 : IN STD_LOGIC;
            SW10 : IN STD_LOGIC;
            high_pass: IN unsigned  (7 DOWNTO 0);
            low_pass: IN unsigned  (7 DOWNTO 0);
			bt_square : IN STD_LOGIC;
			bt_lowpass: IN STD_LOGIC;
	        bt_highpass: IN STD_LOGIC;
	        bt_reset_high: IN STD_LOGIC;
	        bt_reset_low: IN STD_LOGIC);
		--);
	END COMPONENT;
	COMPONENT keypad IS
		PORT (
			samp_ck : IN STD_LOGIC;
			col : OUT STD_LOGIC_VECTOR (4 DOWNTO 1);
			row : IN STD_LOGIC_VECTOR (4 DOWNTO 1);
			value : OUT STD_LOGIC_VECTOR (3 DOWNTO 0);
			hit : OUT STD_LOGIC
		);
    END COMPONENT;
    COMPONENT leddec IS
		PORT (
			dig : IN STD_LOGIC_VECTOR (2 DOWNTO 0);
			data : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
			anode : OUT STD_LOGIC_VECTOR (7 DOWNTO 0);
			seg : OUT STD_LOGIC_VECTOR (6 DOWNTO 0)
		);
	END COMPONENT;
	SIGNAL tcount : unsigned (19 DOWNTO 0) := (OTHERS => '0'); -- timing counter
	SIGNAL data_L, data_R : SIGNED (31 DOWNTO 0); -- 16-bit signed audio data
	SIGNAL dac_load_L, dac_load_R : STD_LOGIC; -- timing pulses to load DAC shift reg.
	SIGNAL slo_clk, sclk, audio_CLK : STD_LOGIC;
	SIGNAL cnt : std_logic_vector(20 DOWNTO 0); -- counter to generate timing signals
	SIGNAL kp_clk, kp_hit, sm_clk : std_logic;
	SIGNAL kp_value : std_logic_vector (3 DOWNTO 0);
	SIGNAL display : std_logic_vector (31 DOWNTO 0); -- value to be displayed
	SIGNAL led_mpx : STD_LOGIC_VECTOR (2 DOWNTO 0); -- 7-seg multiplexing clock
	SIGNAL nx_acc, acc : std_logic_vector (31 DOWNTO 0); -- accumulated sum
	SIGNAL nx_operand, operand : std_logic_vector (31 DOWNTO 0); -- operand
	TYPE state IS (ENTER_ACC, ACC_RELEASE, START_OP, OP_RELEASE, 
	ENTER_OP, SHOW_RESULT); -- state machine states
	SIGNAL pr_state, nx_state : state; -- present and next states
	SIGNAL hl: std_logic;
	SIGNAL high_pass: unsigned (7 DOWNTO 0);
	SIGNAL low_pass: unsigned (7 DOWNTO 0);
BEGIN
	-- this process sets up a 20 bit binary counter clocked at 50MHz. This is used
	-- to generate all necessary timing signals. dac_load_L and dac_load_R are pulses
	-- sent to dac_if to load parallel data into shift register for serial clocking
	-- out to DAC
	tim_pr : PROCESS
	BEGIN
		WAIT UNTIL rising_edge(clk_50MHz);
		IF (tcount(9 DOWNTO 0) >= X"00F") AND (tcount(9 DOWNTO 0) < X"02E") THEN
			dac_load_L <= '1';
		ELSE
			dac_load_L <= '0';
		END IF;
		IF (tcount(9 DOWNTO 0) >= X"20F") AND (tcount(9 DOWNTO 0) < X"22E") THEN
			dac_load_R <= '1';
		ELSE dac_load_R <= '0';
		END IF;
		tcount <= tcount + 1;
		cnt <= cnt + 1; -- increment counter
	END PROCESS;
	dac_MCLK <= NOT tcount(1); -- DAC master clock (12.5 MHz)
	audio_CLK <= tcount(9); -- audio sampling rate (48.8 kHz)
	dac_LRCK <= audio_CLK; -- also sent to DAC as left/right clock
	sclk <= tcount(4); -- serial data clock (1.56 MHz)
	dac_SCLK <= sclk; -- also sent to DAC as SCLK
	slo_clk <= tcount(19); -- clock to control wailing of tone (47.6 Hz)
	wail_speed(0) <= SW0;
    wail_speed(1) <= SW1;
    wail_speed(2) <= SW2;
    wail_speed(3) <= SW3;
    wail_speed(4) <= SW4;
    wail_speed(5) <= SW5;
    wail_speed(6) <= SW6;
    wail_speed(7) <= SW7;
	dac : dac_if
	PORT MAP(
		SCLK => sclk, -- instantiate parallel to serial DAC interface
		L_start => dac_load_L, 
		R_start => dac_load_R, 
		L_data => data_L, 
		R_data => data_R, 
		SDATA => dac_SDIN 
		);
		w1 : wail
		PORT MAP(
			lo_pitch => lo_tone, -- instantiate wailing siren
			hi_pitch => hi_tone, 
			wspeed => wail_speed, 
			wclk => slo_clk, 
			audio_clk => audio_clk, 
			audio_data => data_L,
			SW8 => SW8, -- low pass
            SW9 => SW9, -- high pass
            SW10 => SW10,
			bt_square => bt_square,
			bt_lowpass => bt_lowpass,
		    bt_highpass => bt_highpass,
		    bt_reset_high => bt_reset_high,
		    bt_reset_low => bt_reset_low,
		    high_pass => high_pass,
		    low_pass => low_pass
		);
		w2 : wail
		PORT MAP(
			lo_pitch => hi_tone, -- instantiate wailing siren
			hi_pitch => lo_tone, 
			wspeed => wail_speed, 
			wclk => slo_clk, 
			audio_clk => audio_clk, 
			audio_data => data_R,
			SW8 => SW8, -- low pass
            SW9 => SW9, -- high pass
            SW10 => SW10,
			bt_square => bt_square,
			bt_lowpass => bt_lowpass,
		    bt_highpass => bt_highpass,
		    bt_reset_high => bt_reset_high,
		    bt_reset_low => bt_reset_low,
		    high_pass => high_pass,
		    low_pass => low_pass
		);
		kp_clk <= cnt(15); -- keypad interrogation clock
	    sm_clk <= cnt(20); -- state machine clock
	    led_mpx <= cnt(19 DOWNTO 17); -- 7-seg multiplexing clock
		kp1 : keypad
	    PORT MAP(
		samp_ck => kp_clk, col => KB_col, 
		row => KB_row, value => kp_value, hit => kp_hit
		);
		led1 : leddec
		PORT MAP(
			dig => led_mpx, data => display, 
			anode => SEG7_anode, seg => SEG7_seg
		);
		sm_ck_pr : PROCESS (bt_reset_high, bt_reset_low, sm_clk) -- state machine clock process
		BEGIN
			IF bt_reset_high = '1' OR bt_reset_low = '1' THEN -- reset to known state
				acc <= X"00000000";
				operand <= X"00000000";
				pr_state <= ENTER_ACC;
			ELSIF rising_edge (sm_clk) THEN -- on rising clock edge
				pr_state <= nx_state; -- update present state
				acc <= nx_acc; -- update accumulator
				operand <= nx_operand; -- update operand
			END IF;
		END PROCESS;
		-- state maching combinatorial process
		-- determines output of state machine and next state
		sm_comb_pr : PROCESS (kp_hit, kp_value, bt_reset_high, bt_reset_low, SW10, acc, operand, pr_state)
		BEGIN
			nx_acc <= acc; -- default values of nx_acc, nx_operand & display
			nx_operand <= operand;
			display <= acc;
			CASE pr_state IS -- depending on present state...
				WHEN ENTER_ACC => -- waiting for next digit in 1st operand entry
					IF kp_hit = '1' THEN
						nx_acc <= acc(27 DOWNTO 0) & kp_value;
						nx_state <= ACC_RELEASE;
					ELSIF bt_reset_high = '1' THEN
						nx_state <= START_OP;
						hl <= '1';
				    ELSIF bt_reset_low = '1' THEN
				        nx_state <= START_OP;
				        hl <= '0';
					ELSE
						nx_state <= ENTER_ACC;
					END IF;
				WHEN ACC_RELEASE => -- waiting for button to be released
					IF kp_hit = '0' THEN
						nx_state <= ENTER_ACC;
					ELSE nx_state <= ACC_RELEASE;
					END IF;
				WHEN START_OP => -- ready to start entering 2nd operand
					IF kp_hit = '1' THEN
						nx_operand <= X"0000000" & kp_value;
						nx_state <= OP_RELEASE;
						display <= operand;
					ELSE nx_state <= START_OP;
					END IF;
				WHEN OP_RELEASE => -- waiting for button ot be released
					display <= operand;
					IF kp_hit = '0' THEN
						nx_state <= ENTER_OP;
					ELSE nx_state <= OP_RELEASE;
					END IF;
				WHEN ENTER_OP => -- waiting for next digit in 2nd operand
					display <= operand;
					IF SW10 = '1' AND hl = '1' THEN
						nx_acc <= acc;
						nx_state <= SHOW_RESULT;
						high_pass(0) <= acc(0);
						high_pass(1) <= acc(4);
						high_pass(2) <= acc(8);
						high_pass(3) <= acc(12);
						high_pass(4) <= acc(16);
						high_pass(5) <= acc(20);
						high_pass(6) <= acc(24);
						high_pass(7) <= acc(28);
					ELSIF SW10 = '1' AND hl = '0' THEN
						nx_acc <= acc;
						nx_state <= SHOW_RESULT;
						low_pass(0) <= acc(0);
						low_pass(1) <= acc(4);
						low_pass(2) <= acc(8);
						low_pass(3) <= acc(12);
						low_pass(4) <= acc(16);
						low_pass(5) <= acc(20);
						low_pass(6) <= acc(24);
						low_pass(7) <= acc(28); 
					ELSIF kp_hit = '1' THEN
						nx_operand <= operand(27 DOWNTO 0) & kp_value;
						nx_state <= OP_RELEASE;
					ELSE nx_state <= ENTER_OP;
					END IF;
				WHEN SHOW_RESULT => -- display result of addition
					IF kp_hit = '1' THEN
						nx_acc <= X"0000000" & kp_value;
						nx_state <= ACC_RELEASE;
					ELSE nx_state <= SHOW_RESULT;
					END IF;
			END CASE;
		END PROCESS;
		high_pass <= high_pass;
		low_pass <= low_pass;
END Behavioral;