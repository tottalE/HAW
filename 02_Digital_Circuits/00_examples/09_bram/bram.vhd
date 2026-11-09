-------------------------------------------------------------------------------
-- File       : bram.vhd
-- Author     : Jochen Rust
-- Company    : HAW Hamburg
-- Created    : 2020-07-30
-------------------------------------------------------------------------------
-- Description: Dual port memory interface
-------------------------------------------------------------------------------
-- Copyright (c) 2025 HAW Hamburg
-------------------------------------------------------------------------------
-- Revisions  :
-- Date        	Version  	Author  	Description
-- 2025-07-30  	1.0      	Jochen 		initial implementation
-- ...
-------------------------------------------------------------------------------

-- LIBRARIES
library ieee;
use ieee.std_logic_1164.all;	-- std_logic
use ieee.numeric_std.all;		-- numeric

-- ENTITY
entity bram is
  generic (
    DWIDTH    : integer := 32;	-- width of DWIDTH path
    AWIDTH    : integer := 10	-- width of address bus
    );
  port (
    -- primary memory port (a)
    a_clk   : in  std_logic;							-- clock
    a_wr    : in  std_logic;							-- write enable flag
    a_addr  : in  std_logic_vector(AWIDTH-1 downto 0);	-- address port
    a_din   : in  std_logic_vector(DWIDTH-1 downto 0);	-- DWIDTH in
    a_dout  : out std_logic_vector(DWIDTH-1 downto 0);	-- DWIDTH out

    -- secondary memory port (b)
    b_clk   : in  std_logic;							-- clock
    b_wr    : in  std_logic;							-- write enable flag
    b_addr  : in  std_logic_vector(AWIDTH-1 downto 0);	-- address port
    b_din   : in  std_logic_vector(DWIDTH-1 downto 0);	-- DWIDTH in
    b_dout  : out std_logic_vector(DWIDTH-1 downto 0)		-- DWIDTH out
    );
end bram;

-- ARCHITECTURE (behavior)
architecture behavior of bram is

	-- type declaration(s)
	type mem_t is array ( (2**AWIDTH)-1 downto 0 ) of std_logic_vector(DWIDTH-1 downto 0);	-- memory type
	-- datatype declaration(s)
	shared variable mem : mem_t;	-- memory datatype
  
begin

	-- port a
	process(a_clk)
	begin
		if rising_edge(a_clk) then
			if(a_wr='1') then
				mem(to_integer(unsigned(a_addr))) := a_din;
			end if;
		a_dout <= mem(to_integer(unsigned(a_addr)));
		end if;
	end process;

	-- port b
	process(b_clk)
	begin
		if(b_clk'event and b_clk='1') then
			if(b_wr='1') then
				mem(to_integer(unsigned(b_addr))) := b_din;
			end if;
		b_dout <= mem(to_integer(unsigned(b_addr)));
		end if;
	end process;

end behavior;