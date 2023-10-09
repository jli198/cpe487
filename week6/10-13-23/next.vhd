variable my_sum : integer := 0;
--
for cnt_val in 0 to 50 loop
	if (my_sum = 20) then
		next;
	end if;
	my_sum := my_sum + 1;
end loop;