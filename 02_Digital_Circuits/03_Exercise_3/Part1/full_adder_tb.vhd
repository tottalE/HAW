---------------------------------------------
-- @file: simple_template_tb.vhd
--
-- @data: 17/10/25
--
-- @autor: tottale
--
-- @description: simple template file of a VHDL-based testbench
--

---------------------------------------------
-- libraries
library ieee;
use ieee.std_logic_1164.all;


---------------------------------------------
-- entity
entity full_adder_tb is
end full_adder_tb;

---------------------------------------------
-- architecture
architecture Behavioral of full_adder_tb is

---------------------------------------------
-- module declaration

-- components : device under test
component full_adder is
	Port ( 
        A   : in  STD_LOGIC;
        B   : in  STD_LOGIC;
        C_i  : in  STD_LOGIC;
        S   : out STD_LOGIC;
        C_o  : out STD_LOGIC
    );
end component;

-- declare and initialize for each port a signal
signal A_s, B_s, C_i_s : std_logic;
signal S_s, C_o_s : std_logic;

-- constants
constant DELAY : time := 10 ns;

begin

---------------------------------------------
-- component instantiation
dut : full_adder
    port map(
        A   => A_s,
        B   => B_s,
        C_i  => C_i_s,
        S   => S_s,
        C_o  => C_o_s
    );


---------------------------------------------
-- stimuli process
process
begin
-- add stimuli data

	-- first testcase
	A_s <= '0';
	B_s <= '0';
	C_i_s <= '0';	
	wait for DELAY;

	-- second testcase
	A_s <= '0';
	B_s <= '0';
	C_i_s <= '1';
	wait for DELAY;

	-- third testcase
	A_s <= '0';
	B_s <= '1';
	C_i_s <= '0';
	wait for DELAY;

	-- fourth testcase
	A_s <= '0';
	B_s <= '1';
	C_i_s <= '1';
	wait for DELAY;

	-- fifth testcase
	A_s <= '1';
	B_s <= '0';
	C_i_s <= '0';
	wait for DELAY;

	-- end of test
	wait;
end process;

end Behavioral;
