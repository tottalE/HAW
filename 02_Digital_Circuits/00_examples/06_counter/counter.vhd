------------------------------------------------------------
-- File: "counter.vhd"

-- libraries
library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.NUMERIC_STD.all;

-- entity
entity counter is
  port (
	clk		: in std_logic;
	rst		: in std_logic;
	dout	: out std_logic_vector(15 downto 0)
    );
end counter;

-- architecture
architecture rtl of counter is

-- signal declaration
-- TODO

begin
-- output/signal assignment
-- TODO

-- synchron process
-- TODO

end rtl;