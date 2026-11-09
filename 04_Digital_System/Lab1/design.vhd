-------------------------------------------------------------------------------
--
-- Title       : Codec Interface
-- Design      : 
-- Author      : peter.schulz@haw-hambuirg.de
-- Company     : Hamburg University of Applied Sciences
--
-------------------------------------------------------------------------------
--
-- Description : 	 CODEC control unit:
--					 receives a main clock and derives lower frequency clocks
--                   and clock enable signals
--					 Support logic:
--					 SIPO and PISO
-- 					 Datapath:
--					 simple loop back of CODEC data in parallel domain
--
-------------------------------------------------------------------------------


library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity codec_interface is
    -- Attention: generic parameters may be overwritten through instantiation!!!
	generic (								
	clk_in_frequency : integer := 100000000; -- 100 MHz on FPGA board
	LRC_frequency : integer := 100000000/2048; -- LRC: left/right clock
	BIT_frequency: integer := 100000000/64; -- Bit Clock
	SYS_frequency : integer := 100000000/8; -- CODEC system clock
	d_frequency : integer := 1 -- utility clock, e.g. "heart beat"
		);	 
	 port(
	 reset_n : in std_logic;
	 enable : in std_logic;
		 clk_in : in STD_LOGIC; -- 100 MHz from FPGA board
		 clk_LRC : out STD_LOGIC; -- LRC: left/right clock
         clk_BIT : out STD_LOGIC; -- Bit Clock
         clk_SYS : out STD_LOGIC; -- CODEC system clock
         clk_d : out STD_LOGIC; -- utility clock, connect to an LED
         DOUT: out STD_LOGIC;   -- serial data output to CODEC
         DIN: in STD_LOGIC		-- serial data input from CODEC
         -- add ports as necessary
	     );
end codec_interface;

architecture test of codec_interface is 
-- clock divider constant values
constant max_LRC : integer := clk_in_frequency / LRC_frequency;
constant max_BIT : integer := clk_in_frequency / BIT_frequency;
constant max_SYS : integer := clk_in_frequency / SYS_frequency;
constant max_d : integer := clk_in_frequency / d_frequency;
constant toggle_LRC : integer := max_LRC/2; -- toggle points for 50% duty cycle
constant toggle_BIT : integer := max_BIT/2;
constant toggle_SYS : integer := max_SYS/2;
constant toggle_d : integer := max_d/2;
-- enable signals, only active for one clk_in period
signal clk_en_LRC_rising: std_logic;
signal clk_en_LRC_falling: std_logic;
signal clk_en_BIT_rising: std_logic;
signal clk_en_BIT_falling: std_logic;
signal clk_en_SYS_rising: std_logic;
signal clk_en_d: std_logic;
-- shift register control signals, maybe replaced by other signals!
signal SIPO_save: std_logic;
signal PISO_load: std_logic;
-- SIPO registers
signal SI_reg: std_logic_vector(31 downto 0);       -- input shift register from CODEC
signal PO_reg_left: std_logic_vector(15 downto 0);  -- left channel parallel to datapath
signal PO_reg_right: std_logic_vector(15 downto 0); -- right channel parallel to datapath 
-- PISO register and input signals
signal SO_reg: std_logic_vector(31 downto 0);       -- output shift register to CODEC
signal PI_left: std_logic_vector(15 downto 0);      -- left channel parallel from datapath
signal PI_right: std_logic_vector(15 downto 0);     -- right channel parallel from datapath

begin

-- start of datapath operational area: do s.th. with the parallel signals:

-- for datapath logic use datatypes from numeric_std library!

-- "unclocked" combinational logic only !!!!!

-- loop-back as a simple example
PI_left <= PO_reg_left;       -- replace by other datapath logic
PI_right <= PO_reg_right;     -- replace by other datapath logic

-- end of datapath operational area


-- don't touch the code below. It works fine!!!

-- support logic:

si_po: process (clk_in, reset_n)
	begin
    if reset_n = '0' then
    	SI_reg <= (others=>'0');
    elsif rising_edge(clk_in) then
    	if clk_en_BIT_rising ='1' then   -- one shift per bit-cycle on rising edge of BIT clock
        	SI_reg <= SI_reg(30 downto 0) & DIN; -- DIN: from CODEC serial data
        end if;
        if clk_en_LRC_rising = '1' then  -- SIPO save
            	PO_reg_left <= SI_reg(31 downto 16); -- parallel data to datapath
                PO_reg_right <= SI_reg(15 downto 0); -- parallel data to datapath
        end if;
    end if;
end process;

pi_so: process(clk_in, reset_n)
	begin
    if reset_n = '0' then
    	SO_reg <= (others=>'0');
    elsif rising_edge(clk_in) then
    	if clk_en_BIT_falling='1' then   -- one shift per bit-cycle on falling edge of BIT clock
        	SO_reg <= SO_reg(30 downto 0) & '0';
        end if;
        if clk_en_LRC_rising = '1' then  -- PISO load
            	SO_reg(31 downto 16) <= PI_left ; -- parallel data from datapath
                SO_reg(15 downto 0) <= PI_right ; -- parallel data from datapath
        end if;
    end if;
end process;

DOUT <= SO_reg(31);  -- DOUT: to CODEC serial data

-- CODEC clock control unit:
clock_divider: process (clk_in, reset_n)
	-- counter state registers
	variable counter_LRC : integer range 0 to max_LRC - 1;
	variable counter_BIT : integer range 0 to max_BIT - 1;
	variable counter_SYS : integer range 0 to max_SYS - 1;
	variable counter_d : integer range 0 to max_d - 1;

	begin
	if reset_n='0' then 
		counter_LRC := 0;
		counter_BIT := 0;
		counter_SYS := 0;
		counter_d := 0;
		clk_en_LRC_rising <= '0';    -- some things to do on rising edge of LRC
		clk_en_LRC_falling <= '0';   -- some things to do on falling edge of LRC
		clk_en_BIT_rising <= '0';    -- some things to do on rising edge of BIT clock
		clk_en_BIT_falling <= '0';   -- some things to do on falling edge of BIT clock
		clk_en_SYS_rising <= '0';
		clk_en_d <= '0';
        clk_LRC <= '1';
        clk_BIT <= '1';
        clk_SYS <= '1';
        clk_d <= '1';
	elsif rising_edge(clk_in) then
		clk_en_LRC_rising <= '0';
		clk_en_LRC_falling <= '0';
		clk_en_BIT_rising <= '0';
		clk_en_BIT_falling <= '0';
		clk_en_SYS_rising <= '0';
		clk_en_d <= '0';
		if enable = '1' then		-- attention: the whole CODEC clock mechanism can be stopped!!!!
        	-- LRC divider
			if counter_LRC = max_LRC -1 then
				counter_LRC := 0;
				clk_en_LRC_rising <= '1';
                clk_LRC <= '1';
            elsif counter_LRC = toggle_LRC -1 then
            	clk_en_LRC_falling <= '1';
                clk_LRC <='0';
                counter_LRC := counter_LRC + 1;
			else
				counter_LRC := counter_LRC + 1;
			end if;
            -- BIT divider
			if counter_BIT = max_BIT -1 then
				counter_BIT := 0;
				clk_en_BIT_falling <= '1'; 
                clk_BIT <= '0'; -- phase shift 180 degrees
            elsif counter_BIT = toggle_BIT -1 then
            	clk_en_BIT_rising <= '1';
                clk_BIT <='1'; -- phase shift 180 degrees
                counter_BIT := counter_BIT + 1;
			else
				counter_BIT := counter_BIT + 1;
			end if;	
            -- SYS divider
			if counter_SYS = max_SYS -1 then
				counter_SYS := 0;
				clk_en_SYS_rising <= '1';
                clk_SYS <= '1';
            elsif counter_SYS = toggle_SYS -1 then
                clk_SYS <='0';
                counter_SYS := counter_SYS + 1;
			else
				counter_SYS := counter_SYS + 1;
			end if;	
            -- utility divider for LED
			if counter_d = max_d -1 then
				counter_d := 0;
				clk_en_d <= '1';
                clk_d <= '1';
            elsif counter_d = toggle_d -1 then
                clk_d <='0';
                counter_d := counter_d + 1;
			else
				counter_d := counter_d + 1;
			end if;			
		end if;
	end if;
	end process;

end test;
