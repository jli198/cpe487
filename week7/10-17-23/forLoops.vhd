for cnt_val in 0 to 24 loop
	-- sequential_statements
end loop;

for cnt_Val in 24 downto 0 loop
	-- sequential_statements
end loop;

type my_range is range 0 to 24;
--
for cnt_val in my_range loop
	-- sequential_statements
end loop;

type my_range is range 24 downto 0;
--
for cnt_val in my_range loop
	-- sequential_statements
end loop;