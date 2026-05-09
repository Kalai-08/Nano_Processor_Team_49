library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all; 

entity Program_ROM is
    Port (
        Mem_Sel : in STD_LOGIC_VECTOR (2 downto 0);
        Ins_Bus : out STD_LOGIC_VECTOR (11 downto 0)
    );
end Program_ROM;

architecture Behavioral of Program_ROM is

type rom_type is array (0 to 7) of std_logic_vector(11 downto 0);
 
signal sevenSegment_ROM : rom_type := (

-- FIRST ABS DIFF TEST, THEN MULTIPLY TEST

   "101110000100", --0 Movi R7, 4
   "100100000100", --1 Movi R2, 4
   "101110001000", --2 Movi R7, 8
   "001110101111", --3 AbsDiff R7, R2 => R7 = |8 - 4| = 4
   "101110000101", --4 Movi R7, 5
   "100100000101", --5 Movi R2, 5
   "101110000010", --6 Movi R7, 2
   "001110101110"  --7 Mul R7, R2 => R7 = 2 * 5 = A

    
);

begin

    Ins_Bus <= sevenSegment_ROM(to_integer(unsigned(Mem_Sel)));

end Behavioral;
