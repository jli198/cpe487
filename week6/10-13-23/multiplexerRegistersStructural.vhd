entity mux2t1 is --- ENTITY
	port ( A,B : in std_logic_vector(7 downto 0);
				 SEL : in std_logic;
			 M_OUT : out std_logic_vector(7 downto 0));
end mux2t1;
architecture my_mux of mux2t1 is --- ARCHITECTURE
begin
	with SEL select
	M_OUT <= A when '1',
					 B when '0',
					 (others => '0') when others;
end my_mux;
entity reg8 is --- ENTITY
	Port ( REG_IN : in std_logic_vector(7 downto 0);
				 LD,CLK : in std_logic;
				REG_OUT : out std_logic_vector(7 downto 0));
end reg8
architecture reg8 of reg8 is --- ARCITECTURE
begin
		reg: process(CLK)
		begin
			if (rising_edge(CLK)) then
				if (LD = '1') then
					REG_OUT <= REG_IN;
				end if;
		end if;
	end process
end reg8;

entity ckt_rt1 is --- ENTITY
	port (D1_IN,D2_IN : in std_logic_vector(7 downto 0);
						CLK_SEL : in std_logic;
						LDA,LDB : in std_logic;
				REG_A,REG_B : out std_logic_vector(7 downto 0));
end ckt_rt1;
architecture rt1_structural of ckt_rt1 is --- ARCHITECTURE
	-- comppnent declaration
	component mux2t1
		port ( A,B : in std_logic_vector(7 downto 0);
					 SEL : in std_logic;
				 M_OUT : out std_logic_vector(7 downto 0));
	end compoennt;
	component reg8
		Port ( REG_IN : in std_logic_vector(7 downto 0);
					 LD,CLK : in std_logic;
						M_OUT : out std_logic_vector(7 downto 0));
	end component;
	-- intermediate signal declaration
	signal s_mux_result : std_logic_vector(7 downto 0);
begin
	ra: reg8
	port map ( REG_IN => s_mux_result,
								 LD => LDA,
								CLK => CLK,
						REG_OUT => REG_A );
	rb: reg8
	port map ( REG_IN => s_mux_result,
								 LD => LDB,
								CLK => CLK,
						REG_OUT => REG_B );
	m1: mux2t1
	port map ( A => D1_IN,
						 B => D2_IN,
					 SEL => SEL,
				 M_OUT => s_mux_result);
end rt1_structural