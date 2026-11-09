------------------------------------------------------------------
--
-- [IE3-DI] Digital Circuits 
--
-- @name:   addsub.vhd
-- @author: tottale
-- @description: Adder-Subtractor Unit with Status Flags
--               DESIGN FILE
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
entity addsub is
    port(   
        A    : IN  std_logic_vector(7 downto 0);    -- Operand A (bitwidth 8)
        B    : IN  std_logic_vector(7 downto 0);    -- Operand B (bitwidth 8)
        sel  : IN  std_logic;                       -- Operation select: 0 = Add, 1 = Sub
        sel2  : IN  std_logic;

        S    : OUT std_logic_vector(7 downto 0);    -- Result Sum/Difference (bitwidth 8)
        C    : OUT std_logic;                       -- Carry flag (Unsigned overflow)
        V    : OUT std_logic;                       -- Overflow flag (Signed overflow)
        N    : OUT std_logic;                       -- Negative flag
        Z    : OUT std_logic                        -- Zero flag
        );
end entity;

---------------------------------
-- architecture
architecture rtl of addsub is
begin

---------------------------------
-- combinatorial process
addsub_proc: process(A, B, sel)

-- variable declarations
variable c_v   : std_logic;
variable S_v   : std_logic_vector(7 downto 0);
variable A_v   : std_logic_vector(7 downto 0);
variable B_v   : std_logic_vector(7 downto 0);
variable c7_v  : std_logic;                    -- Temporary storage for carry-in to bit 7

begin
    -- 1. variable assignment & multiplexer logic (Fig. 7)
    A_v := A;
    
    if (sel = '0') then
        B_v := B;        -- Addition mode: pass B unmodified
        c_v := '0';      -- Addition mode: initial carry-in is 0
    else
        B_v := not B;    -- Subtraction mode: bitwise inversion of B (1's complement)
        c_v := '1';      -- Subtraction mode: set initial carry-in to 1 (2's complement)
    end if;
    
    -- 2. data processing: ripple-carry adder
    for i in 0 to 7 loop
        -- Capture the carry-in to the 7th bit for overflow calculation
        if (i = 7) then
            c7_v := c_v;
        end if;

        S_v(i) := A_v(i) xor B_v(i) xor c_v;
        c_v    := (A_v(i) and B_v(i)) or (B_v(i) and c_v) or (A_v(i) and c_v);
    end loop;
    
    -- 3. signal assignment & status flags generation (Tab. 1)
    S <= S_v;
    
    -- C = co (Final carry-out from the MSB addition)
    C <= c_v; 
    
    -- V = co xor c7
    V <= c_v xor c7_v; 
    
    -- N = S(7) (Sign bit of the result)
    N <= S_v(7); 
    
    -- Z = 1 if result is zero, else 0
    
    
    if (S_v = "00000000") then
        Z <= '1';
    else
        Z <= '0';
    end if;

end process;

end architecture rtl;