
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Mux_2_to_1_4bit is
    Port ( S : in STD_LOGIC;
           A : in STD_LOGIC_VECTOR (3 downto 0);
           B : in STD_LOGIC_VECTOR (3 downto 0);
           X : out STD_LOGIC_VECTOR (3 downto 0));
end Mux_2_to_1_4bit;

architecture Behavioral of Mux_2_to_1_4bit is

begin
      X <= B when (S='1') else A;

end Behavioral;
