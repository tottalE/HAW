------------------------------------------------------------------
--
-- [IE3-DI] Digital Circuits 
--			Exercise 4
--
-- @name:   seven_segment.vhd
-- @author: 
-- @description: control unit for the seven segment display of the 
--               basys 3 board
--				 DESIGN FILE
--
-- (c) 2025 HAW Hamburg
--
-- @changelog
-- 25-11-10 initial implementation
--
------------------------------------------------------------------

---------------------------------------------
-- libraries
library ieee;
use ieee.std_logic_1164.all;
use IEEE.NUMERIC_STD.all;

---------------------------------------------
-- entity
entity seven_segment is
    Port ( clk : in STD_LOGIC;
           rst : in STD_LOGIC;
           
           LEDs : out STD_LOGIC_VECTOR(7 downto 0);
           DIGIT_select : out STD_LOGIC_VECTOR(3 downto 0);
           SW : in STD_LOGIC_VECTOR(7 downto 0)
           );
end seven_segment;


---------------------------------------------
-- architecture
architecture rtl of seven_segment is


---------------------------------------------
-- signal declaration
-- TODO

-- PREPARATION: Update the bit patterns of the constants for the 7-segment LEDs
constant ZERO : std_logic_vector(7 downto 0)  := "00000000";
constant ONE : std_logic_vector(7 downto 0)   := "00000000";
constant TWO : std_logic_vector(7 downto 0)   := "00000000";
constant THREE : std_logic_vector(7 downto 0) := "00000000";
constant FOUR : std_logic_vector(7 downto 0)  := "00000000";
constant FIVE : std_logic_vector(7 downto 0)  := "00000000";
constant SIX : std_logic_vector(7 downto 0)   := "00000000";
constant SEVEN : std_logic_vector(7 downto 0) := "00000000";
constant EIGHT : std_logic_vector(7 downto 0) := "00000000";
constant NINE : std_logic_vector(7 downto 0)  := "00000000";

begin

---------------------------------
-- sequential process (state)
sync : process
begin

-- TODO

end process;

---------------------------------
-- combinatorial process (delta)
delta : process
begin

-- TODO

end process;


---------------------------------
-- combinatorial process (lambda)
lambda : process
begin

-- TODO

end process;

end rtl;