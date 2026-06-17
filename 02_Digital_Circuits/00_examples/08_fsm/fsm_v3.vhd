------------------------------------------------------------
-- File: "fsm_v3.vhd"
--
-- Variant 3: three process variant (delta/lambda separately)
--            
-- 


-- libraries
library IEEE;
use IEEE.STD_LOGIC_1164.all;

-- entity
entity fsm_v3 is
  port (
	clk		: in std_logic;
	rst		: in std_logic;
	red_led		: out std_logic;
	yellow_led	: out std_logic;
	green_led	: out std_logic
    );
end fsm_v3;

-- architecture
architecture rtl of fsm_v3 is

-- type declaration
type state_t is (STATE_RED, STATE_REDYELLOW, STATE_YELLOW, STATE_GREEN);
-- signal declaration
signal fsm_cs, fsm_ns : state_t;

begin

-- synchron process
sync: process(clk, rst)
begin
  if (rst = '1') then
	fsm_cs <= STATE_RED;
  elsif(clk'event and clk = '1') then
	fsm_cs <= fsm_ns;
  end if;
end process;

-- delta: next state process
delta: process(fsm_cs)
begin
	case fsm_cs is
	when STATE_RED => 
		fsm_ns <= STATE_REDYELLOW;
	when STATE_REDYELLOW => 
		fsm_ns <= STATE_GREEN;
	when STATE_GREEN => 
		fsm_ns <= STATE_YELLOW;
	when STATE_YELLOW => 
		fsm_ns <= STATE_RED;
	when others => 
	   fsm_ns <= STATE_RED;
	end case;
end process;
 
-- lambda: output process
lambda: process(fsm_cs)
begin
	case fsm_cs is
	when STATE_RED => 
		red_led 	<= '1';
		yellow_led 	<= '0';
		green_led 	<= '0';
	when STATE_REDYELLOW => 
		red_led 	<= '1';
		yellow_led 	<= '1';
		green_led 	<= '0';
	when STATE_GREEN => 
		red_led 	<= '0';
		yellow_led 	<= '0';
		green_led 	<= '1';
	when STATE_YELLOW => 
		red_led 	<= '0';
		yellow_led 	<= '1';
		green_led 	<= '0';
	when others => 
		red_led 	<= '1';
		yellow_led 	<= '0';
		green_led 	<= '0';
	end case;
end process;
 
end rtl;
