constant max_fib : integer := 2000;
variable fib_sum : integer := 1;
variable tmp_sum : integer := 0;

while (fib_sum < max_fib) loop
	fib_sum := fib_sum + tmp_sum;
	tmp_sum := fib_sum;
end loop;
--

constant max_num : integer := 10;
variable fib_sum : integer := 1;
variable tmp_sum : integer := 0;
variable int_cnt : integer := 0;

while (int_cnt < max_num) loop
	fib_sum := fib_sum + tmp_sum;
	tmp_sum := fib_sum;
	int_cnt := int_cnt + 1;
end loop;