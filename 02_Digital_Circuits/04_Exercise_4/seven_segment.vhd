------------------------------------------------------------------
--
-- [IE3-DI] Digital Circuits 
--			Exercise 4
--
-- @name:   seven_segment.vhd
-- @author: 
-- @description: control unit for the seven segment display of the 
--               basys 3 board
--				 DESIGN FILE
--
-- (c) 2025 HAW Hamburg
--
-- @changelog
-- 25-11-10 initial implementation
--
------------------------------------------------------------------

---------------------------------------------
-- libraries
library ieee;
use ieee.std_logic_1164.all;
use IEEE.NUMERIC_STD.all;

---------------------------------------------
-- entity
entity seven_segment is
    Port ( clk : in STD_LOGIC;
           rst : in STD_LOGIC;
           
           LEDs : out STD_LOGIC_VECTOR(7 downto 0);
           DIGIT_select : out STD_LOGIC_VECTOR(3 downto 0);
           SW : in STD_LOGIC_VECTOR(7 downto 0)
           );
end seven_segment;


---------------------------------------------
-- architecture
architecture rtl of seven_segment is


---------------------------------------------
-- signal declaration
signal ctr_cs : unsigned(19 downto 0);
signal ctr_ns : unsigned(19 downto 0);
signal SW0 : STD_LOGIC;
signal SW1 : STD_LOGIC;
signal SW2 : STD_LOGIC;
signal SW3 : STD_LOGIC;

-- PREPARATION: Update the bit patterns of the constants for the 7-segment LEDs
constant ZERO : std_logic_vector(7 downto 0)  := "11000000";
constant ONE : std_logic_vector(7 downto 0)   := "11111001";
constant TWO : std_logic_vector(7 downto 0)   := "10100100";
constant THREE : std_logic_vector(7 downto 0) := "10110000";
constant FOUR : std_logic_vector(7 downto 0)  := "10011001";
constant FIVE : std_logic_vector(7 downto 0)  := "10010010";
constant SIX : std_logic_vector(7 downto 0)   := "10000010";
constant SEVEN : std_logic_vector(7 downto 0) := "11111000";
constant EIGHT : std_logic_vector(7 downto 0) := "10000000";
constant NINE : std_logic_vector(7 downto 0)  := "10010000";

begin
-- T2.1 

---------------------------------
-- synchronous process
sync : process (clk, rst)
begin
-- asynchronous reset
    if rst = '1' then
        ctr_cs <= (others =>'0');
        SW0 <= '0';
        SW1 <= '0';
        SW2 <= '0';
        SW3 <= '0';
-- rising clock edge
    elsif rising_edge(clk) then 
        ctr_cs <= ctr_ns;
-- setting switch values
    SW0 <= SW(0);
    SW1 <= SW(1);
    SW2 <= SW(2);
    SW3 <= SW(3);
end if;
end process sync;


-- combinatorial process
comb : process (ctr_cs)
variable ctr_v : unsigned(19 downto 0);
 begin
 -- 1. variable assignment
 ctr_v := ctr_cs;
 -- 2. data processing
 ctr_v := (ctr_v + 1);
 -- 3. signal assignment
 ctr_ns <= ctr_v;
end process comb;


---------------------------------
-- combinatorial process (lambda)
lambda : process (ctr_cs, SW0, SW1, SW2, SW3)
-- variables
    variable hsb : unsigned(1 downto 0);
begin
    hsb := ctr_cs(19 downto 18);
    case hsb is
        when "00" =>
          LEDs <= ZERO;
          DIGIT_select <= "1110";    
          -- defualt, when switch four is on
          if SW(4) = '1' then
             LEDs <= TWO;
          end if;
          -- when switch SW0 is on
          if SW0 = '1' then
            LEDs <= FOUR;
            if SW(4) = '1' then
              LEDs <= SIX;
            end if;
          end if;     
        when "01" => 
          LEDs <= ONE;
          DIGIT_select <= "1101";       
          -- defualt, when switch four is on
          if SW(4) = '1' then
             LEDs <= THREE;
          end if;
          
          if SW1 = '1' then
            LEDs <= FIVE;
            if SW(4) = '1' then
              LEDs <= SEVEN;
            end if;
          end if;
          
        when "10" => 
          LEDs <= TWO;
          DIGIT_select <= "1011";       
          -- defualt, when switch four is on
          if SW(4) = '1' then
             LEDs <= FOUR;
          end if;   
          
          if SW2 = '1' then
            LEDs <= SIX;
            if SW(4) = '1' then
              LEDs <= EIGHT;
            end if;
          end if;
          
        when "11" => 
          LEDs <= THREE;
          DIGIT_select <= "0111";          
          -- defualt, when switch four is on
          if SW(4) = '1' then
             LEDs <= FIVE;
          end if;
          
          if SW3 = '1' then
            LEDs <= SEVEN;
            if SW(4) = '1' then
              LEDs <= NINE;
            end if;
          end if;
    end case;
end process;

end rtl;