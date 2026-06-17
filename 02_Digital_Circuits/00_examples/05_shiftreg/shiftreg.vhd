------------------------------------------------------------
-- File: "shiftreg.vhd"


library IEEE;
use IEEE.STD_LOGIC_1164.all;

---------------------
-- entity declaration
entity shiftreg is
  port (
	clk		: in std_logic;
	rst		: in std_logic;
    din     : in  std_logic;
	dout	: out std_logic
    );
end shiftreg;

-------------------------------
-- architectural description
architecture rtl of shiftreg is

signal shiftreg_cs, shiftreg_ns : std_logic_vector(7 downto 0);

begin
-- signal/output assignment
dout <= shiftreg_cs(7);

shiftreg_ns(7 downto 1) <= shiftreg_cs(6 downto 0);
shiftreg_ns(0) <= din;


-- synchronous process
sync: process(clk, rst)
begin

  if (rst = '1') then
	shiftreg_cs <= x"00";
  elsif(clk = '1' and clk'event) then
	shiftreg_cs <= shiftreg_ns;
  end if;	
  
end process;


end rtl;