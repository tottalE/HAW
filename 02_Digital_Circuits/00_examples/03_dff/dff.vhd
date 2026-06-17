------------------------------------------------------------
-- File: "dff.vhd"

-- library
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- entity
entity dff is
    port(
    clk : in STD_LOGIC;
    rst : in STD_LOGIC;
    dff_in : in STD_LOGIC;
    dff_out : out STD_LOGIC
    ); 
end dff;

-- architecture
architecture rtl of dff is
-- signal declaration

begin

-- signal and output assignments



-- sequential process
sync : process (clk, rst)
  begin 
  -- reset
  if rst = '1' then
    dff_out <= '0';
    
  -- rising clock edge
  elsif rising_edge(clk) then
    dff_out <= dff_in;
  end if;
 end process;

end rtl;
