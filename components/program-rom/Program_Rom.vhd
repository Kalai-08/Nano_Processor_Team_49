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

-- TASK 01 : Instructions as in Moodle

--    "101110001010", --0 Movi R7, 10
--    "100100000001", --1 Movi R2, 1
--    "010100000000", --2 Neg  R2
--    "001110100000", --3 Add  R7, R2
--    "111110000111", --4 JZR R7, 7
--    "110000000011", --5 JZR R0, 3
--    "000000000000", --6 
--    "000000000000"  --7 

-- TASK 02 : Write an Assembly program to calculate the total of all integers between 1 and 3
    
    "100010000001", --0 Movi R1, 1
    "100100000010", --1 Movi R2, 2
    "001110010000", --2 Add  R7, R1
    "001110100000", --3 Add  R7, R2
    "100110000011", --4 Movi R3, 3
    "001110110000", --5 Add  R7, R3
    "100010000000", --6 Movi R1, 0
    "110000000111"  --7 
    
);

begin

    Ins_Bus <= sevenSegment_ROM(to_integer(unsigned(Mem_Sel)));

end Behavioral;