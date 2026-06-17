------------------------------------------------------------
-- File: "fsm_v1.vhd"
--
-- Variant 1: 1 process variant
--            (same as traffic_lights.vhd)
-- 

-- libraries
library IEEE;
use IEEE.STD_LOGIC_1164.all;

-- entity
entity fsm_v1 is
  port (
	clk		: in std_logic;
	rst		: in std_logic;
	red_led		: out std_logic;
	yellow_led	: out std_logic;
	green_led	: out std_logic
    );
end fsm_v1;

-- architecture
architecture rtl of fsm_v1 is

-- type declaration
type state_t is (STATE_RED, STATE_REDYELLOW, STATE_YELLOW, STATE_GREEN);
-- signal declaration
signal fsm_cs : state_t;

begin

-- 1. sequential process
sync: process(clk, rst)
begin
  if (rst = '1') then
	fsm_cs <= STATE_RED;
	red_led 	<= '1';
	yellow_led 	<= '0';
	green_led 	<= '0';
  elsif(clk'event and clk = '1') then
	case fsm_cs is
	when STATE_RED => 
		fsm_cs <= STATE_REDYELLOW;
		red_led 	<= '1';
		yellow_led 	<= '0';
		green_led 	<= '0';
	when STATE_REDYELLOW => 
		fsm_cs <= STATE_GREEN;
		red_led 	<= '1';
		yellow_led 	<= '1';
		green_led 	<= '0';
	when STATE_GREEN => 
		fsm_cs <= STATE_YELLOW;
		red_led 	<= '0';
		yellow_led 	<= '0';
		green_led 	<= '1';
	when STATE_YELLOW => 
		fsm_cs <= STATE_RED;
		red_led 	<= '1';
		yellow_led 	<= '0';
		green_led 	<= '0';
	when others => 
	   fsm_cs <= STATE_RED;
		red_led 	<= '1';
		yellow_led 	<= '0';
		green_led 	<= '0';
	end case;
  end if;
end process;

end rtl;
