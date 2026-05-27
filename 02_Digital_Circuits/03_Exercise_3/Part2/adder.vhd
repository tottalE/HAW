------------------------------------------------------------------
--
-- [IE3-DI] Digital Circuits 
--
-- @name:   adder.vhd
-- @author: 
-- @description: Ripple-Carry-Adder Unit
--				 DESIGN FILE
--
-- (c) 2025 HAW Hamburg
--
------------------------------------------------------------------

---------------------------------
-- libraries
library IEEE;
use IEEE.std_logic_1164.all;

---------------------------------
-- entity
entity adder is
	port( 	
		A  	 : IN  std_logic_vector(7 downto 0);	-- Operand A (bitwidth 8)
     	B  	 : IN  std_logic_vector(7 downto 0);    -- Operand B (bitwidth 8)
        ci	 : IN  std_logic;						-- Carry In (bitwidth 1)

		S 	 : OUT std_logic_vector(7 downto 0);	-- Sum (bitwidth 8)
        co	 : OUT std_logic						-- Carry Out (bitwidth 1)
		);
end entity;

---------------------------------
-- architecture
architecture rtl of adder is
begin

---------------------------------
-- combinatorial process
add: process(A, B, ci)

-- variable declarations
variable c_v : std_logic;
variable S_v : std_logic_vector(7 downto 0);
variable A_v, B_v : std_logic_vector(7 downto 0);

begin
	-- 1. variable assignment
	-- TODO
	
	-- 2. data processing: ripple-carry adder
	-- TODO
	
	-- 3. signal assignment
	-- TODO
	
end process;

end architecture rtl;
