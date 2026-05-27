---------------------------------------------
-- @file: simple_template_tb.vhd
--
-- @data: 17/10/25
--
-- @autor: n/a
--
-- @description: simple template file of a VHDL-based testbench
--

---------------------------------------------
-- libraries
library ieee;
use ieee.std_logic_1164.all;


---------------------------------------------
-- entity
entity simple_template_tb is
end simple_template_tb;

---------------------------------------------
-- architecture
architecture Behavioral of simple_template_tb is

---------------------------------------------
-- module declaration

-- components : device under test
component simple_template
	port (       
--		tbd
    ); 
end component;

-- declare and initialize for each port a signal
-- tbd

-- constants
constant DELAY : time := 10 ns;

begin

---------------------------------------------
-- component instantiation
dut : simple_template
    port map(
-- tbd
);


---------------------------------------------
-- stimuli process
process
begin
-- add stimuli data

	-- first testcase
	wait for DELAY;

	-- second testcase
	wait for DELAY;
	-- ...
	
	wait for DELAY;
	-- end of test
	wait;
end process;

end Behavioral;
