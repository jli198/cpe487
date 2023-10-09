begin
	x1: big_xnor port map (A => A_IN(2),
												 B => B_IN(2),
												 F => p1_out);

	x2: big_xnor port map (A => A_IN(1),
												 B => B_IN(1),
												 F => p2_out);
	
	x3: big_xnor port map (A => A_IN(0),
												 B => B_IN(0),
												 F => p3_out);

	a1: big_and3 port map (A => p1_out,
												 B => p2_out,
												 C => p3_out,
												 F => EQ_OUT);
end ckt1;