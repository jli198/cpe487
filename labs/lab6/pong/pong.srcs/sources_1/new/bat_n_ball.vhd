LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;

ENTITY bat_n_ball IS
    PORT (
        v_sync : IN STD_LOGIC;
        pixel_row : IN STD_LOGIC_VECTOR(10 DOWNTO 0);
        pixel_col : IN STD_LOGIC_VECTOR(10 DOWNTO 0);
        bat_x : IN STD_LOGIC_VECTOR (10 DOWNTO 0); -- current bat x position
        serve : IN STD_LOGIC; -- initiates serve
        red : OUT STD_LOGIC;
        green : OUT STD_LOGIC;
        blue : OUT STD_LOGIC;
        SW : IN STD_LOGIC_VECTOR (7 DOWNTO 0);
        display_count: OUT STD_LOGIC_VECTOR (15 DOWNTO 0)
    );
END bat_n_ball;

ARCHITECTURE Behavioral OF bat_n_ball IS
    CONSTANT bsize : INTEGER := 8; -- ball size in pixels
    SIGNAL bat_w : INTEGER := 40; -- bat width in pixels
    CONSTANT bat_h : INTEGER := 3; -- bat height in pixels
    -- distance ball moves each frame
    --CONSTANT ball_speed : STD_LOGIC_VECTOR (10 DOWNTO 0) := CONV_STD_LOGIC_VECTOR (6, 11);
   -- SIGNAL ball_speed : STD_LOGIC_VECTOR (10 DOWNTO 0) := CONV_STD_LOGIC_VECTOR (6, 11);
    SIGNAL ball_speed : STD_LOGIC_VECTOR (10 DOWNTO 0);
    SIGNAL ball_on : STD_LOGIC; -- indicates whether ball is at current pixel position
    SIGNAL bat_on : STD_LOGIC; -- indicates whether bat at over current pixel position
    SIGNAL game_on : STD_LOGIC := '0'; -- indicates whether ball is in play
    -- current ball position - intitialized to center of screen
    SIGNAL ball_x : STD_LOGIC_VECTOR(10 DOWNTO 0) := CONV_STD_LOGIC_VECTOR(400, 11);
    SIGNAL ball_y : STD_LOGIC_VECTOR(10 DOWNTO 0) := CONV_STD_LOGIC_VECTOR(300, 11);
    -- bat vertical position
    CONSTANT bat_y : STD_LOGIC_VECTOR(10 DOWNTO 0) := CONV_STD_LOGIC_VECTOR(500, 11);
    -- current ball motion - initialized to (+ ball_speed) pixels/frame in both X and Y directions
    SIGNAL ball_x_motion, ball_y_motion : STD_LOGIC_VECTOR(10 DOWNTO 0) := ball_speed;
    SIGNAL hit_count : STD_LOGIC_VECTOR(15 DOWNTO 0);
    SIGNAL hit_count_temp : STD_LOGIC_VECTOR(15 DOWNTO 0);
BEGIN
    red <= NOT ball_on; -- color setup for red ball and cyan bat on white background
    green <= NOT bat_on;
    blue <= NOT ball_on;
    -- process to draw round ball
    -- set ball_on if current pixel address is covered by ball position


    -- use binary conversion to get from 0-31 to 1-32 range for problem with each switch representing a bit
    balldraw : PROCESS (ball_x, ball_y, pixel_row, pixel_col) IS
        VARIABLE vx, vy : STD_LOGIC_VECTOR (10 DOWNTO 0); -- 9 downto 0
    BEGIN
        IF pixel_col <= ball_x THEN -- vx = |ball_x - pixel_col|
            vx := ball_x - pixel_col;
        ELSE
            vx := pixel_col - ball_x;
        END IF;
        IF pixel_row <= ball_y THEN -- vy = |ball_y - pixel_row|
            vy := ball_y - pixel_row;
        ELSE
            vy := pixel_row - ball_y;
        END IF;
        IF ((vx * vx) + (vy * vy)) < (bsize * bsize) THEN -- test if radial distance < bsize
            ball_on <= game_on;
        ELSE
            ball_on <= '0';
        END IF;
    END PROCESS;
    -- process to draw bat
    -- set bat_on if current pixel address is covered by bat position
    batdraw : PROCESS (bat_x, pixel_row, pixel_col) IS
        VARIABLE vx, vy : STD_LOGIC_VECTOR (10 DOWNTO 0); -- 9 downto 0
    BEGIN
        IF ((pixel_col >= bat_x - bat_w) OR (bat_x <= bat_w)) AND
         pixel_col <= bat_x + bat_w AND
             pixel_row >= bat_y - bat_h AND
             pixel_row <= bat_y + bat_h THEN
                bat_on <= '1';
        ELSE
            bat_on <= '0';
        END IF;
    END PROCESS;
    -- process to move ball once every frame (i.e., once every vsync pulse)
    mball : PROCESS
        VARIABLE temp : STD_LOGIC_VECTOR (11 DOWNTO 0);
    BEGIN
        ball_speed <= "00000000110";
        IF (SW(0) = '1' OR SW(1) = '1' OR SW(2) = '1'  OR SW(3) = '1' OR SW(4) = '1') THEN
            ball_speed(0) <= SW(0);
            ball_speed(1) <= SW(1);
            ball_speed(2) <= SW(2);
            ball_speed(3) <= SW(3);
            ball_speed(4) <= SW(4);
        END IF;
        WAIT UNTIL rising_edge(v_sync);
        IF (ball_speed(0) = '0' AND ball_speed(1) = '0' AND ball_speed(2) = '0' AND ball_speed(3) = '0' AND ball_speed(4) = '0')  THEN
        ball_speed <= ball_speed + 1;
        END IF;
        IF serve = '1' AND game_on = '0' THEN -- test for new serve
            game_on <= '1';
            ball_y_motion <= (NOT ball_speed) + 1; -- set vspeed to (- ball_speed) pixels
            ball_x_motion <= ball_speed + 1;
            bat_w <= 40;
            hit_count <= "0000000000000000";
            hit_count_temp <= "0000000000000000"; 
        ELSIF ball_y <= bsize THEN -- bounce off top wall
            ball_y_motion <= ball_speed; -- set vspeed to (+ ball_speed) pixels
            hit_count_temp <= "0000000000000000";
        ELSIF ball_y + bsize >= 600 THEN -- if ball meets bottom wall
            ball_y_motion <= (NOT ball_speed) + 1; -- set vspeed to (- ball_speed) pixels
            game_on <= '0'; -- and make ball disappear
            hit_count <= "0000000000000000";
            hit_count_temp <= "0000000000000000";
            display_count <= hit_count;
        END IF;
        -- allow for bounce off left or right of screen
        IF ball_x + bsize >= 800 THEN -- bounce off right wall
            ball_x_motion <= (NOT ball_speed) + 1; -- set hspeed to (- ball_speed) pixels
            hit_count_temp <= "0000000000000000";
        ELSIF ball_x <= bsize THEN -- bounce off left wall
            hit_count_temp <= "0000000000000000";
            ball_x_motion <= ball_speed; -- set hspeed to (+ ball_speed) pixels          
        END IF;
        -- allow for bounce off bat
        IF (ball_x + bsize/2) >= (bat_x - bat_w) AND
         (ball_x - bsize/2) <= (bat_x + bat_w) AND
             (ball_y + bsize/2) >= (bat_y - bat_h) AND
             (ball_y - bsize/2) <= (bat_y + bat_h) AND hit_count_temp = "0000000000000000" THEN
                ball_y_motion <= (NOT ball_speed) + 1; -- set vspeed to (- ball_speed) pixels
                hit_count_temp <= "1111111111111111";
                hit_count <= hit_count + 1;
                display_count <= hit_count;
                IF bat_w > 1 THEN
                    bat_w <= bat_w -1;
                ELSE
                    bat_w <= 40;
                END IF;
        END IF;
        -- compute next ball vertical position
        -- variable temp adds one more bit to calculation to fix unsigned underflow problems
        -- when ball_y is close to zero and ball_y_motion is negative
        temp := ('0' & ball_y) + (ball_y_motion(10) & ball_y_motion);
        IF game_on = '0' THEN
            ball_y <= CONV_STD_LOGIC_VECTOR(440, 11);
        ELSIF temp(11) = '1' THEN
            ball_y <= (OTHERS => '0');
        ELSE ball_y <= temp(10 DOWNTO 0); -- 9 downto 0
        END IF;
        -- compute next ball horizontal position
        -- variable temp adds one more bit to calculation to fix unsigned underflow problems
        -- when ball_x is close to zero and ball_x_motion is negative
        temp := ('0' & ball_x) + (ball_x_motion(10) & ball_x_motion);
        IF temp(11) = '1' THEN
            ball_x <= (OTHERS => '0');
        ELSE ball_x <= temp(10 DOWNTO 0);
        END IF;
    END PROCESS;
END Behavioral;