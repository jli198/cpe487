architecture f3_3 of my_ckt_3 is
begin
F3 <= '1' when (L= '0' AND M = '0' AND N = '1') else
			'1' when (L= '1' AND M = '1') else
			'0';
end f3_3;