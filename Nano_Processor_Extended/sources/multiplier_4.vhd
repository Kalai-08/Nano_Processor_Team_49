library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity Multiplier_4 is
 Port ( A : in STD_LOGIC_VECTOR (3 downto 0);
        B : in STD_LOGIC_VECTOR (3 downto 0);
        Y : out STD_LOGIC_VECTOR (3 downto 0));
end Multiplier_4;

architecture Behavioral of Multiplier_4 is
    
signal Product : unsigned(7 downto 0);

begin
    Product <= unsigned(A) * unsigned(B);
    Y <= std_logic_vector(Product(3 downto 0));
end Behavioral;
