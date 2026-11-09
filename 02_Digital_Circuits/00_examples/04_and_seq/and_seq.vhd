library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity and_seq is
    GENERIC (
    DWIDTH : integer := 1
    );
    Port ( 
        clk  : in  STD_LOGIC;
        rst  : in  STD_LOGIC;
        din0 : in  STD_LOGIC_VECTOR(DWIDTH-1 downto 0);
        din1 : in  STD_LOGIC_VECTOR(DWIDTH-1 downto 0);
        dout : out STD_LOGIC_VECTOR(DWIDTH-1 downto 0)
    );
end and_seq;

architecture rtl of and_seq is
    -- signal dff_ns : std_logic;
    signal dff_cs : std_logic;
begin

    -- [Sequeancal] 
    sync: process(clk, rst)
    begin
        if (rst = '1') then
            dff_cs <= (others => '0');
        elsif (rising_edge(clk)) then
            dff_cs <= din0 and din1; 
        end if;
    end process;

end rtl;