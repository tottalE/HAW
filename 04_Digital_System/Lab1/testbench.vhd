-- Code your testbench here
library IEEE;
use IEEE.std_logic_1164.all;
entity tb_codec_interface is
end entity;

architecture testbench of tb_codec_interface is
component codec_interface is
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
         DIN: in STD_LOGIC;		-- serial data input from CODEC
	     );
end component;

signal tb_clk: std_logic := '0';
signal tb_reset_n, tb_enable: std_logic;
signal tb_DIN: std_logic := 'U';
signal DIN_stimulus_1: std_logic_vector ( 31 downto 0) := X"B0AF_6AFB";
signal DIN_stimulus_2: std_logic_vector ( 31 downto 0) := X"AA55_4F12";
signal tb_clk_BIT, tb_clk_LRC : std_logic;
constant bit_time : time := 640 ns;

begin
dut: codec_interface port map (reset_n => tb_reset_n, enable => tb_enable, clk_in => tb_clk, DIN => tb_DIN, clk_BIT => tb_clk_BIT, clk_LRC => tb_clk_LRC);

tb_clk <= not tb_clk after 5 ns;
tb_reset_n <= '1', '0' after 5 ns, '1' after 100 ns;
tb_enable <= '0', '1' after 150 ns;

send_serial: process
begin
-- let some time pass and synchronize
wait until falling_edge(tb_clk_LRC);
--wait until rising_edge(tb_clk_LRC);
wait for 16*bit_time;
for J in 1 to 2 loop
	for I in 31 downto 0 loop  -- MSB first
    	wait until falling_edge(tb_clk_BIT);
    	tb_DIN <= DIN_stimulus_1(I);
    end loop;
    for I in 31 downto 0 loop  -- MSB first
    	wait until falling_edge(tb_clk_BIT);
    	tb_DIN <= DIN_stimulus_2(I);
    end loop;
end loop;
wait for bit_time;
tb_DIN <= 'U';
wait for 132*bit_time;
assert false report "end of simulation" severity failure;
end process;
	

end architecture testbench;