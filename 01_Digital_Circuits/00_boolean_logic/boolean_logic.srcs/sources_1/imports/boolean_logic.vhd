---------------------------------------------
-- @file: boolean_logic.vhd
--
-- @data: 26/04/26
--
-- @autor: Jinju Ok
--
-- @description: HAW Hamburg [IE03-DIL] 
--				 boolean logic module for lab exercise 2
--				 (PART 3)
--				

---------------------------------------------
-- libraries
library ieee;
use ieee.std_logic_1164.all;

---------------------------------------------
-- entity
entity boolean_logic is
	port ( din0    : in std_logic_vector(1 downto 0);
	       din1    : in std_logic_vector(3 downto 0);
           dout0  : out std_logic_vector(1 downto 0);
           dout1  : out std_logic_vector(2 downto 0);
           dout2  : out std_logic
    ); 
end boolean_logic;


---------------------------------------------
-- architecture
architecture rtl of boolean_logic is

-- CONSTANT/SIGNAL declaration
-- tbd

begin

---------------------------------------------
-- port/signal assignments
process(din0, din1)
-- variables
    variable var1_v : std_logic;
    variable var2_v : std_logic;
    variable var3_v : std_logic;
    variable var4_v : std_logic;
    variable var5_v : std_logic;
    variable var6_v : std_logic;
    
    variable dout0_v: std_logic_vector(1 downto 0);
    variable dout1_v: std_logic_vector(2 downto 0);
    variable dout2_v: std_logic;
    
BEGIN
 -- Assgin variables
 var1_v := din0(0) and din0(1) and din1(0);
 var2_v := not din1(0);
 var3_v := din1(0) xnor din1(3);
 var4_v := var1_v nor var2_v;
 var5_v := din1(0) and var3_v;
 var6_v := not din1(2);
 
 -- Process outputs
 dout0_v(0) := var4_v;
 dout0_v(1) := var5_v;
 dout1_v(0) := var5_v;
 dout1_v(1) := din1(1);
 dout1_v(2) := din1(3);
 dout2_v := var6_v;

-- Assign outputs
dout0 <= dout0_v;
dout1 <= dout1_v;
dout2 <= dout2_v;
 
END PROCESS;

end rtl;
