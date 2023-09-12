-- yet another solution to previous example
architecture f3_4 of my_ckt_f3 is
begin
	with ((L ='0' and M ='0' and N ='1') or (L='1' and M='1')) select
	F3 <= '1' when '1',
				'0' when '0',
				'0' when others;
end f3_4;