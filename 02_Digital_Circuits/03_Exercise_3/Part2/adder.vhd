------------------------------------------------------------------
--
-- [IE3-DI] Digital Circuits 
--
-- @name:   adder.vhd
-- @author: tottale
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
	A_v := A;
	B_v := B;
	c_v := ci;
	
	-- 2. data processing: ripple-carry adder
	for i in 0 to 7 loop
		S_v(i) := A_v(i) xor B_v(i) xor c_v;
		c_v := (A_v(i) and B_v(i)) or (B_v(i) and c_v) or (A_v(i) and c_v);
	end loop;
	

	-- 3. signal assignment
	S <= S_v;
	co <= c_v;

end process;

end architecture rtl;
