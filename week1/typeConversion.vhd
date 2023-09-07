signal addr: std_logic_vector (0 to 7);
signal index: integer;
begin
	addr <= conv_std_logic_vector(index,8);