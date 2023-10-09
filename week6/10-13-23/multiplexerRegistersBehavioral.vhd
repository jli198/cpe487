-- library declaration
library IEEE;
use IEEE.std_logic_1164.all;
-- entity
entity ckt_rt1 is
	port (D1_IN,D2_IN : in std_logic_vector(7 downto 0);
						CLK,SEL : in std_logic;
						LDA,LDB : in std_logic;
				REG_A,REG_B : out std_logic_vector(7 downto 0);
end ckt_rt1;
-- architecture
architecture rtl_behavioral of ckt_rt1 is
	-- intermediate signal declaration
	signal s_mux_result : std_logic_vector(7 downto 0);
begin

	ra: process(CLK) -- process
	begin
		if (rising_edge(CLK)) then
			if (LDA = '1') then
				REG_A <= s_mux_result;
			end if;
		end if;
	end process;

	rb: process(CLK) -- process
	begin
		if (rising_edge(CLK)) then
			if (LDB = '1') then
				REG_B <= s_mux_result;
			end if;
		end if;
	end process;

	with SEL select
	s_mux_result <= D1_IN when '1',
									D2_IN when '0',
									(others => '0') when others;
end rtl_behavioral;