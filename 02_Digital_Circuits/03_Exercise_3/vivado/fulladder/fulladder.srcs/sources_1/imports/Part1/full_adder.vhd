---------------------------------------------
-- @file: simple_template.vhd
--
-- @data: 17/10/25
--
-- @autor: n/a
--
-- @description: simple template file for VHDL-design implementations
--

---------------------------------------------
-- libraries
library ieee;
use ieee.std_logic_1164.all;

---------------------------------------------
-- entity
entity full_adder is
	Port ( 
        A   : in  STD_LOGIC;
        B   : in  STD_LOGIC;
        C_i  : in  STD_LOGIC;
        S   : out STD_LOGIC;
        C_o  : out STD_LOGIC
    );
end full_adder;


---------------------------------------------
-- architecture
architecture rtl of full_adder is

-- constants/signals
--		tbd

begin

---------------------------------------------
-- port/signal assignments

    -- 1. Out put of S
    S <= (A xor B) xor C_i;

    -- 2. Out put of C_o
    C_o <= (A and B) or (B and C_i) or (A and C_i);

end rtl;
