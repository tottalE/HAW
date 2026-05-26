---------------------------------------------
-- @file: boolean_logic_tb.vhd
--
-- @data: 26/04/26
--
-- @autor: Jinju Ok
--
-- @description: HAW Hamburg [IE03-DIL] 
--				 boolean logic testbench template for lab exercise 2
--				 (PART 3)
--

---------------------------------------------
-- libraries
library IEEE;
use IEEE.std_logic_1164.all;


---------------------------------------------
-- entity
entity boolean_logic_tb is
end boolean_logic_tb;

---------------------------------------------
-- architecture
architecture Behavioral of boolean_logic_tb is

---------------------------------------------
-- module declaration

-- component : device under test
-- declare and initialize for each port a signal
component boolean_logic is
    Port ( din0    : in std_logic_vector(1 downto 0);
	       din1    : in std_logic_vector(3 downto 0);
           dout0  : out std_logic_vector(1 downto 0);
           dout1  : out std_logic_vector(2 downto 0);
           dout2  : out std_logic
    ); 
end component;

--Signal declaration
signal din0_s, dout0_s : std_logic_vector(1 downto 0);
signal din1_s : std_logic_vector(3 downto 0);
signal dout1_s : std_logic_vector(2 downto 0);
signal dout2_s : std_logic;

-- constants
constant DELAY : time := 10 ns;
begin

---------------------------------------------
-- component instantiation
-- tbd
i_boolean_logic : boolean_logic
    port map(
    din0 => din0_s,
    din1 => din1_s,
    dout0 => dout0_s,
    dout1 => dout1_s,
    dout2 => dout2_s
    );

---------------------------------------------
-- stimuli process
process
begin
-- add stimuli data
-- first stimuli set (binary values) 
    din0_s <= "00";    
    din1_s <= "0000";     
	wait for DELAY;
	
	din0_s <= "10";    
    din1_s <= "1100";  
    wait for DELAY;


    din0_s <= "11";    
    din1_s <= "1111";     
	wait for DELAY;
	wait;
end process;

end Behavioral;
