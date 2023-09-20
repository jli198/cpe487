-- https://ghdl.readthedocs.io/en/stable/using/QuickStartGuide.html
-- Hello world program

use std.textio.all; -- Imports standard textio package

-- Defines design entity, without any ports
entity hello_world is
end hello_world;

architecture behaviour of hello_world is
begin
	process
		variable l: line;
	begin
		write (l, String("Hello world!"));
		writeline (output, l);
		wait;
	end process;
end behaviour;