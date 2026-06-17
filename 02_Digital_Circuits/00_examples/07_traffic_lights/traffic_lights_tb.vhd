------------------------------------------------------------
-- File: "traffic_lights_tb.vhd"

-- libraries
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- entity
entity traffic_lights_tb is
end traffic_lights_tb;

-- architecture
architecture Behavioral of traffic_lights_tb is

-- declare the design file (dff)
component traffic_lights is
  port (
	clk		: in std_logic;
	rst		: in std_logic;
	red_led		: out std_logic;
	yellow_led	: out std_logic;
	green_led	: out std_logic
    );
end component;

-- signals in the testbench that are connected to the design file
signal red_led_s, yellow_led_s, green_led_s : STD_LOGIC;
signal clk_s : STD_LOGIC;
signal rst_s : STD_LOGIC;

-- constants for simulating the timing
constant PERIOD : time := 10 ns;    -- period of one clock cycle
constant OFFSET : time := 1 ns;     -- small offset

begin

-- instantiate the design file (dff)
i_traffic_lights : traffic_lights
    port map(
    clk => clk_s,
    rst => rst_s,
    red_led => red_led_s,
    yellow_led => yellow_led_s,
    green_led => green_led_s
    );

-- generate a clock
clock: process
begin
    while(true) loop
    clk_s <= '1';       -- set the clock to 0
    wait for PERIOD/2;  -- wait PERIOD/2
    clk_s <= '0';       -- set the clock to 1
    wait for PERIOD/2;  -- wait PERIOD/2
    end loop;
end process;


-- STIMULI process
process
begin
    -- 0. small offset
    -- (input signals are not synchronized with the clock)
    wait for OFFSET;

	-- 1. reset the dff for 3 clock periods
	rst_s <= '1';
	wait for 3*PERIOD;

	-- 2. disable the reset
	rst_s <= '0';
	wait for PERIOD;

	-- 3. wait forever
    wait;
	
end process;


end Behavioral;
